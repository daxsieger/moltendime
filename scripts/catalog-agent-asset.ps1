param(
    [Parameter(Mandatory = $true)]
    [string]$Engine,
    [Parameter(Mandatory = $true)]
    [string]$AssetType,
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [Parameter(Mandatory = $true)]
    [string]$Path,
    [Parameter(Mandatory = $true)]
    [string]$Summary,
    [string[]]$Tags = @(),
    [string]$Notes = "",
    [string]$CatalogPath = ".ai/rule-archive/catalog.jsonl"
)

if (-not (Test-Path -LiteralPath $CatalogPath)) {
    throw "Catalog file '$CatalogPath' does not exist."
}

$normalizedTags = @()
foreach ($tag in $Tags) {
    if ([string]::IsNullOrWhiteSpace($tag)) {
        continue
    }
    $normalizedTags += ($tag -split ',') | ForEach-Object { $_.Trim() } | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }
}

$record = [ordered]@{
    timestamp = Get-Date -Format o
    engine = $Engine
    asset_type = $AssetType
    name = $Name
    path = $Path
    summary = $Summary
    tags = @($normalizedTags)
    notes = $Notes
}

$existingText = Get-Content -LiteralPath $CatalogPath -Raw
$serialized = $record | ConvertTo-Json -Compress -Depth 10
if ([string]::IsNullOrWhiteSpace($existingText)) {
    Set-Content -LiteralPath $CatalogPath -Value $serialized
}
else {
    $prefix = if ($existingText.EndsWith("`n") -or $existingText.EndsWith("`r")) { "" } else { [Environment]::NewLine }
    Add-Content -LiteralPath $CatalogPath -Value ($prefix + $serialized)
}
$record | ConvertTo-Json -Depth 10