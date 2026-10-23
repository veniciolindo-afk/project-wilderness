$ErrorActionPreference = 'Stop'
$modsRoot = Join-Path $env:USERPROFILE 'Zomboid\mods'
$active = Join-Path $modsRoot 'default.txt'
if (!(Test-Path -LiteralPath $active)) { throw "Active mod list not found: $active" }
$text = Get-Content -Raw -LiteralPath $active
if ($text -match '(?m)^\s*mod\s*=\s*ProjectWilderness,\s*$') {
    Write-Host 'ProjectWilderness is already enabled in default.txt'
    exit 0
}
$stamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$backup = Join-Path $modsRoot ("default.txt.before-project-wilderness_$stamp.bak")
Copy-Item -LiteralPath $active -Destination $backup
$updated = $text -replace '(?m)^(mods\s*\{\s*)$', "`$1`r`n    mod = ProjectWilderness,"
if ($updated -eq $text) { throw 'Could not locate the mods block; original left unchanged' }
$updated | Set-Content -LiteralPath $active -Encoding UTF8
Write-Host "Backup: $backup"
Write-Host 'Enabled ProjectWilderness for the next game start. Existing saves were not changed.'
