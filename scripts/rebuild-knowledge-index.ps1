param(
    [string]$RepoRoot = ".",
    [string]$OutputPath = ".ai/knowledge-index/INDEX.md"
)

function Get-FieldValue {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath,
        [Parameter(Mandatory = $true)]
        [string]$FieldName
    )

    $match = Select-String -LiteralPath $FilePath -Pattern "^-\s+${FieldName}:\s+(.+)$" | Select-Object -First 1
    if ($null -eq $match) {
        return ""
    }

    return $match.Matches[0].Groups[1].Value.Trim()
}

function Get-RelativeRepoPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$AbsolutePath,
        [Parameter(Mandatory = $true)]
        [string]$ResolvedRoot
    )

    $normalizedRoot = $ResolvedRoot.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    if ($AbsolutePath.StartsWith($normalizedRoot)) {
        return $AbsolutePath.Substring($normalizedRoot.Length).TrimStart([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar).Replace('\', '/')
    }

    return $AbsolutePath.Replace('\', '/')
}

$systemPersonas = @(
    'ai-rule-learner',
    'builder',
    'planner',
    'researcher',
    'reviewer',
    'repo-skill-learner',
    'paper-skill-learner'
)

$resolvedRepoRoot = (Resolve-Path -LiteralPath $RepoRoot).Path
Push-Location $resolvedRepoRoot
try {
    $personaRoot = Join-Path $resolvedRepoRoot '.ai/personalities'
    $allPersonaFiles = Get-ChildItem -LiteralPath $personaRoot -Filter '*.md' | Where-Object { $_.Name -notin @('README.md', 'BRANCH_REGISTRY.md') } | Sort-Object Name

    $systemPersonaRows = foreach ($file in $allPersonaFiles | Where-Object { $systemPersonas -contains $_.BaseName }) {
        [PSCustomObject]@{
            Name = $file.BaseName
            Branch = Get-FieldValue -FilePath $file.FullName -FieldName 'branch'
            Purpose = Get-FieldValue -FilePath $file.FullName -FieldName 'purpose'
            Path = Get-RelativeRepoPath -AbsolutePath $file.FullName -ResolvedRoot $resolvedRepoRoot
        }
    }

    $expertPersonaRows = foreach ($file in $allPersonaFiles | Where-Object { $systemPersonas -notcontains $_.BaseName }) {
        [PSCustomObject]@{
            Name = $file.BaseName
            Branch = Get-FieldValue -FilePath $file.FullName -FieldName 'branch'
            Purpose = Get-FieldValue -FilePath $file.FullName -FieldName 'purpose'
            Path = Get-RelativeRepoPath -AbsolutePath $file.FullName -ResolvedRoot $resolvedRepoRoot
        }
    }

    $repoBundles = Get-ChildItem -LiteralPath (Join-Path $resolvedRepoRoot '.ai/repo-imports') -Directory | Sort-Object Name
    $paperBundles = Get-ChildItem -LiteralPath (Join-Path $resolvedRepoRoot '.ai/paper-imports') -Directory | Sort-Object Name
    $skillDirs = Get-ChildItem -LiteralPath (Join-Path $resolvedRepoRoot '.github/skills') -Directory | Sort-Object Name
    $agentFiles = Get-ChildItem -LiteralPath (Join-Path $resolvedRepoRoot '.github/agents') -Filter '*.agent.md' | Sort-Object Name
    $catalogPath = Join-Path $resolvedRepoRoot '.ai/rule-archive/catalog.jsonl'
    $catalogCount = if (Test-Path -LiteralPath $catalogPath) { (Get-Content -LiteralPath $catalogPath | Where-Object { -not [string]::IsNullOrWhiteSpace($_) }).Count } else { 0 }

    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add('# Knowledge Inventory Snapshot') | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('- generated_by: `scripts/rebuild-knowledge-index.ps1`') | Out-Null
    $lines.Add("- generated_at: $(Get-Date -Format o)") | Out-Null
    $lines.Add('- global_index_owner: `ai-rule-learner`') | Out-Null
    $lines.Add("- system_persona_count: $($systemPersonaRows.Count)") | Out-Null
    $lines.Add("- expert_persona_count: $($expertPersonaRows.Count)") | Out-Null
    $lines.Add("- repo_bundle_count: $($repoBundles.Count)") | Out-Null
    $lines.Add("- paper_bundle_count: $($paperBundles.Count)") | Out-Null
    $lines.Add("- skill_count: $($skillDirs.Count)") | Out-Null
    $lines.Add("- agent_count: $($agentFiles.Count)") | Out-Null
    $lines.Add("- archive_record_count: $catalogCount") | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('## System Personas') | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('| Persona | Branch | Purpose | Note Path |') | Out-Null
    $lines.Add('|---|---|---|---|') | Out-Null
    foreach ($row in $systemPersonaRows) {
        $lines.Add("| $($row.Name) | $($row.Branch) | $($row.Purpose) | $($row.Path) |") | Out-Null
    }
    $lines.Add('') | Out-Null
    $lines.Add('## Expert Personas') | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('| Persona | Branch | Purpose | Note Path |') | Out-Null
    $lines.Add('|---|---|---|---|') | Out-Null
    foreach ($row in $expertPersonaRows) {
        $lines.Add("| $($row.Name) | $($row.Branch) | $($row.Purpose) | $($row.Path) |") | Out-Null
    }
    $lines.Add('') | Out-Null
    $lines.Add('## Repository Bundles') | Out-Null
    $lines.Add('') | Out-Null
    foreach ($bundle in $repoBundles) {
        $lines.Add('- `.ai/repo-imports/' + $bundle.Name + '/`') | Out-Null
    }
    $lines.Add('') | Out-Null
    $lines.Add('## Paper Bundles') | Out-Null
    $lines.Add('') | Out-Null
    foreach ($bundle in $paperBundles) {
        $lines.Add('- `.ai/paper-imports/' + $bundle.Name + '/`') | Out-Null
    }
    $lines.Add('') | Out-Null
    $lines.Add('## Customization Surfaces') | Out-Null
    $lines.Add('') | Out-Null
    $lines.Add('- Skills root: `.github/skills/` (' + $skillDirs.Count + ' directories)') | Out-Null
    $lines.Add('- Agents root: `.github/agents/` (' + $agentFiles.Count + ' files)') | Out-Null
    $lines.Add('- Archive catalog: `.ai/rule-archive/catalog.jsonl` (' + $catalogCount + ' records)') | Out-Null

    $outputAbsolutePath = Join-Path $resolvedRepoRoot $OutputPath
    $outputDirectory = Split-Path -Parent $outputAbsolutePath
    if (-not (Test-Path -LiteralPath $outputDirectory)) {
        New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
    }

    Set-Content -LiteralPath $outputAbsolutePath -Value ($lines -join [Environment]::NewLine)
    [ordered]@{
        output = (Get-RelativeRepoPath -AbsolutePath $outputAbsolutePath -ResolvedRoot $resolvedRepoRoot)
        system_persona_count = $systemPersonaRows.Count
        expert_persona_count = $expertPersonaRows.Count
        repo_bundle_count = $repoBundles.Count
        paper_bundle_count = $paperBundles.Count
        skill_count = $skillDirs.Count
        agent_count = $agentFiles.Count
        archive_record_count = $catalogCount
    } | ConvertTo-Json -Depth 10
}
finally {
    Pop-Location
}