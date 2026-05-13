param(
    [string]$RepoPath = ".",
    [string]$PromptText = "",
    [string]$HandlingAgent = $(if ($env:CHAT_COMMIT_DEFAULT_AGENT) { $env:CHAT_COMMIT_DEFAULT_AGENT } else { "Unknown Agent" }),
    [string]$SourceClient = $(if ($env:CHAT_COMMIT_CLIENT) { $env:CHAT_COMMIT_CLIENT } else { "unknown-client" }),
    [string]$Timestamp = "",
    [string]$EventName = "user_prompt"
)

function Get-CommitPromptExcerpt {
    param([string]$Text)

    if ([string]::IsNullOrWhiteSpace($Text)) {
        return "workspace update"
    }

    $singleLine = ($Text -replace '\s+', ' ').Trim()
    if ($singleLine.Length -gt 60) {
        return $singleLine.Substring(0, 60).TrimEnd()
    }

    return $singleLine
}

function Ensure-GitIdentity {
    $userName = git config user.name 2>$null
    $userEmail = git config user.email 2>$null

    if ([string]::IsNullOrWhiteSpace($userName)) {
        git config user.name "AI Agent Workspace" | Out-Null
    }
    if ([string]::IsNullOrWhiteSpace($userEmail)) {
        git config user.email "ai-agent@local" | Out-Null
    }
}

function Invoke-KnowledgeRefresh {
    param([string]$RepoRoot)

    $personaKnowledgeScript = Join-Path $PSScriptRoot 'sync-persona-knowledge.ps1'
    if (Test-Path -LiteralPath $personaKnowledgeScript) {
        & $personaKnowledgeScript -RepoPath $RepoRoot | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Persona knowledge sync failed."
        }
    }

    $dbStateScript = Join-Path $PSScriptRoot 'update-knowledge-db-state.ps1'
    if (Test-Path -LiteralPath $dbStateScript) {
        & $dbStateScript -RepoPath $RepoRoot | Out-Null
        if ($LASTEXITCODE -ne 0) {
            throw "Knowledge DB state refresh failed."
        }
    }
}

$resolvedRepoPath = Resolve-Path -LiteralPath $RepoPath -ErrorAction SilentlyContinue
if ($null -eq $resolvedRepoPath) {
    $resolvedRepoPath = Get-Location
}

Push-Location $resolvedRepoPath
try {
    $insideRepo = git rev-parse --is-inside-work-tree 2>$null
    if ($LASTEXITCODE -ne 0 -or $insideRepo -ne 'true') {
        $result = [ordered]@{
            continue = $true
            systemMessage = "No git repository found; skipped commit"
        }
        $result | ConvertTo-Json -Depth 10
        return
    }

    Ensure-GitIdentity
    Invoke-KnowledgeRefresh -RepoRoot $resolvedRepoPath

    git add -A
    git diff --cached --quiet
    if ($LASTEXITCODE -eq 0) {
        $result = [ordered]@{
            continue = $true
            systemMessage = "No staged changes to commit"
        }
        $result | ConvertTo-Json -Depth 10
        return
    }

    if ([string]::IsNullOrWhiteSpace($Timestamp)) {
        $Timestamp = Get-Date -Format o
    }

    $excerpt = Get-CommitPromptExcerpt -Text $PromptText
    $message = "${EventName}: $excerpt [$SourceClient][$HandlingAgent][$Timestamp]"
    git commit -m $message | Out-Null

    $result = [ordered]@{
        continue = $true
        systemMessage = "Committed staged changes"
        commitMessage = $message
    }
    $result | ConvertTo-Json -Depth 10
}
finally {
    Pop-Location
}