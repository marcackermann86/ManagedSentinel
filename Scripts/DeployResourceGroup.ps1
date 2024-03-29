param (
    [Parameter(Mandatory=$true)]$Name,
    [Parameter(Mandatory=$true)]$Location,
    [Parameter(Mandatory=$true)]$Tag
)

Write-Host "Processing resource group $Name ..."
$rg = Get-AzResourceGroup -ResourceGroupName $Name -ErrorAction SilentlyContinue
if ($null -eq $rg) {
    New-AzResourceGroup -Name $Name -Location $Location -Tag $Tag
}
else {
    Write-Output "##vso[task.logissue type=error]Resource group $Name already exists. Exiting."
    exit 1
}
