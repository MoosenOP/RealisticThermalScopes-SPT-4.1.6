param(
    [Parameter(Mandatory=$true)][string]$SptRoot
)
$ErrorActionPreference = 'Stop'
$kit = Split-Path -Parent $MyInvocation.MyCommand.Path
$runtime = Join-Path $SptRoot 'SPT_Runtime'
$modName = 'FiveF-realisticThermalScopes_lessPixelated'
$refDir = Join-Path $kit 'references'
$source = Join-Path $kit 'src'
$project = Join-Path $source 'realisticThermalScopes-lessPixelated.csproj'

if (!(Get-Command dotnet -ErrorAction SilentlyContinue)) { throw 'The .NET SDK is required.' }
if (!(Test-Path -LiteralPath $runtime -PathType Container)) { throw "Missing SPT runtime: $runtime" }
$srcText = Get-Content -LiteralPath (Join-Path $source 'realisticThermalScopes-lessPixelated.cs') -Raw
$csprojText = Get-Content -LiteralPath $project -Raw
if (!$srcText.Contains('new("1.0.1")') -or !$csprojText.Contains('<Version>1.0.1</Version>')) {
    throw 'The C# mod metadata and project must both be version 1.0.1.'
}

New-Item -ItemType Directory -Force -Path $refDir | Out-Null
$names = @('SPTarkov.Common.dll','SPTarkov.DI.dll','SPTarkov.Reflection.dll','SPTarkov.Server.Core.dll','SemanticVersioning.dll')
foreach ($name in $names) {
    $path = Join-Path $runtime $name
    if (!(Test-Path -LiteralPath $path -PathType Leaf)) { throw "Required SPT 4.1.6 assembly not found: $path" }
    Copy-Item -LiteralPath $path -Destination (Join-Path $refDir $name) -Force
    Write-Host "Reference $name"
}

& dotnet build $project -c Release --nologo
if ($LASTEXITCODE -ne 0) { throw "Build failed (exit $LASTEXITCODE). Do not install this candidate." }
$dll = Join-Path $source 'bin/Release/net10.0/realisticThermalScopes-lessPixelated.dll'
if (!(Test-Path -LiteralPath $dll -PathType Leaf)) { throw "Compiled DLL missing: $dll" }

$dist = Join-Path $kit 'dist'
$modDir = Join-Path $dist "SPT_Runtime/user/mods/$modName"
if (Test-Path -LiteralPath $dist) { Remove-Item -LiteralPath $dist -Force -Recurse }
New-Item -ItemType Directory -Force -Path $modDir | Out-Null
Copy-Item -LiteralPath $dll -Destination (Join-Path $modDir 'realisticThermalScopes-lessPixelated.dll') -Force
Copy-Item -LiteralPath (Join-Path $kit 'assets/bundles.json') -Destination (Join-Path $modDir 'bundles.json') -Force
Copy-Item -LiteralPath (Join-Path $kit 'assets/bundles') -Destination (Join-Path $modDir 'bundles') -Recurse -Force
Copy-Item -LiteralPath (Join-Path $kit 'LICENSE') -Destination (Join-Path $modDir 'LICENSE') -Force
Copy-Item -LiteralPath (Join-Path $kit 'README.md') -Destination (Join-Path $modDir 'README.md') -Force
Copy-Item -LiteralPath (Join-Path $kit 'CHANGELOG.md') -Destination (Join-Path $modDir 'CHANGELOG.md') -Force

$manifest = Get-Content -LiteralPath (Join-Path $modDir 'bundles.json') -Raw | ConvertFrom-Json
if ($manifest.manifest.Count -ne 7) { throw 'Expected exactly 7 bundle manifest entries.' }
foreach ($bundle in $manifest.manifest) {
    $target = Join-Path (Join-Path $modDir 'bundles') ($bundle.key.Replace('/', '\'))
    if (!(Test-Path -LiteralPath $target -PathType Leaf)) { throw "Bundle missing after staging: $target" }
}
$zip = Join-Path $kit 'RealisticThermalScopes_v1.0.1_SPT416_ReleaseCandidate.zip'
if (Test-Path -LiteralPath $zip) { Remove-Item -LiteralPath $zip -Force }
Compress-Archive -Path (Join-Path $dist 'SPT_Runtime') -DestinationPath $zip -CompressionLevel Optimal
if (!(Test-Path -LiteralPath $zip -PathType Leaf)) { throw "Release candidate not created: $zip" }
Write-Host "Created $zip"
Write-Host 'SHA256 checksums for VirusTotal / release verification:'
Get-FileHash -Algorithm SHA256 -LiteralPath $zip | Format-List Path,Hash
Get-FileHash -Algorithm SHA256 -LiteralPath $dll | Format-List Path,Hash
Write-Host 'Before publishing: replace prior RTS mod folder, verify startup and enhanced visuals in game, scan this exact ZIP and DLL on VirusTotal.'
