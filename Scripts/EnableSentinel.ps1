param (
    [Parameter(Mandatory=$true)]$Name,
    [Parameter(Mandatory=$true)]$ResourceGroupName
)

Write-Host "Processing workspace $Name ..."
$solutions = Get-AzOperationalInsightsIntelligencePack -ResourceGroupName $ResourceGroupName -WorkspaceName $Name -WarningAction:SilentlyContinue

if (($solutions | Where-Object Name -eq 'SecurityInsights').Enabled) {
    Write-Host "SecurityInsights solution is already enabled for workspace $Name"
}
else {
    Set-AzSentinel -WorkspaceName $Name -Confirm:$false
}
