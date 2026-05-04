param(
    [string]$SourceBranch = "main",
    [string]$SharedLearningsPath = ".ai/SHARED_LEARNINGS.md",
    [string]$PersonalityPattern = "persona/*"
)

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $insideRepo -ne 'true') {
    throw "The workspace is not a git repository."
}

if (-not (Test-Path -LiteralPath $SharedLearningsPath)) {
    throw "Shared learnings file '$SharedLearningsPath' does not exist in the working tree."
}

git rev-parse --verify $SourceBranch 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Source branch '$SourceBranch' does not exist."
}

$currentBranch = (git branch --show-current).Trim()
$branches = git for-each-ref --format='%(refname:short)' "refs/heads/$PersonalityPattern"
$branches = @($branches | Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

$gitPath = $SharedLearningsPath -replace '\\', '/'
$sourceContent = git show "${SourceBranch}:$gitPath"
$sourceContent = ($sourceContent | Out-String).TrimEnd("`r", "`n")
$updatedBranches = @()

try {
    foreach ($branch in $branches) {
        git checkout $branch | Out-Null
        Set-Content -LiteralPath $SharedLearningsPath -Value $sourceContent
        $updatedBranches += $branch
    }
}
finally {
    git checkout $currentBranch | Out-Null
    Set-Content -LiteralPath $SharedLearningsPath -Value $sourceContent
}

[ordered]@{
    sourceBranch = $SourceBranch
    currentBranch = $currentBranch
    updatedBranches = $updatedBranches
    sharedLearningsPath = $SharedLearningsPath
} | ConvertTo-Json -Depth 10