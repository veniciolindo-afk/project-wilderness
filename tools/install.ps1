param([switch]$WhatIfOnly)
$ErrorActionPreference = 'Stop'
$project = Split-Path -Parent $PSScriptRoot
$src = Join-Path $project 'Contents\mods\ProjectWilderness'
$mods = Join-Path $env:USERPROFILE 'Zomboid\mods'
$dst = Join-Path $mods 'ProjectWilderness'
if (!(Test-Path (Join-Path $src '42\mod.info'))) { throw 'mod.info not found in source' }
New-Item -ItemType Directory -Path $mods -Force | Out-Null
if (Test-Path $dst) {
    $stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
    $backup = Join-Path $mods ('ProjectWilderness.backup_' + $stamp)
    Write-Host ('Backup: ' + $backup)
    if (!$WhatIfOnly) { Copy-Item -LiteralPath $dst -Destination $backup -Recurse -Force }
}
Write-Host ('Source: ' + $src)
Write-Host ('Destination: ' + $dst)
if (!$WhatIfOnly) {
    if (Test-Path $dst) { Remove-Item -LiteralPath $dst -Force -Recurse }
    Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
    Write-Host 'Installed. Enable Project Wilderness - V1 Dev in the game MODS menu AND your save.'
} else { Write-Host 'Dry run: no installation changed' }
