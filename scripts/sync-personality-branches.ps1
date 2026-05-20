param(
    [ValidateSet("push", "pull", "both")]
    [string]$Mode = "both",
    [string]$Remote = "origin",
    [string]$BaseBranch = "main",
    [string]$PersonalityPattern = "persona/*",
    [switch]$IncludeBaseBranch,
    [switch]$Prune,
    [switch]$DryRun,
    [switch]$RequireConfirmation
)

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Arguments,
        [switch]$IgnoreErrors
    )

    $output = & git @Arguments 2>&1
    $exitCode = $LASTEXITCODE
    if (-not $IgnoreErrors -and $exitCode -ne 0) {
        $message = ($output | Out-String).Trim()
        if ([string]::IsNullOrWhiteSpace($message)) {
            $message = "git $($Arguments -join ' ') failed with exit code $exitCode"
        }
        throw $message
    }

    [PSCustomObject]@{
        Output = @($output)
        ExitCode = $exitCode
    }
}

function Test-RemoteBranchExists {
    param(
        [Parameter(Mandatory = $true)]
        [string]$RemoteName,
        [Parameter(Mandatory = $true)]
        [string]$BranchName
    )

    $result = Invoke-Git -Arguments @("show-ref", "--verify", "--quiet", "refs/remotes/$RemoteName/$BranchName") -IgnoreErrors
    return $result.ExitCode -eq 0
}

function New-BranchResult {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Branch,
        [Parameter(Mandatory = $true)]
        [string]$Action,
        [Parameter(Mandatory = $true)]
        [string]$Status,
        [string]$Message = ""
    )

    [ordered]@{
        branch = $Branch
        action = $Action
        status = $Status
        message = $Message
    }
}

function Confirm-SyncOperation {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ModeName,
        [Parameter(Mandatory = $true)]
        [string]$RemoteName,
        [Parameter(Mandatory = $true)]
        [string[]]$TargetBranches
    )

    if (-not $RequireConfirmation -or $DryRun) {
        return $true
    }

    $preview = ($TargetBranches | Select-Object -First 5) -join ', '
    if ($TargetBranches.Count -gt 5) {
        $preview += ", ..."
    }

    $answer = Read-Host "Confirm $ModeName on remote '$RemoteName' for $($TargetBranches.Count) branches ($preview). Type 'yes' to continue"
    return $answer -eq 'yes'
}

function Get-TemporaryDirectoryRoot {
    $candidates = @(
        $env:TEMP,
        $env:TMPDIR,
        $env:TMP,
        [System.IO.Path]::GetTempPath()
    )

    foreach ($candidate in $candidates) {
        if (-not [string]::IsNullOrWhiteSpace($candidate)) {
            return $candidate
        }
    }

    throw "Unable to determine a temporary directory for git worktrees."
}

$insideRepo = (Invoke-Git -Arguments @("rev-parse", "--is-inside-work-tree") -IgnoreErrors)
if ($insideRepo.ExitCode -ne 0 -or (($insideRepo.Output | Out-String).Trim() -ne "true")) {
    throw "The workspace is not a git repository."
}

$remoteCheck = Invoke-Git -Arguments @("remote", "get-url", $Remote) -IgnoreErrors
if ($remoteCheck.ExitCode -ne 0) {
    throw "Remote '$Remote' does not exist."
}

$currentBranch = ((Invoke-Git -Arguments @("branch", "--show-current")).Output | Out-String).Trim()
$tempRoot = Get-TemporaryDirectoryRoot
$branches = @()
if ($IncludeBaseBranch -or $BaseBranch -eq $currentBranch -or $BaseBranch -eq "main") {
    $branches += $BaseBranch
}

$personaBranches = ((Invoke-Git -Arguments @("for-each-ref", "--format=%(refname:short)", "refs/heads/$PersonalityPattern")).Output |
    Where-Object { -not [string]::IsNullOrWhiteSpace($_) })

$branches += $personaBranches
$branches = @($branches | Sort-Object -Unique)

$results = New-Object System.Collections.Generic.List[object]

if ($Mode -in @("pull", "both")) {
    if (-not (Confirm-SyncOperation -ModeName "pull" -RemoteName $Remote -TargetBranches $branches)) {
        $results.Add((New-BranchResult -Branch "*" -Action "pull" -Status "cancelled" -Message "User declined confirmation."))
    }
    else {
    $fetchArgs = @("fetch", $Remote)
    if ($Prune) {
        $fetchArgs += "--prune"
    }

    if ($DryRun) {
        $results.Add((New-BranchResult -Branch "*" -Action "fetch" -Status "dry-run" -Message ("git " + ($fetchArgs -join ' '))))
    }
    else {
        Invoke-Git -Arguments $fetchArgs | Out-Null
    }

    foreach ($branch in $branches) {
        if (-not (Test-RemoteBranchExists -RemoteName $Remote -BranchName $branch)) {
            $results.Add((New-BranchResult -Branch $branch -Action "pull" -Status "skipped" -Message "Remote branch not found."))
            continue
        }

        if ($DryRun) {
            $results.Add((New-BranchResult -Branch $branch -Action "pull" -Status "dry-run" -Message "Would fast-forward local branch from refs/remotes/$Remote/$branch"))
            continue
        }

        $safeBranchName = $branch -replace '[^a-zA-Z0-9_-]', '-'
        $tempWorktree = Join-Path $tempRoot ("ai-agent-branch-sync-" + $safeBranchName + "-" + [guid]::NewGuid().ToString('N'))

        try {
            Invoke-Git -Arguments @("worktree", "add", "--force", $tempWorktree, $branch) | Out-Null
            Push-Location $tempWorktree
            try {
                $mergeResult = Invoke-Git -Arguments @("merge", "--ff-only", "refs/remotes/$Remote/$branch") -IgnoreErrors
                if ($mergeResult.ExitCode -eq 0) {
                    $message = (($mergeResult.Output | Out-String).Trim())
                    if ([string]::IsNullOrWhiteSpace($message)) {
                        $message = "Fast-forwarded from refs/remotes/$Remote/$branch"
                    }
                    $results.Add((New-BranchResult -Branch $branch -Action "pull" -Status "updated" -Message $message))
                }
                else {
                    $results.Add((New-BranchResult -Branch $branch -Action "pull" -Status "failed" -Message (($mergeResult.Output | Out-String).Trim())))
                }
            }
            finally {
                Pop-Location
            }
        }
        finally {
            if (Test-Path -LiteralPath $tempWorktree) {
                Invoke-Git -Arguments @("worktree", "remove", $tempWorktree, "--force") -IgnoreErrors | Out-Null
            }
        }
    }
    }
}

if ($Mode -in @("push", "both")) {
    if (-not (Confirm-SyncOperation -ModeName "push" -RemoteName $Remote -TargetBranches $branches)) {
        $results.Add((New-BranchResult -Branch "*" -Action "push" -Status "cancelled" -Message "User declined confirmation."))
    }
    else {
    foreach ($branch in $branches) {
        $pushArgs = @("push", $Remote, "$branch`:$branch")
        if ($DryRun) {
            $results.Add((New-BranchResult -Branch $branch -Action "push" -Status "dry-run" -Message ("git " + ($pushArgs -join ' '))))
            continue
        }

        $pushResult = Invoke-Git -Arguments $pushArgs -IgnoreErrors
        if ($pushResult.ExitCode -eq 0) {
            $message = (($pushResult.Output | Out-String).Trim())
            if ([string]::IsNullOrWhiteSpace($message)) {
                $message = "Pushed to $Remote/$branch"
            }
            $results.Add((New-BranchResult -Branch $branch -Action "push" -Status "updated" -Message $message))
        }
        else {
            $results.Add((New-BranchResult -Branch $branch -Action "push" -Status "failed" -Message (($pushResult.Output | Out-String).Trim())))
        }
    }
    }
}

[ordered]@{
    remote = $Remote
    mode = $Mode
    baseBranch = $BaseBranch
    includeBaseBranch = [bool]($IncludeBaseBranch -or $BaseBranch -eq "main")
    dryRun = [bool]$DryRun
    currentBranch = $currentBranch
    branches = $branches
    results = $results
} | ConvertTo-Json -Depth 10