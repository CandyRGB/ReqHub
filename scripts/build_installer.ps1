[CmdletBinding()]
param(
    [string]$MakeNsisPath,
    [switch]$SkipFlutterBuild
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$projectRoot = Split-Path -Parent $PSScriptRoot
$pubspecPath = Join-Path $projectRoot 'pubspec.yaml'
$installerScript = Join-Path $projectRoot 'installer\ReqHub.nsi'
$distDirectory = Join-Path $projectRoot 'dist'
$appIcon = Join-Path $projectRoot 'windows\runner\resources\app_icon.ico'

function Find-MakeNsis {
    param([string]$ExplicitPath)

    if ($ExplicitPath) {
        if (-not (Test-Path -LiteralPath $ExplicitPath -PathType Leaf)) {
            throw "makensis.exe was not found at: $ExplicitPath"
        }
        return (Resolve-Path -LiteralPath $ExplicitPath).Path
    }

    $command = Get-Command 'makensis.exe' -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    $candidates = @(
        @(
            (Join-Path ${env:ProgramFiles(x86)} 'NSIS\makensis.exe'),
            (Join-Path $env:ProgramFiles 'NSIS\makensis.exe')
        ) | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) }
    )

    if ($candidates.Count -gt 0) {
        return $candidates[0]
    }

    throw 'makensis.exe was not found. Add NSIS to PATH or pass -MakeNsisPath explicitly.'
}

$pubspec = Get-Content -LiteralPath $pubspecPath -Raw
$versionMatch = [regex]::Match($pubspec, '(?m)^version:\s*([0-9]+)\.([0-9]+)\.([0-9]+)(?:\+([0-9]+))?\s*$')
if (-not $versionMatch.Success) {
    throw 'Could not read a numeric version from pubspec.yaml.'
}

$appVersion = '{0}.{1}.{2}' -f $versionMatch.Groups[1].Value, $versionMatch.Groups[2].Value, $versionMatch.Groups[3].Value
$buildNumber = if ($versionMatch.Groups[4].Success) { $versionMatch.Groups[4].Value } else { '0' }
$numericVersion = "$appVersion.$buildNumber"

if (-not $SkipFlutterBuild) {
    $msBuildEnvironment = @{
        'MSBUILDDISABLENODEREUSE' = '1'
        'TrackFileAccess' = 'false'
        'UseMultiToolTask' = 'false'
    }
    $previousEnvironment = @{}

    foreach ($entry in $msBuildEnvironment.GetEnumerator()) {
        $previousEnvironment[$entry.Key] = [Environment]::GetEnvironmentVariable($entry.Key, 'Process')
        [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, 'Process')
    }

    Push-Location $projectRoot
    try {
        & flutter build windows --release
        if ($LASTEXITCODE -ne 0) {
            throw "Flutter Windows release build failed with exit code $LASTEXITCODE."
        }
    }
    finally {
        Pop-Location
        foreach ($entry in $previousEnvironment.GetEnumerator()) {
            [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, 'Process')
        }
    }
}

$releaseCandidates = @(
    (Join-Path $projectRoot 'build\windows\x64\runner\Release'),
    (Join-Path $projectRoot 'build\windows\runner\Release')
)
$releaseDirectory = $releaseCandidates | Where-Object {
    Test-Path -LiteralPath (Join-Path $_ 'reqhub.exe') -PathType Leaf
} | Select-Object -First 1

if (-not $releaseDirectory) {
    throw 'Flutter release output was not found. Run without -SkipFlutterBuild to create it.'
}

$makeNsis = Find-MakeNsis -ExplicitPath $MakeNsisPath
New-Item -ItemType Directory -Path $distDirectory -Force | Out-Null

$outputFile = Join-Path $distDirectory "ReqHub-Setup-$appVersion-x64.exe"
$arguments = @(
    '/V2',
    '/INPUTCHARSET',
    'UTF8',
    "/DAPP_VERSION=$appVersion",
    "/DAPP_VERSION_NUMERIC=$numericVersion",
    "/DBUILD_DIR=$releaseDirectory",
    "/DOUTPUT_FILE=$outputFile",
    "/DAPP_ICON=$appIcon",
    $installerScript
)

& $makeNsis @arguments
if ($LASTEXITCODE -ne 0) {
    throw "NSIS compilation failed with exit code $LASTEXITCODE."
}

$artifact = Get-Item -LiteralPath $outputFile
$hash = Get-FileHash -LiteralPath $outputFile -Algorithm SHA256

Write-Host ''
Write-Host "Installer: $($artifact.FullName)"
Write-Host "Size:      $([math]::Round($artifact.Length / 1MB, 2)) MB"
Write-Host "SHA-256:   $($hash.Hash)"
