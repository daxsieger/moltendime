param(
    [Parameter(Mandatory = $true)]
    [string]$RepoUrl,
    [string]$BundleName = "",
    [string]$DestinationRoot = ".ai/repo-imports",
    [string]$KnowledgeHostRepoUrl = "",
    [string]$Branch = "",
    [switch]$Force
)

function Get-RepoSlug {
    param([string]$Value)

    $trimmed = $Value.Trim().TrimEnd('/')
    if ($trimmed.EndsWith('.git')) {
        $trimmed = $trimmed.Substring(0, $trimmed.Length - 4)
    }

    $segments = $trimmed.Split('/') | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
    if ($segments.Count -eq 0) {
        throw "Unable to derive repository slug from '$Value'."
    }

    return $segments[$segments.Count - 1].ToLowerInvariant()
}

function Get-KnowledgeHostRepoUrl {
    param([string]$Override)

    if (-not [string]::IsNullOrWhiteSpace($Override)) {
        return $Override.Trim()
    }

    $remoteUrl = git remote get-url origin 2>$null
    if ($LASTEXITCODE -eq 0 -and -not [string]::IsNullOrWhiteSpace($remoteUrl)) {
        return $remoteUrl.Trim().TrimEnd('.git')
    }

    return 'https://github.com/OWNER/KNOWLEDGE-HOST-REPO'
}

function Get-PrimaryReadmePath {
    param([string]$RepositoryRoot)

    $preferred = Join-Path $RepositoryRoot 'README.md'
    if (Test-Path -LiteralPath $preferred) {
        return $preferred
    }

    $fallback = Get-ChildItem -LiteralPath $RepositoryRoot -Filter 'README*' -File | Select-Object -First 1
    return $fallback.FullName
}

function Get-TextPreview {
    param(
        [string]$Path,
        [int]$MaxLines = 80
    )

    if (-not (Test-Path -LiteralPath $Path)) {
        return ''
    }

    return ((Get-Content -LiteralPath $Path -TotalCount $MaxLines) -join [Environment]::NewLine).Trim()
}

function Get-DocumentationFiles {
    param([string]$RepositoryRoot)

    $excluded = @('node_modules', 'dist', 'build', '.git')
    return Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -File |
        Where-Object {
            $_.Extension -in @('.md', '.mdc', '.txt') -and
            ($_.FullName.Split([System.IO.Path]::DirectorySeparatorChar) | Where-Object { $excluded -contains $_ }).Count -eq 0
        } |
        ForEach-Object {
            [System.IO.Path]::GetRelativePath($RepositoryRoot, $_.FullName).Replace('\\', '/')
        } |
        Sort-Object
}

function Get-ExplicitAiAssets {
    param([string]$RepositoryRoot)

    $assetNames = @('AGENTS.md', 'CLAUDE.md', 'copilot-instructions.md', 'SKILL.md')
    $excluded = @('node_modules', 'dist', 'build', '.git')

    return Get-ChildItem -LiteralPath $RepositoryRoot -Recurse -File |
        Where-Object {
            $assetNames -contains $_.Name -and
            ($_.FullName.Split([System.IO.Path]::DirectorySeparatorChar) | Where-Object { $excluded -contains $_ }).Count -eq 0
        } |
        ForEach-Object {
            [System.IO.Path]::GetRelativePath($RepositoryRoot, $_.FullName).Replace('\\', '/')
        } |
        Sort-Object
}

function Get-PackageMetadata {
    param([string]$RepositoryRoot)

    $packagePath = Join-Path $RepositoryRoot 'package.json'
    if (-not (Test-Path -LiteralPath $packagePath)) {
        return $null
    }

    return Get-Content -LiteralPath $packagePath -Raw | ConvertFrom-Json
}

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
}

$slug = if ([string]::IsNullOrWhiteSpace($BundleName)) { Get-RepoSlug -Value $RepoUrl } else { $BundleName }
$hostRepoUrl = Get-KnowledgeHostRepoUrl -Override $KnowledgeHostRepoUrl
$tempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ('repo-knowledge-' + [guid]::NewGuid().ToString('N'))
$clonePath = Join-Path $tempRoot $slug
$bundlePath = Join-Path $DestinationRoot $slug

try {
    Ensure-Directory -Path $tempRoot
    Ensure-Directory -Path $DestinationRoot

    if ((Test-Path -LiteralPath $bundlePath) -and (-not $Force)) {
        throw "Bundle path '$bundlePath' already exists. Use -Force to overwrite its files."
    }
    Ensure-Directory -Path $bundlePath

    $cloneArgs = @('clone', '--depth', '1')
    if (-not [string]::IsNullOrWhiteSpace($Branch)) {
        $cloneArgs += @('--branch', $Branch)
    }
    $cloneArgs += @($RepoUrl, $clonePath)
    git @cloneArgs | Out-Null
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to clone '$RepoUrl'."
    }

    $readmePath = Get-PrimaryReadmePath -RepositoryRoot $clonePath
    $readmePreview = Get-TextPreview -Path $readmePath -MaxLines 120
    $packageMetadata = Get-PackageMetadata -RepositoryRoot $clonePath
    $documentationFiles = @(Get-DocumentationFiles -RepositoryRoot $clonePath)
    $explicitAiAssets = @(Get-ExplicitAiAssets -RepositoryRoot $clonePath)

    $repoType = if ($packageMetadata) { 'JavaScript or TypeScript application/library' } else { 'repository with no detected package.json' }
    $devCommand = if ($packageMetadata -and $packageMetadata.scripts.dev) { [string]$packageMetadata.scripts.dev } else { 'not detected' }
    $buildCommand = if ($packageMetadata -and $packageMetadata.scripts.build) { [string]$packageMetadata.scripts.build } else { 'not detected' }
    $packageName = if ($packageMetadata -and $packageMetadata.name) { [string]$packageMetadata.name } else { 'not detected' }
    $bundleKind = if ($explicitAiAssets.Count -gt 0) { 'mixed' } else { 'inferred' }

    $skillsContent = @(
        "# Bundle: $slug",
        '',
        "- source_repo: $RepoUrl",
        "- knowledge_host_repo: $hostRepoUrl",
        "- bundle_type: $bundleKind",
        "- generated_for_persona: repo-skill-learner",
        '',
        '## Imported Explicit AI Assets',
        ''
    )

    if ($explicitAiAssets.Count -gt 0) {
        $skillsContent += $explicitAiAssets | ForEach-Object { "- $_" }
    }
    else {
        $skillsContent += '- No explicit AI customization files were detected during import.'
    }

    $skillsContent += @(
        '',
        '## Inferred Reusable Skills',
        '',
        '### 1. Repository bootstrap',
        '',
        '- Read the primary README first.',
        "- Development command: $devCommand",
        "- Build command: $buildCommand",
        '- Capture additional setup requirements from the listed documentation files.',
        '',
        '### 2. Technical knowledge extraction',
        '',
        '- Convert the documentation set into concise memory notes and operational summaries.',
        '- Treat package metadata and public source entrypoints as stable anchors for inferred workflows.',
        '- Mark all inferred content explicitly when explicit AI assets are missing.'
    )

    $memoriesContent = @(
        "# $slug Memory Notes",
        '',
        "- Repository URL: $RepoUrl",
        "- Knowledge host repository: $hostRepoUrl",
        "- Project type: $repoType",
        "- Package name: $packageName",
        "- Development command: $devCommand",
        "- Build command: $buildCommand",
        "- Bundle quality: $bundleKind",
        '- This memory file is generated from repository metadata and documentation previews.'
    )

    $technicalDocsContent = @(
        "# $slug Technical Notes",
        '',
        '## Summary',
        '',
        'This file is a generated technical note scaffold. It should be refined after reviewing the repository source and key documentation.',
        '',
        '## README Preview',
        '',
        $readmePreview
    )

    $sourcesContent = @(
        "# $slug Bundle Sources",
        '',
        "- repository: $RepoUrl",
        "- imported_at: $(Get-Date -Format 'yyyy-MM-dd')",
        "- bundle_kind: $bundleKind",
        '',
        '## Explicit AI Assets',
        ''
    )
    if ($explicitAiAssets.Count -gt 0) {
        $sourcesContent += $explicitAiAssets | ForEach-Object { "- $_" }
    }
    else {
        $sourcesContent += '- none detected'
    }
    $sourcesContent += @(
        '',
        '## Documentation Files',
        ''
    )
    if ($documentationFiles.Count -gt 0) {
        $sourcesContent += $documentationFiles | ForEach-Object { "- $_" }
    }
    else {
        $sourcesContent += '- none detected'
    }

    $bridgeContent = @(
        '---',
        "name: $slug-knowledge-bridge",
        "description: 'Use when an external repository needs to load the $slug knowledge bundle from the canonical knowledge host repository.'",
        "argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'",
        'user-invocable: true',
        '---',
        '',
        "# $slug Knowledge Bridge",
        '',
        '## Canonical Reference',
        '',
        "- knowledge_host_repo: $hostRepoUrl",
        "- bundle_name: $slug",
        '- maintained_by_agent: Repo Skill Learner',
        '',
        '## Load Sequence',
        '',
        "1. Open `$hostRepoUrl`.",
        "2. Read `.ai/repo-imports/$slug/skills.md`.",
        "3. Read `.ai/repo-imports/$slug/memories.md`.",
        "4. Read `.ai/repo-imports/$slug/technical-docs.md`.",
        "5. Read `.ai/repo-imports/$slug/sources.md`.",
        '6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.'
    )

    Set-Content -LiteralPath (Join-Path $bundlePath 'skills.md') -Value ($skillsContent -join [Environment]::NewLine)
    Set-Content -LiteralPath (Join-Path $bundlePath 'memories.md') -Value ($memoriesContent -join [Environment]::NewLine)
    Set-Content -LiteralPath (Join-Path $bundlePath 'technical-docs.md') -Value ($technicalDocsContent -join [Environment]::NewLine)
    Set-Content -LiteralPath (Join-Path $bundlePath 'sources.md') -Value ($sourcesContent -join [Environment]::NewLine)
    Set-Content -LiteralPath (Join-Path $bundlePath 'external-bridge-skill.md') -Value ($bridgeContent -join [Environment]::NewLine)

    [ordered]@{
        repo = $RepoUrl
        bundle = $slug
        bundlePath = $bundlePath.Replace('\\', '/')
        bundleType = $bundleKind
        knowledgeHostRepo = $hostRepoUrl
        explicitAiAssetCount = $explicitAiAssets.Count
        documentationFileCount = $documentationFiles.Count
    } | ConvertTo-Json -Depth 10
}
finally {
    if (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force
    }
}
