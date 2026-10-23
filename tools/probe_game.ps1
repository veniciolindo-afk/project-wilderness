$ErrorActionPreference = 'Continue'
$project = Split-Path -Parent $PSScriptRoot
$paths = @(
  (Join-Path ${env:ProgramFiles(x86)} 'Steam\steamapps\common\ProjectZomboid'),
  (Join-Path $env:ProgramFiles 'Steam\steamapps\common\ProjectZomboid'),
  'C:\SteamLibrary\steamapps\common\ProjectZomboid',
  'D:\SteamLibrary\steamapps\common\ProjectZomboid',
  'E:\SteamLibrary\steamapps\common\ProjectZomboid',
  'D:\Games\Steam\steamapps\common\ProjectZomboid'
)
$found = @($paths | Where-Object { $_ -and (Test-Path $_) } | Select-Object -Unique)
$zomboidCache = Join-Path $env:USERPROFILE 'Zomboid'
$log = Join-Path $zomboidCache 'console.txt'
$reportPath = Join-Path $project 'docs\PROBE_LOCAL.txt'
$lines = @('PROJECT WILDERNESS: GAME PROBE', ('Date: ' + (Get-Date).ToString('s')), ('UserCache: ' + $zomboidCache))
foreach ($p in $found) {
 $lines += 'GameInstall: ' + $p
 $itemRoot = Join-Path $p 'media\scripts'
 if (Test-Path $itemRoot) {
   $allFiles = @(Get-ChildItem $itemRoot -Recurse -Filter '*.txt' -ErrorAction SilentlyContinue)
   $lines += 'ScriptFiles: ' + $allFiles.Count
   foreach ($key in @('Bag_BigHikingBag','TreeBranch2','SleepingBag','TentKit','WaterBottleFull','FishingRod','HuntingKnife')) {
     $pattern = '(?i)\bitem\s+' + [regex]::Escape($key) + '\b'
     $hits = @($allFiles | Select-String -Pattern $pattern -List -ErrorAction SilentlyContinue | Select-Object -First 2)
     $lines += ('ID: Base.' + $key + ' -> ' + $(if($hits.Count -gt 0){'FOUND '+($hits.Path -join ', ')}else{'NOT FOUND'}))
   }
 }
}
if ($found.Count -eq 0) { $lines += 'GameInstall: NOT FOUND IN COMMON STEAM PATHS. Ask Codex to locate steamapps/libraryfolders.vdf.' }
if (Test-Path $log) {
 $lines += 'CONSOLE.TXT LAST 80 Project Wilderness lines:'
 $lines += @(Get-Content $log -Tail 2500 -ErrorAction SilentlyContinue | Select-String -Pattern 'Project Wilderness' | Select-Object -Last 80)
} else { $lines += 'console.txt: not found' }
$lines | Set-Content -Path $reportPath -Encoding UTF8
$lines | ForEach-Object { Write-Host $_ }
Write-Host ('Report saved: ' + $reportPath)
