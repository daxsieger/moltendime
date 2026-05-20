param(
    [string]$Remote = "origin",
    [switch]$Prune,
    [switch]$DryRun,
    [switch]$RequireConfirmation
)

$arguments = @{
    Mode = "pull"
    Remote = $Remote
}

if ($Prune) {
    $arguments.Prune = $true
}
if ($DryRun) {
    $arguments.DryRun = $true
}
if ($RequireConfirmation) {
    $arguments.RequireConfirmation = $true
}

& (Join-Path $PSScriptRoot "sync-personality-branches.ps1") @arguments