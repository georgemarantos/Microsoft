# This script will deploy an App Service and App Service plan and a private endpoint at once.
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

# Create the App Service Plan
Write-Host "App Service Plan: $appServicePlanName"
try {
    $appServicePlan = New-AzAppServicePlan -Name $appServicePlanName `
                                           -ResourceGroupName $resourceGroupName `
                                           -Location $region `
                                           -Tier $tier `
                                           -NumberofWorkers $workers `
                                           -WorkerSize $size
} catch {
    Write-Error "Failed to create App Service Plan: $_"
    exit
}

# Create the App Service
Write-Host "App Service: $appServiceName"
try {
    $appService = New-AzWebApp -Name $appServiceName `
                               -ResourceGroupName $resourceGroupName `
                               -Location $region `
                               -AppServicePlan $appServicePlan.Id
} catch {
    Write-Error "Failed to create App Service: $_"
    exit
}

# Enable HTTPS-only
if ($appService) {
    Set-AzWebApp -ResourceGroupName $resourceGroupName `
                 -Name $appServiceName `
                 -HttpsOnly $true
} else {
    Write-Error "App Service creation failed, cannot set HTTPS-only."
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

# Disable Public Network Access
Set-AzResource -ResourceId "/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Web/sites/$appServiceName/config/web" -Properties @{"publicNetworkAccess"="Disabled"} -ApiVersion "2021-02-01"

Write-Host "App Service '$appServiceName' has been successfully created on App Service Plan '$appServicePlanName' with private endpoint '$privateEndpointName'."
