param(
    [string]$Remote = "origin",
    [switch]$DryRun,
    [switch]$RequireConfirmation
)

$arguments = @{
    Mode = "push"
    Remote = $Remote
}

if ($DryRun) {
    $arguments.DryRun = $true
}
if ($RequireConfirmation) {
    $arguments.RequireConfirmation = $true
}

& (Join-Path $PSScriptRoot "sync-personality-branches.ps1") @arguments