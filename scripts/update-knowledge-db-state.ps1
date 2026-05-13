param(
    [string]$RepoPath = ".",
    [string]$ConfigPath = ".ai/db-definitions.json"
)

function Get-ContentSha256 {
    param([string]$Text)

    $sha = [System.Security.Cryptography.SHA256]::Create()
    try {
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
        $hash = $sha.ComputeHash($bytes)
        return ([System.BitConverter]::ToString($hash)).Replace('-', '').ToLowerInvariant()
    }
    finally {
        $sha.Dispose()
    }
}

function Get-RelativeRepoPath {
    param(
        [string]$BasePath,
        [string]$TargetPath
    )

    $baseUri = [System.Uri]((Resolve-Path -LiteralPath $BasePath).Path.TrimEnd('\') + '\')
    $targetUri = [System.Uri](Resolve-Path -LiteralPath $TargetPath).Path
    return [System.Uri]::UnescapeDataString($baseUri.MakeRelativeUri($targetUri).ToString()).Replace('/', '\')
}

function Expand-BranchPatterns {
    param([string[]]$Patterns)

    $allBranches = @(git for-each-ref --format='%(refname:short)' refs/heads)
    $selected = New-Object System.Collections.Generic.List[string]
    foreach ($pattern in $Patterns) {
        foreach ($branch in $allBranches) {
            if ($branch -like $pattern -and $selected -notcontains $branch) {
                $selected.Add($branch)
            }
        }
    }
    return @($selected | Sort-Object)
}

function Get-WorkingTreeMatches {
    param([string[]]$PathGlobs)

    $matches = New-Object System.Collections.Generic.List[string]
    Get-ChildItem -Recurse -File | ForEach-Object {
        $relativePath = (Get-RelativeRepoPath -BasePath (Get-Location).Path -TargetPath $_.FullName).Replace('\', '/')
        foreach ($glob in $PathGlobs) {
            if ($relativePath -like $glob) {
                if ($matches -notcontains $relativePath) {
                    $matches.Add($relativePath)
                }
                break
            }
        }
    }

    return @($matches | Sort-Object)
}

function Get-BranchMatches {
    param(
        [string]$BranchName,
        [string[]]$PathGlobs
    )

    $files = @(git ls-tree -r --name-only $BranchName)
    $matches = New-Object System.Collections.Generic.List[string]
    foreach ($file in $files) {
        foreach ($glob in $PathGlobs) {
            if ($file -like $glob) {
                if ($matches -notcontains $file) {
                    $matches.Add($file)
                }
                break
            }
        }
    }

    return @($matches | Sort-Object)
}

function Get-BranchFileContent {
    param(
        [string]$BranchName,
        [string]$RelativePath,
        [string]$CurrentBranchName
    )

    if ($BranchName -eq $CurrentBranchName) {
        if (-not (Test-Path -LiteralPath $RelativePath)) {
            return $null
        }

        return Get-Content -LiteralPath $RelativePath -Raw
    }

    return git show "${BranchName}:$RelativePath"
}

$resolvedRepoPath = Resolve-Path -LiteralPath $RepoPath -ErrorAction Stop

Push-Location $resolvedRepoPath
try {
    if (-not (Test-Path -LiteralPath $ConfigPath)) {
        throw "DB definition file '$ConfigPath' does not exist."
    }

    $config = Get-Content -LiteralPath $ConfigPath -Raw | ConvertFrom-Json
    $currentBranch = (git branch --show-current).Trim()

    $results = foreach ($db in $config.databases) {
        $branches = Expand-BranchPatterns -Patterns $db.branch_globs
        $branchStates = foreach ($branch in $branches) {
            $matchedPaths = if ($branch -eq $currentBranch) {
                Get-WorkingTreeMatches -PathGlobs $db.path_globs
            }
            else {
                Get-BranchMatches -BranchName $branch -PathGlobs $db.path_globs
            }

            $files = foreach ($relativePath in $matchedPaths) {
                $content = Get-BranchFileContent -BranchName $branch -RelativePath $relativePath -CurrentBranchName $currentBranch
                if ($null -eq $content) {
                    continue
                }

                [ordered]@{
                    path = $relativePath
                    sha256 = Get-ContentSha256 -Text $content
                }
            }

            $branchHashInput = @($files | Sort-Object path | ForEach-Object { "$($_.path):$($_.sha256)" }) -join "`n"
            [ordered]@{
                branch = $branch
                knowledge_hash = Get-ContentSha256 -Text $branchHashInput
                file_count = @($files).Count
                files = @($files | Sort-Object path)
            }
        }

        $totalHashInput = @($branchStates | Sort-Object branch | ForEach-Object { "$($_.branch):$($_.knowledge_hash)" }) -join "`n"
        $outputDirectory = Split-Path -Path $db.output_path -Parent
        if (-not [string]::IsNullOrWhiteSpace($outputDirectory) -and -not (Test-Path -LiteralPath $outputDirectory)) {
            New-Item -ItemType Directory -Path $outputDirectory -Force | Out-Null
        }

        $state = [ordered]@{
            name = $db.name
            description = $db.description
            branch_globs = @($db.branch_globs)
            path_globs = @($db.path_globs)
            total_knowledge_hash = Get-ContentSha256 -Text $totalHashInput
            branches = @($branchStates)
        }

        $state | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $db.output_path
        $state
    }

    $results | ConvertTo-Json -Depth 10
}
finally {
    Pop-Location
}