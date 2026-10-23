$ErrorActionPreference = 'Stop'
$project = Split-Path -Parent $PSScriptRoot
$game = 'C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid'
$scripts = Join-Path $game 'media\scripts'
$config = Join-Path $project 'Contents\mods\ProjectWilderness\42\media\lua\shared\PW_Config.lua'
if (!(Test-Path -LiteralPath $scripts)) { throw "Game scripts not found: $scripts" }

$declared = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
Get-ChildItem -LiteralPath $scripts -Recurse -Filter '*.txt' -File | ForEach-Object {
    foreach ($line in Get-Content -LiteralPath $_.FullName) {
        if ($line -match '^\s*item\s+([A-Za-z0-9_]+)\b') { [void]$declared.Add('Base.' + $Matches[1]) }
    }
}

$text = Get-Content -Raw -LiteralPath $config
$ids = [regex]::Matches($text, "'([A-Za-z0-9_]+\.[A-Za-z0-9_]+)'") |
    ForEach-Object { $_.Groups[1].Value } | Sort-Object -Unique
$missing = @($ids | Where-Object { $_ -like 'Base.*' -and !$declared.Contains($_) })
if ($missing.Count) {
    $missing | ForEach-Object { Write-Host "FAIL missing item: $_" }
    exit 1
}
Write-Host "PASS: all $($ids.Count) configured Base item IDs exist in Build 42.21.0 scripts"

$required = @(
    'media\lua\client\PW_Bootstrap.lua',
    'media\lua\client\PW_Skills.lua',
    'media\lua\client\PW_Starter.lua',
    'media\lua\shared\PW_Config.lua',
    'media\scripts\pw_wilderness_recipes.txt'
)
$mod = Join-Path $project 'Contents\mods\ProjectWilderness\42'
$absent = @($required | Where-Object { !(Test-Path -LiteralPath (Join-Path $mod $_)) })
if ($absent.Count) { $absent | ForEach-Object { Write-Host "FAIL absent: $_" }; exit 1 }
Write-Host 'PASS: required Build 42 mod files are present'

$recipe = Get-Content -Raw -LiteralPath (Join-Path $mod 'media\scripts\pw_wilderness_recipes.txt')
foreach ($token in @('Base.TreeBranch2','mode:keep','MayDegradeLight','item 2 Base.Twigs')) {
    if (!$recipe.Contains($token)) { Write-Host "FAIL recipe token: $token"; exit 1 }
}
Write-Host 'PASS: custom kindling recipe has a consumed input and retained/degrading tool declaration'
