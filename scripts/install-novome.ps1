[CmdletBinding()]
param(
    [string]$Repository = "avarba/Novome",
    [string]$Ref = "core-1-plugin-validation",
    [string]$Marketplace = "novome",
    [string]$Plugin = "novome"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function Require-Command {
    param([Parameter(Mandatory = $true)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required command '$Name' was not found in PATH."
    }
}

function Invoke-CodexCommand {
    param(
        [Parameter(Mandatory = $true)][string[]]$Arguments,
        [switch]$AllowFailure
    )

    Write-Host ("> codex " + ($Arguments -join " "))
    $output = & codex @Arguments 2>&1
    $exitCode = $LASTEXITCODE

    if ($output) {
        $output | ForEach-Object { Write-Host $_ }
    }

    if (($exitCode -ne 0) -and (-not $AllowFailure)) {
        throw "Codex command failed with exit code $exitCode: codex $($Arguments -join ' ')"
    }

    return [pscustomobject]@{
        ExitCode = $exitCode
        Output = ($output | Out-String)
    }
}

function Read-JsonOrNull {
    param([string]$Text)

    try {
        return $Text | ConvertFrom-Json
    }
    catch {
        return $null
    }
}

Require-Command -Name "codex"
Require-Command -Name "git"

Write-Host "Installing Novome through the official Codex CLI..."

$marketplaceList = Invoke-CodexCommand -Arguments @("plugin", "marketplace", "list", "--json")
$marketplaceJson = Read-JsonOrNull -Text $marketplaceList.Output
$marketplaceExists = $false

if ($null -ne $marketplaceJson -and $null -ne $marketplaceJson.marketplaces) {
    $marketplaceExists = @($marketplaceJson.marketplaces | Where-Object { $_.name -eq $Marketplace }).Count -gt 0
}

if ($marketplaceExists) {
    Invoke-CodexCommand -Arguments @("plugin", "marketplace", "upgrade", $Marketplace, "--json") | Out-Null
}
else {
    Invoke-CodexCommand -Arguments @("plugin", "marketplace", "add", $Repository, "--ref", $Ref, "--json") | Out-Null
}

$pluginList = Invoke-CodexCommand -Arguments @("plugin", "list", "--json")
$pluginJson = Read-JsonOrNull -Text $pluginList.Output
$pluginInstalled = $false

if ($null -ne $pluginJson -and $null -ne $pluginJson.installed) {
    $pluginInstalled = @(
        $pluginJson.installed | Where-Object {
            ($_.name -eq $Plugin) -and ($_.marketplaceName -eq $Marketplace)
        }
    ).Count -gt 0
}

if ($pluginInstalled) {
    Invoke-CodexCommand -Arguments @("plugin", "remove", $Plugin, "--marketplace", $Marketplace, "--json") | Out-Null
}

Invoke-CodexCommand -Arguments @("plugin", "add", $Plugin, "--marketplace", $Marketplace, "--json") | Out-Null

$verification = Invoke-CodexCommand -Arguments @("plugin", "list", "--marketplace", $Marketplace, "--json")
$verificationJson = Read-JsonOrNull -Text $verification.Output
$verified = $false

if ($null -ne $verificationJson -and $null -ne $verificationJson.installed) {
    $verified = @(
        $verificationJson.installed | Where-Object {
            ($_.name -eq $Plugin) -and ($_.marketplaceName -eq $Marketplace) -and ($_.enabled -ne $false)
        }
    ).Count -gt 0
}

if (-not $verified) {
    throw "Novome was not found as an enabled installed plugin after installation. Review the command output above."
}

Write-Host ""
Write-Host "Novome is installed and enabled."
Write-Host "Close the current Codex session and start a new one before invoking `$novome-coach."
