param(
    [string]$RepoPath = ".",
    [string]$PersonaName = "",
    [string]$OutputRoot = ".ai/persona-knowledge"
)

function Get-RelativeRepoPath {
    param(
        [string]$BasePath,
        [string]$TargetPath
    )

    $baseUri = [System.Uri]((Resolve-Path -LiteralPath $BasePath).Path.TrimEnd('\') + '\')
    $targetUri = [System.Uri](Resolve-Path -LiteralPath $TargetPath).Path
    return [System.Uri]::UnescapeDataString($baseUri.MakeRelativeUri($targetUri).ToString()).Replace('/', '\')
}

function Get-ContentSha256 {
    param([string]$Text)

    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
        $hash = $sha.ComputeHash($bytes)
        return ([System.BitConverter]::ToString($hash)).Replace('-', '').ToLowerInvariant()
    }
    finally {
        $sha.Dispose()
    }
}

function Get-PersonaNameFromBranch {
    $branchName = (git branch --show-current).Trim()
    if ($branchName -match '^persona/(.+)$') {
        return $matches[1]
    }

    return ""
}

function Test-PersonaMatch {
    param(
        [string]$RelativePath,
        [string]$PersonaSlug
    )

    $escapedSlug = [regex]::Escape($PersonaSlug)
    return $RelativePath -match "(^|[\\/])$escapedSlug([.\\/_-]|$)"
}

$resolvedRepoPath = Resolve-Path -LiteralPath $RepoPath -ErrorAction Stop

Push-Location $resolvedRepoPath
try {
    if ([string]::IsNullOrWhiteSpace($PersonaName)) {
        $PersonaName = Get-PersonaNameFromBranch
    }

    if ([string]::IsNullOrWhiteSpace($PersonaName)) {
        $result = [ordered]@{
            continue = $true
            systemMessage = "No persona branch detected; skipped persona knowledge sync"
        }
        $result | ConvertTo-Json -Depth 10
        return
    }

    $candidateRoots = @('.ai', '.github', '.claude', '.cursor')
    $sourceFiles = New-Object System.Collections.Generic.List[object]

    foreach ($root in $candidateRoots) {
        if (-not (Test-Path -LiteralPath $root)) {
            continue
        }

        Get-ChildItem -LiteralPath $root -Recurse -File | ForEach-Object {
            $relativePath = (Get-RelativeRepoPath -BasePath (Get-Location).Path -TargetPath $_.FullName).Replace('\', '/')
            if ($relativePath -like '.ai/persona-knowledge/*' -or $relativePath -like '.ai/rule-archive/db-state/*') {
                return
            }

            if (Test-PersonaMatch -RelativePath $relativePath -PersonaSlug $PersonaName) {
                $sourceFiles.Add([ordered]@{
                    relative_path = $relativePath
                    full_path = $_.FullName
                })
            }
        }
    }

    $distinctFiles = $sourceFiles | Sort-Object relative_path -Unique
    $personaOutputRoot = Join-Path $OutputRoot $PersonaName
    $snapshotsRoot = Join-Path $personaOutputRoot 'sources'
    if (-not (Test-Path -LiteralPath $snapshotsRoot)) {
        New-Item -ItemType Directory -Path $snapshotsRoot -Force | Out-Null
    }

    $existingSnapshotFiles = @()
    if (Test-Path -LiteralPath $snapshotsRoot) {
        $existingSnapshotFiles = Get-ChildItem -LiteralPath $snapshotsRoot -Recurse -File
    }

    $currentBranch = (git branch --show-current).Trim()
    $manifestEntries = foreach ($file in $distinctFiles) {
        $content = Get-Content -LiteralPath $file.full_path -Raw
        $contentHash = Get-ContentSha256 -Text $content
        $snapshotPath = Join-Path $snapshotsRoot ($file.relative_path -replace '/', '\')
        $snapshotDirectory = Split-Path -Path $snapshotPath -Parent
        if (-not (Test-Path -LiteralPath $snapshotDirectory)) {
            New-Item -ItemType Directory -Path $snapshotDirectory -Force | Out-Null
        }

        $snapshotBody = @(
            '---'
            "persona: $PersonaName"
            "branch: $currentBranch"
            "source_path: $($file.relative_path)"
            "source_sha256: $contentHash"
            '---'
            ''
            $content.TrimEnd("`r", "`n")
            ''
        ) -join [Environment]::NewLine
        Set-Content -LiteralPath $snapshotPath -Value $snapshotBody

        [ordered]@{
            source_path = $file.relative_path
            snapshot_path = (Get-RelativeRepoPath -BasePath (Get-Location).Path -TargetPath $snapshotPath).Replace('\', '/')
            source_sha256 = $contentHash
        }
    }

    $expectedSnapshotPaths = @($manifestEntries | ForEach-Object { $_.snapshot_path })
    foreach ($existingSnapshot in $existingSnapshotFiles) {
        $existingRelative = (Get-RelativeRepoPath -BasePath (Get-Location).Path -TargetPath $existingSnapshot.FullName).Replace('\', '/')
        if ($expectedSnapshotPaths -notcontains $existingRelative) {
            Remove-Item -LiteralPath $existingSnapshot.FullName -Force
        }
    }

    Get-ChildItem -LiteralPath $snapshotsRoot -Directory -Recurse |
        Sort-Object FullName -Descending |
        ForEach-Object {
            if (-not (Get-ChildItem -LiteralPath $_.FullName -Force)) {
                Remove-Item -LiteralPath $_.FullName -Force
            }
        }

    $knowledgeHashInput = @($manifestEntries | Sort-Object source_path | ForEach-Object { "$($_.source_path):$($_.source_sha256)" }) -join "`n"
    $knowledgeHash = Get-ContentSha256 -Text $knowledgeHashInput

    $manifestPath = Join-Path $personaOutputRoot 'manifest.json'
    $manifest = [ordered]@{
        persona = $PersonaName
        branch = $currentBranch
        knowledge_hash = $knowledgeHash
        source_count = @($manifestEntries).Count
        sources = @($manifestEntries | Sort-Object source_path)
    }

    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    $manifest | ConvertTo-Json -Depth 10
}
finally {
    Pop-Location
}