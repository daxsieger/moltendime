param(
    [string]$StoriesPath = "stories/moltbook-programmers",
    [string]$OutputPath = ".ai/rule-archive/moltbook-programmers-index.json"
)

if (-not (Test-Path -LiteralPath $StoriesPath)) {
    throw "Stories path '$StoriesPath' does not exist."
}

$storyFiles = Get-ChildItem -LiteralPath $StoriesPath -Filter *.md | Where-Object { $_.Name -ne 'INDEX.md' } | Sort-Object Name
$index = foreach ($file in $storyFiles) {
    $lines = Get-Content -LiteralPath $file.FullName

    $title = ($lines | Select-Object -First 1) -replace '^#\s+', ''
    $profile = (($lines | Where-Object { $_ -like '- profile:*' } | Select-Object -First 1) -replace '^- profile:\s*`?', '').Trim('`',' ')
    $description = (($lines | Where-Object { $_ -like '- description:*' } | Select-Object -First 1) -replace '^- description:\s*', '').Trim()
    $signal = (($lines | Where-Object { $_ -like '- signal:*' } | Select-Object -First 1) -replace '^- signal:\s*', '').Trim()
    $whyKeepIndex = [Array]::IndexOf($lines, '## Why Keep This Story')
    $whyKeep = ''
    if ($whyKeepIndex -ge 0 -and $whyKeepIndex + 2 -lt $lines.Length) {
        $whyKeep = $lines[$whyKeepIndex + 2].Trim()
    }
    $messageCount = @($lines | Where-Object { $_ -match '^###\s' }).Count

    [ordered]@{
        name = $title
        profile = $profile
        description = $description
        signal = $signal
        message_count = $messageCount
        why_keep = $whyKeep
        story_path = ($file.FullName.Substring((Get-Location).Path.Length + 1) -replace '\\', '/')
    }
}

$outputDirectory = Split-Path -Path $OutputPath -Parent
if (-not [string]::IsNullOrWhiteSpace($outputDirectory) -and -not (Test-Path -LiteralPath $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
}

$index | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $OutputPath
$index | ConvertTo-Json -Depth 10