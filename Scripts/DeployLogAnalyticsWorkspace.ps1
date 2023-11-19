param (
    [Parameter(Mandatory=$true)]$Name,
    [Parameter(Mandatory=$true)]$ResourceGroupName,
    [Parameter(Mandatory=$true)]$Location,
    [Parameter(Mandatory=$true)]$Tag
)

Write-Host "Processing workspace $Name ..."
$ws = Get-AzOperationalInsightsWorkspace -Name $Name -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue
if ($null -eq $ws) {
    New-AzOperationalInsightsWorkspace -Location $Location -Name $Name -ResourceGroupName $ResourceGroupName -Tag $Tag -RetentionInDays 90 -Sku pergb2018 -Confirm:$false
}
else {
    Write-Host "Log analytics workspace $Name already exists."
}
