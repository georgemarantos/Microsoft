# This script will deploy an App Service and App Service plan with default inbound public network access.
# Import variables from app-variables.ps1
. ./00-app-variables.ps1

# Set Variables
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$appServicePlanName = "asp-$appname-$securezone-$customer-$region-$appver"
$appServiceName = "as-$appname-$securezone-$customer-$region-$appver"

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
}

Write-Host "App Service '$appServiceName' has been successfully created on App Service Plan '$appServicePlanName'."
