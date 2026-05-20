param(
    [string]$Remote = "origin",
    [string]$BranchPattern = "persona/*"
)

$insideRepo = git rev-parse --is-inside-work-tree 2>$null
if ($LASTEXITCODE -ne 0 -or $insideRepo -ne 'true') {
    throw "The workspace is not a git repository."
}

git remote get-url $Remote 2>$null | Out-Null
if ($LASTEXITCODE -ne 0) {
    throw "Remote '$Remote' does not exist."
}

$currentBranch = (git branch --show-current).Trim()
if ([string]::IsNullOrWhiteSpace($currentBranch)) {
    throw "Unable to determine the current branch."
}

$regexPattern = '^' + (($BranchPattern -replace '\*', '.*') -replace '/', '\/') + '$'
if ($currentBranch -notmatch $regexPattern) {
    [ordered]@{
        currentBranch = $currentBranch
        remote = $Remote
        isPersonalityBranch = $false
        published = $true
        message = "Current branch is not a personality branch; no publication guard needed."
    } | ConvertTo-Json -Depth 10
    return
}

git show-ref --verify --quiet "refs/remotes/$Remote/$currentBranch"
$published = ($LASTEXITCODE -eq 0)

if (-not $published) {
    throw "Current personality branch '$currentBranch' is not published on '$Remote'. Push it first with ./scripts/push-all-personas.ps1 or ./scripts/sync-personality-branches.ps1 -Mode push -Remote $Remote."
}

[ordered]@{
    currentBranch = $currentBranch
    remote = $Remote
    isPersonalityBranch = $true
    published = $true
    message = "Current personality branch is already published on the remote."
} | ConvertTo-Json -Depth 10