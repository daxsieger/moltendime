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
$commitMessages = @()

foreach ($branch in $branches) {
    $safeBranchName = $branch -replace '[^a-zA-Z0-9_-]', '-'
    $tempWorktree = Join-Path $env:TEMP ("ai-agent-sync-" + $safeBranchName + "-" + [guid]::NewGuid().ToString('N'))

    try {
        git worktree add --force $tempWorktree $branch | Out-Null

        $targetFile = Join-Path $tempWorktree ($SharedLearningsPath -replace '/', '\\')
        $targetDirectory = Split-Path -Path $targetFile -Parent
        if (-not [string]::IsNullOrWhiteSpace($targetDirectory) -and -not (Test-Path -LiteralPath $targetDirectory)) {
            New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
        }

        Set-Content -LiteralPath $targetFile -Value $sourceContent

        Push-Location $tempWorktree
        try {
            git add -- $SharedLearningsPath
            git diff --cached --quiet
            if ($LASTEXITCODE -ne 0) {
                $message = "sync: shared learnings from $SourceBranch [$branch]"
                git commit -m $message | Out-Null
                $updatedBranches += $branch
                $commitMessages += $message
            }
        }
        finally {
            Pop-Location
        }
    }
    finally {
        if (Test-Path -LiteralPath $tempWorktree) {
            git worktree remove $tempWorktree --force | Out-Null
        }
    }
}

[ordered]@{
    sourceBranch = $SourceBranch
    currentBranch = $currentBranch
    updatedBranches = $updatedBranches
    sharedLearningsPath = $SharedLearningsPath
    commitMessages = $commitMessages
} | ConvertTo-Json -Depth 10