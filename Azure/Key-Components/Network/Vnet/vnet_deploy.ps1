# Check if variables.ps1 has been run
if (!$global:variablesConfigured) {
    Write-Host "Variables not configured. Please run variables.ps1 first."
    exit
}

# Set the Azure Subscription
Select-AzSubscription -SubscriptionId $global:subscriptionId

# Check if the Resource Group exists
$resourceGroup = Get-AzResourceGroup -Name $global:resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    # Create the Resource Group if it does not exist
    New-AzResourceGroup -Name $global:resourceGroupName -Location $global:azureRegion -Tag $global:tags
    Write-Host "Resource Group `'$global:resourceGroupName`' created."
} else {
    Write-Host "Using existing Resource Group `'$global:resourceGroupName`'."
}

# Loop through each VNet configuration
foreach ($vnetConfig in $global:vnets) {
    # Create the VNet
    $vnet = New-AzVirtualNetwork -Name $vnetConfig.Name -ResourceGroupName $global:resourceGroupName -Location $global:azureRegion -AddressPrefix $vnetConfig.AddressSpace -Tag $global:tags

    # Add each subnet to the VNet
    foreach ($subnetConfig in $vnetConfig.Subnets) {
        $subnet = Add-AzVirtualNetworkSubnetConfig -Name $subnetConfig.Name -AddressPrefix $subnetConfig.AddressPrefix -VirtualNetwork $vnet
    }

    # Apply the configuration
    Set-AzVirtualNetwork -VirtualNetwork $vnet
}

Write-Host "Deployment of VNets and Subnets complete."