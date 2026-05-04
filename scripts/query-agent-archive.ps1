param(
    [Parameter(Mandatory = $true)]
    [string]$Query,
    [string]$CatalogPath = ".ai/rule-archive/catalog.jsonl"
)

if (-not (Test-Path -LiteralPath $CatalogPath)) {
    throw "Catalog file '$CatalogPath' does not exist."
}

$rawCatalog = Get-Content -LiteralPath $CatalogPath -Raw
$normalizedCatalog = $rawCatalog -replace '}\s*{', "}`r`n{"
$records = $normalizedCatalog -split "`r?`n" | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | ForEach-Object { $_ | ConvertFrom-Json }
$needle = $Query.ToLowerInvariant()

$matches = $records | Where-Object {
    ($_.name -and $_.name.ToLowerInvariant().Contains($needle)) -or
    ($_.asset_type -and $_.asset_type.ToLowerInvariant().Contains($needle)) -or
    ($_.summary -and $_.summary.ToLowerInvariant().Contains($needle)) -or
    ($_.path -and $_.path.ToLowerInvariant().Contains($needle)) -or
    ($_.engine -and $_.engine.ToLowerInvariant().Contains($needle)) -or
    ($_.notes -and $_.notes.ToLowerInvariant().Contains($needle)) -or
    ($_.tags -and (($_.tags | ForEach-Object { $_.ToLowerInvariant() }) -contains $needle))
}

$matches | ConvertTo-Json -Depth 10