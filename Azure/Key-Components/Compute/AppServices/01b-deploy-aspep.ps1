# This is optional step and only needed to be run if you need to add private endpoint to an already deployed app service. 
# Import variables from app-variables.ps1
. ./00-app-variables.ps1

# Set App Variables
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$appServicePlanName = "asp-$appname-$securezone-$customer-$region-$appver"
$appServiceName = "as-$appname-$securezone-$customer-$region-$appver"

# Set Private Endpoint Variables
$virtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $privateEndpointResourceGroup -Name $vnet
$subnetId = $virtualNetwork.Subnets | Where-Object { $_.Name -eq $subnet }
$privateEndpointName = "pep-$appname-$securezone-$customer-$region-$appver"

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "Error, create resource group with proper tagging and then run script again"
    exit
}

# Get the App Service Id
$appService = Get-AzWebApp -ResourceGroupName $resourceGroupName -Name $appServiceName

# Create Private Link Service Connection object
$privateLinkServiceConnection = @{
    Name                   = "connection-to-$appServiceName"
    PrivateLinkServiceId   = $appService.Id
    GroupIds               = @("sites")
    RequestMessage         = "Auto-approving connection to $appServiceName"
}

# Convert hashtable to a PSPrivateLinkServiceConnection object
$privateLinkServiceConnectionObj = New-Object -TypeName Microsoft.Azure.Commands.Network.Models.PSPrivateLinkServiceConnection -Property $privateLinkServiceConnection

# Create the Private Endpoint
$privateEndpoint = New-AzPrivateEndpoint -ResourceGroupName $resourceGroupName `
    -Name $privateEndpointName `
    -Location $region `
    -Subnet $subnetId `
    -PrivateLinkServiceConnection $privateLinkServiceConnectionObj

# Output private endpoint details
Write-Host "Private Endpoint '$privateEndpointName' has been created and linked to the App Service '$appServiceName'."
