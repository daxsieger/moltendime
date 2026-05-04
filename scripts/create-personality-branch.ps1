param(
    [Parameter(Mandatory = $true)]
    [string]$PersonalityName,
    [string]$BaseBranch = "main",
    [switch]$Checkout
)

function Get-Slug {
    param([string]$Value)

    $slug = $Value.ToLowerInvariant()
    $slug = [System.Text.RegularExpressions.Regex]::Replace($slug, '[^a-z0-9]+', '-')
    $slug = $slug.Trim('-')
    if ([string]::IsNullOrWhiteSpace($slug)) {
        throw "Personality name must contain at least one alphanumeric character."
    }
    return $slug
}

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $insideRepo -ne 'true') {
    throw "The workspace is not a git repository."
}

$slug = Get-Slug -Value $PersonalityName
$branchName = "persona/$slug"

git rev-parse --verify $BaseBranch 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Base branch '$BaseBranch' does not exist."
}

git show-ref --verify --quiet "refs/heads/$branchName"
if ($LASTEXITCODE -ne 0) {
    git branch $branchName $BaseBranch | Out-Null
}

$personalityPath = Join-Path ".ai\personalities" "$slug.md"
if (-not (Test-Path -LiteralPath ".ai")) {
    New-Item -ItemType Directory -Path ".ai" | Out-Null
}
if (-not (Test-Path -LiteralPath ".ai\personalities")) {
    New-Item -ItemType Directory -Path ".ai\personalities" | Out-Null
}
if (-not (Test-Path -LiteralPath ".ai\SHARED_LEARNINGS.md")) {
    Set-Content -LiteralPath ".ai\SHARED_LEARNINGS.md" -Value "# Shared Learnings`r`n`r`n## Entries"
}
if (-not (Test-Path -LiteralPath $personalityPath)) {
    @(
        "# Personality: $slug",
        "",
        "- branch: $branchName",
        "- base_branch: $BaseBranch",
        "- purpose: describe what this personality is optimized for"
    ) | Set-Content -LiteralPath $personalityPath
}

if ($Checkout) {
    git checkout $branchName | Out-Null
}

[ordered]@{
    branch = $branchName
    personality = $slug
    checkedOut = [bool]$Checkout
    sharedLearningsPath = ".ai/SHARED_LEARNINGS.md"
    personalityPath = ".ai/personalities/$slug.md"
} | ConvertTo-Json -Depth 10