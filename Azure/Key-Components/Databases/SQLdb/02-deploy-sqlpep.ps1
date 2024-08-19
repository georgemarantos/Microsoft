# Import variables from app-variables.ps1
. ./app-variables.ps1

# Set SQL Server and Database Names
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$sqlServerName = "sql-$appname-$securezone-$customer-$region-$appver"
$sqlDatabaseName = "db-$appname-$securezone-$customer-$region-$appver"

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

# Get the SQL Server Id
$sqlServer = Get-AzSqlServer -ResourceGroupName $resourceGroupName -ServerName $sqlServerName

# Create Private Link Service Connection object
$privateLinkServiceConnection = @{
    Name                   = "connection-to-$sqlServerName"
    PrivateLinkServiceId   = $sqlServer.ResourceId
    GroupIds               = @("sqlServer")
    RequestMessage         = "Auto-approving connection to $sqlServerName"
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
Write-Host "Private Endpoint '$privateEndpointName' has been created and linked to the SQL Database '$sqlDatabaseName'."