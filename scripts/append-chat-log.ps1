param(
    [string]$ChatsPath = $(if ($env:CHAT_LOGGING_CHATS_PATH) { $env:CHAT_LOGGING_CHATS_PATH } else { "CHATS" }),
    [string]$DefaultAgentName = $(if ($env:CHAT_LOGGING_DEFAULT_AGENT) { $env:CHAT_LOGGING_DEFAULT_AGENT } else { "Unknown Agent" }),
    [string]$SourceClient = $(if ($env:CHAT_LOGGING_CLIENT) { $env:CHAT_LOGGING_CLIENT } else { "unknown-client" }),
    [string]$CommitAfterLog = $(if ($env:CHAT_LOGGING_COMMIT_AFTER_LOG) { $env:CHAT_LOGGING_COMMIT_AFTER_LOG } else { "false" })
)

$raw = [Console]::In.ReadToEnd()
$payload = $null

if (-not [string]::IsNullOrWhiteSpace($raw)) {
    try {
        $payload = $raw | ConvertFrom-Json -Depth 100
    }
    catch {
        $payload = $null
    }
}

function Find-FirstValue {
    param(
        $Node,
        [Parameter(Mandatory = $true)] [string[]]$Names
    )

    if ($null -eq $Node) {
        return $null
    }

    if ($Node -is [string] -or $Node -is [ValueType]) {
        return $null
    }

    $properties = @()
    if ($Node.PSObject -and $Node.PSObject.Properties) {
        $properties = $Node.PSObject.Properties
        foreach ($name in $Names) {
            $match = $properties | Where-Object { $_.Name -ieq $name } | Select-Object -First 1
            if ($match -and $null -ne $match.Value) {
                $value = [string]$match.Value
                if (-not [string]::IsNullOrWhiteSpace($value)) {
                    return $value.Trim()
                }
            }
        }
        foreach ($property in $properties) {
            $found = Find-FirstValue -Node $property.Value -Names $Names
            if (-not [string]::IsNullOrWhiteSpace($found)) {
                return $found
            }
        }
    }

    if ($Node -is [System.Collections.IEnumerable] -and -not ($Node -is [string])) {
        foreach ($item in $Node) {
            $found = Find-FirstValue -Node $item -Names $Names
            if (-not [string]::IsNullOrWhiteSpace($found)) {
                return $found
            }
        }
    }

    return $null
}

function Normalize-EventName {
    param([string]$EventName, [string]$PromptText, [string]$DelegatedAgent)

    if (-not [string]::IsNullOrWhiteSpace($EventName)) {
        switch -Regex ($EventName.Trim()) {
            '^(UserPromptSubmit|user_prompt)$' { return 'user_prompt' }
            '^(SubagentStart|subagent_start)$' { return 'subagent_start' }
            '^(SubagentStop|subagent_stop)$' { return 'subagent_stop' }
            '^(Stop|stop)$' { return 'stop' }
            default { return $EventName.Trim() }
        }
    }
    if (-not [string]::IsNullOrWhiteSpace($DelegatedAgent) -and $DelegatedAgent -ne 'none') {
        return "subagent_start"
    }
    if (-not [string]::IsNullOrWhiteSpace($PromptText)) {
        return "user_prompt"
    }
    return "hook_event"
}

function Convert-ToIsoTimestamp {
    param([string]$Value)

    if ([string]::IsNullOrWhiteSpace($Value)) {
        return (Get-Date -Format o)
    }

    $formats = @(
        'dd/MM/yyyy HH:mm:ss',
        'd/M/yyyy HH:mm:ss',
        'dd/MM/yyyy H:mm:ss',
        'd/M/yyyy H:mm:ss',
        'yyyy-MM-ddTHH:mm:ssK',
        'yyyy-MM-ddTHH:mm:ss.fffffffK',
        'o'
    )
    [datetime]$parsedDate = [datetime]::MinValue
    if ([datetime]::TryParseExact($Value, $formats, [System.Globalization.CultureInfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::AssumeLocal, [ref]$parsedDate)) {
        $offset = [System.TimeZoneInfo]::Local.GetUtcOffset($parsedDate)
        return ([DateTimeOffset]::new($parsedDate, $offset)).ToString('o')
    }
    [DateTimeOffset]$parsedOffset = [DateTimeOffset]::MinValue
    if ([DateTimeOffset]::TryParse($Value, [ref]$parsedOffset)) {
        return $parsedOffset.ToString('o')
    }

    return (Get-Date -Format o)
}

$timestamp = Find-FirstValue -Node $payload -Names @("timestamp", "eventTimestamp", "createdAt", "time")
$timestamp = Convert-ToIsoTimestamp -Value $timestamp

$promptText = Find-FirstValue -Node $payload -Names @("prompt", "userPrompt", "message", "text", "task", "input")
if ([string]::IsNullOrWhiteSpace($promptText) -and -not [string]::IsNullOrWhiteSpace($raw)) {
    $promptText = $raw.Trim()
}
if ([string]::IsNullOrWhiteSpace($promptText)) {
    $promptText = "(no prompt text available from hook payload)"
}

$handlingAgent = Find-FirstValue -Node $payload -Names @("agentName", "currentAgentName", "assistantName", "issuedBy", "sourceAgentName")
if ([string]::IsNullOrWhiteSpace($handlingAgent)) {
    $handlingAgent = $DefaultAgentName
}

$delegatedTo = Find-FirstValue -Node $payload -Names @("delegatedAgentName", "subagentName", "targetAgentName", "toAgent")
if ([string]::IsNullOrWhiteSpace($delegatedTo)) {
    $delegatedTo = "none"
}

$eventName = Find-FirstValue -Node $payload -Names @("hookEventName", "eventName", "event")
$eventName = Normalize-EventName -EventName $eventName -PromptText $promptText -DelegatedAgent $delegatedTo

$entry = @(
    "",
    "### $timestamp",
    "- event: $eventName",
    "- source_client: $SourceClient",
    "- handling_agent: $handlingAgent",
    "- delegated_to: $delegatedTo",
    "- recorded_by: hook",
    "- backfilled: false",
    "",
    '```text',
    $promptText,
    '```'
) -join [Environment]::NewLine

Add-Content -LiteralPath $ChatsPath -Value $entry

$result = [ordered]@{
    continue = $true
    systemMessage = "Logged $eventName to $ChatsPath"
}

if ($CommitAfterLog -eq 'true') {
    $commitScript = Join-Path $PSScriptRoot 'commit-prompt-state.ps1'
    if (Test-Path -LiteralPath $commitScript) {
        & $commitScript -PromptText $promptText -HandlingAgent $handlingAgent -SourceClient $SourceClient -Timestamp $timestamp -EventName $eventName | Out-Null
    }
}

$result | ConvertTo-Json -Depth 10