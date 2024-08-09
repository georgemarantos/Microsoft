# Import variables from variables.ps1
. "$(Join-Path -Path $PSScriptRoot -ChildPath 'variables.ps1')"

# Set Variables
$resourceGroupName = "rg-$appname-$customer-$securezone-$region-$appver"
$appServicePlanName = "asp-$appname-$customer-$securezone-$region-$appver"
$appServiceName = "as-$appname-$customer-$securezone-$region-$appver"

# Check if the Resource Group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue

if (-not $resourceGroup) {
    Write-Error "Error, create resource group with proper tagging and then run script again"
    exit
}

# Create the App Service Plan
$appServicePlan = New-AzAppServicePlan -Name $appServicePlanName `
                                       -ResourceGroupName $resourceGroupName `
                                       -Location $region `
                                       -Tier "Basic" `
                                       -NumberofWorkers 1 `
                                       -WorkerSize "Small"

# Create the App Service
$appService = New-AzWebApp -Name $appServiceName `
                           -ResourceGroupName $resourceGroupName `
                           -Location $region `
                           -AppServicePlan $appServicePlan.Id

# Enable HTTPS-only
Set-AzWebApp -ResourceGroupName $resourceGroupName `
             -Name $appServiceName `
             -HttpsOnly $true
 
Write-Host "App Service '$appServiceName' has been successfully created on App Service Plan '$appServicePlanName'."
