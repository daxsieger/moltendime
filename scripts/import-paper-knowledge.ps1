param(
    [Parameter(Mandatory = $true)]
    [string]$PaperUrl,
    [string]$BundleName = "",
    [string]$DestinationRoot = ".ai/paper-imports",
    [string]$KnowledgeHostRepoUrl = "",
    [switch]$Force
)

function Ensure-Directory {
    param([string]$Path)

    if (-not (Test-Path -LiteralPath $Path)) {
        New-Item -ItemType Directory -Path $Path | Out-Null
    }
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

function Get-ArxivId {
    param([string]$Value)

    $match = [regex]::Match($Value, '\d{4}\.\d{5}')
    if ($match.Success) {
        return $match.Value
    }

    return ''
}

function Convert-ToSlug {
    param([string]$Value)

    $lowered = $Value.ToLowerInvariant()
    $normalized = [regex]::Replace($lowered, '[^a-z0-9]+', '-')
    return $normalized.Trim('-')
}

function Decode-HtmlText {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return ''
    }

    $decoded = [System.Net.WebUtility]::HtmlDecode($Value)
    $decoded = [regex]::Replace($decoded, '<[^>]+>', ' ')
    $decoded = [regex]::Replace($decoded, '\s+', ' ')
    return $decoded.Trim()
}

function Get-FirstRegexValue {
    param(
        [string]$Text,
        [string[]]$Patterns
    )

    foreach ($pattern in $Patterns) {
        $match = [regex]::Match($Text, $pattern, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase -bor [System.Text.RegularExpressions.RegexOptions]::Singleline)
        if ($match.Success) {
            return (Decode-HtmlText -Value $match.Groups[1].Value)
        }
    }

    return ''
}

function Invoke-WebText {
    param([string]$Url)

    try {
        return (Invoke-WebRequest -Uri $Url).Content
    }
    catch {
        return ''
    }
}

function Get-PaperMetadata {
    param([string]$SourceUrl)

    $arxivId = Get-ArxivId -Value $SourceUrl
    $arxivAbsUrl = if ($arxivId) { "https://arxiv.org/abs/$arxivId" } else { '' }
    $arxivHtmlUrl = if ($arxivId) { "https://arxiv.org/html/${arxivId}v1" } else { '' }
    $sourceUrls = New-Object System.Collections.Generic.List[string]
    $sourceUrls.Add($SourceUrl)
    if ($arxivAbsUrl -and -not $sourceUrls.Contains($arxivAbsUrl)) { $sourceUrls.Add($arxivAbsUrl) }
    if ($arxivHtmlUrl -and -not $sourceUrls.Contains($arxivHtmlUrl)) { $sourceUrls.Add($arxivHtmlUrl) }

    $pages = @{}
    foreach ($url in $sourceUrls) {
        $pages[$url] = Invoke-WebText -Url $url
    }

    $primaryText = ''
    if ($arxivAbsUrl -and $pages[$arxivAbsUrl]) {
        $primaryText = $pages[$arxivAbsUrl]
    }
    elseif ($pages[$SourceUrl]) {
        $primaryText = $pages[$SourceUrl]
    }

    $secondaryText = ''
    if ($arxivHtmlUrl -and $pages[$arxivHtmlUrl]) {
        $secondaryText = $pages[$arxivHtmlUrl]
    }

    $title = Get-FirstRegexValue -Text $primaryText -Patterns @(
        '<title>\s*(.*?)\s*</title>',
        '<meta[^>]+property="og:title"[^>]+content="([^"]+)"',
        '<h1[^>]*>(.*?)</h1>'
    )
    $title = [regex]::Replace($title, '^\[\d{4}\.\d{5}\]\s*', '')
    if ($title -match '^arXiv:\d{4}\.\d{5}\s+(.*)$') {
        $title = $Matches[1].Trim()
    }

    $abstract = Get-FirstRegexValue -Text $primaryText -Patterns @(
        '<blockquote[^>]*abstract[^>]*>.*?<span[^>]*>Abstract:</span>(.*?)</blockquote>',
        '<meta[^>]+name="description"[^>]+content="([^"]+)"',
        '## Abstract\s+(.*?)\s+(?:##|###|\[View)' 
    )
    if ([string]::IsNullOrWhiteSpace($abstract) -and $secondaryText) {
        $abstract = Get-FirstRegexValue -Text $secondaryText -Patterns @(
            '###### Abstract\s+(.*?)\s+(?:##|###|Figure)',
            '<meta[^>]+name="description"[^>]+content="([^"]+)"'
        )
    }

    return [ordered]@{
        arxivId = $arxivId
        sourceUrl = $SourceUrl
        arxivAbsUrl = $arxivAbsUrl
        arxivHtmlUrl = $arxivHtmlUrl
        title = $title
        abstract = $abstract
        sourceUrls = @($sourceUrls)
    }
}

$metadata = Get-PaperMetadata -SourceUrl $PaperUrl
$slug = if ([string]::IsNullOrWhiteSpace($BundleName)) {
    if ($metadata.arxivId) {
        if (-not [string]::IsNullOrWhiteSpace($metadata.title)) {
            (Convert-ToSlug -Value (($metadata.title -replace ':', '') + '-arxiv-' + $metadata.arxivId))
        }
        else {
            "paper-arxiv-$($metadata.arxivId)"
        }
    }
    else {
        $leaf = (($PaperUrl.TrimEnd('/').Split('/') | Select-Object -Last 1))
        Convert-ToSlug -Value $leaf
    }
}
else {
    $BundleName
}

$bundlePath = Join-Path $DestinationRoot $slug
$hostRepoUrl = Get-KnowledgeHostRepoUrl -Override $KnowledgeHostRepoUrl

Ensure-Directory -Path $DestinationRoot
if ((Test-Path -LiteralPath $bundlePath) -and (-not $Force)) {
    throw "Bundle path '$bundlePath' already exists. Use -Force to overwrite its files."
}
Ensure-Directory -Path $bundlePath

$title = if ([string]::IsNullOrWhiteSpace($metadata.title)) { 'title not extracted' } else { $metadata.title }
$abstract = if ([string]::IsNullOrWhiteSpace($metadata.abstract)) { 'abstract not extracted' } else { $metadata.abstract }
$bundleType = 'academic-paper'

$skillsContent = @(
    "# Bundle: $slug",
    '',
    "- source_paper: $PaperUrl",
    "- source_html: $(if ($metadata.arxivHtmlUrl) { $metadata.arxivHtmlUrl } else { 'not detected' })",
    "- title: $title",
    '- generated_for_persona: paper-skill-learner',
    '- tracked_by_persona: ai-rule-learner',
    "- bundle_type: $bundleType",
    '',
    '## Imported Research Assets',
    ''
)
$skillsContent += $metadata.sourceUrls | ForEach-Object { "- $_" }
$skillsContent += @(
    '',
    '## First-Level Persona Skills',
    '',
    '- The dedicated paper persona is the receptacle for paper-specific first-level research skills.',
    '- System personas such as `ai-rule-learner` should index and track these skills, not replace the paper persona as their runtime owner.',
    '- This scaffold bundle should be refined into evidence-backed skill packs after reviewing methods, evaluation, and appendices.',
    '',
    '## Inferred Reusable Skills',
    '',
    '### 1. Academic import workflow',
    '',
    '- Read abstract, methods, evaluation, ablations, and appendices before extracting skills.',
    '- Keep claims, mechanisms, and implementation-transfer lessons in separate sections.',
    '- Use the paper-dedicated persona as the runtime owner of the extracted skills.'
)

$memoriesContent = @(
    "# $slug Memory Notes",
    '',
    "- Paper URL: $PaperUrl",
    "- arXiv URL: $(if ($metadata.arxivAbsUrl) { $metadata.arxivAbsUrl } else { 'not detected' })",
    "- HTML URL: $(if ($metadata.arxivHtmlUrl) { $metadata.arxivHtmlUrl } else { 'not detected' })",
    "- Title: $title",
    "- Abstract summary: $abstract",
    '- Ownership note: extracted paper skills belong operationally to the dedicated paper persona.',
    '- Archivist note: system archivists should catalog the paper bundle and persona for discovery and audit.'
)

$technicalDocsContent = @(
    "# $title Technical Notes",
    '',
    '## Summary',
    '',
    'This file is a generated technical note scaffold for an academic paper bundle. It should be refined after reviewing the primary paper sections and supplementary material.',
    '',
    '## Abstract Preview',
    '',
    $abstract
)

$sourcesContent = @(
    "# $slug Sources",
    '',
    "- imported_at: $(Get-Date -Format 'yyyy-MM-dd')",
    "- bundle_kind: $bundleType",
    "- knowledge_host_repo: $hostRepoUrl",
    '',
    '## Source URLs',
    ''
)
$sourcesContent += $metadata.sourceUrls | ForEach-Object { "- $_" }

Set-Content -LiteralPath (Join-Path $bundlePath 'skills.md') -Value ($skillsContent -join [Environment]::NewLine)
Set-Content -LiteralPath (Join-Path $bundlePath 'skills-index.md') -Value ("# $title Skill Index" + [Environment]::NewLine + [Environment]::NewLine + '- extracted_skill_count: 0' + [Environment]::NewLine + '- status: scaffold')
Set-Content -LiteralPath (Join-Path $bundlePath 'memories.md') -Value ($memoriesContent -join [Environment]::NewLine)
Set-Content -LiteralPath (Join-Path $bundlePath 'technical-docs.md') -Value ($technicalDocsContent -join [Environment]::NewLine)
Set-Content -LiteralPath (Join-Path $bundlePath 'sources.md') -Value ($sourcesContent -join [Environment]::NewLine)

[ordered]@{
    paper = $PaperUrl
    bundle = $slug
    bundlePath = $bundlePath.Replace('\\', '/')
    bundleType = $bundleType
    title = $title
    arxivId = $metadata.arxivId
    sourceUrlCount = $metadata.sourceUrls.Count
} | ConvertTo-Json -Depth 10