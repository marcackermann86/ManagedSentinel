param (
    [Parameter(Mandatory=$true)]$OnboardingFile
)

#Adding AzSentinel module
Uninstall-AzureRm
Install-Module AzSentinelTools -Scope CurrentUser -AllowClobber -Force
Import-Module AzSentinelTools

$artifactName = "OnboardingFile"

#Build the full path for the onboarding file
$artifactPath = Join-Path $env:Pipeline_Workspace $artifactName 
$onboardingFilePath = Join-Path $artifactPath $OnboardingFile

$workspaces = Get-Content -Raw -Path $onboardingFilePath | ConvertFrom-Json

foreach ($item in $workspaces.deployments){
    Write-Host "Processing workspace $($item.workspace) ..."
    $rg = Get-AzResourceGroup -ResourceGroupName $($item.resourcegroup) -ErrorAction SilentlyContinue
    if ($null -eq $rg) {
        New-AzResourceGroup -Name $($item.resourcegroup) -Location $($item.location) -Tag @{H="$($item.hnumber)"}
    }
}
