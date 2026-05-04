param(
    [Parameter(Mandatory = $true)]
    [string]$PersonalityName,
    [Parameter(Mandatory = $true)]
    [string]$LearnedFrom,
    [Parameter(Mandatory = $true)]
    [string]$Summary,
    [string]$WhyItMatters = "",
    [string]$SharedLearningsPath = ".ai/SHARED_LEARNINGS.md"
)

function Get-Slug {
    param([string]$Value)

    $slug = $Value.ToLowerInvariant()
    $slug = [System.Text.RegularExpressions.Regex]::Replace($slug, '[^a-z0-9]+', '-')
    return $slug.Trim('-')
}

if (-not (Test-Path -LiteralPath $SharedLearningsPath)) {
    throw "Shared learnings file '$SharedLearningsPath' does not exist."
}

$timestamp = Get-Date -Format o
$personalitySlug = Get-Slug -Value $PersonalityName
$learnedFromSlug = Get-Slug -Value $LearnedFrom

$entry = @(
    "",
    "### $timestamp",
    "- personality: $personalitySlug",
    "- learned_from: $learnedFromSlug",
    "- summary: $Summary"
)

if (-not [string]::IsNullOrWhiteSpace($WhyItMatters)) {
    $entry += "- why_it_matters: $WhyItMatters"
}

Add-Content -LiteralPath $SharedLearningsPath -Value ($entry -join [Environment]::NewLine)

[ordered]@{
    timestamp = $timestamp
    personality = $personalitySlug
    learnedFrom = $learnedFromSlug
    sharedLearningsPath = $SharedLearningsPath
} | ConvertTo-Json -Depth 10