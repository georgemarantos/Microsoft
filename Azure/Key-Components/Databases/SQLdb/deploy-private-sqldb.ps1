# Import Variables from the first script
. ./sql-variables.ps1

# Set SQL Server and Database Names
$resourceGroupName = "rg-$appname-$securezone-$customer-$region-$appver"
$sqlServerName = "sql-$appname-$securezone-$customer-$region-$appver"
$sqlDatabaseName = "db-$appname-$securezone-$customer-$region-$appver"

# Check if the resource group exists
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName -ErrorAction SilentlyContinue
if (-not $resourceGroup) {
    Write-Error "No Resource Group Found! Create a resource group first with proper tagging policy and then run script again"
    exit
}

# Set Private Endpoint Variables
$virtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $privateEndpointResourceGroup -Name $vnet
$subnetId = $virtualNetwork.Subnets | Where-Object { $_.Name -eq $subnet }
$privateEndpointName = "pep-$appname-$securezone-$customer-$region-$appver"

# Set Entra ID Security Group as SQL Server Admin
$groupDn = (Get-AzADGroup -DisplayName "Cloud DBAdmins").DisplayName

# Create the SQL Server
Write-Host "Creating Azure SQL Server: $sqlServerName"
New-AzSqlServer -ResourceGroupName $resourceGroupName -ExternalAdminName $groupDn `
    -ServerName $sqlServerName `
    -Location $region `
    -ServerVersion "12.0" `
	-EnableActiveDirectoryOnlyAuthentication

# Set Entra ID Security Group as SQL Server Admin
$groupId = (Get-AzADGroup -DisplayName "Cloud DBAdmins").Id

Set-AzSqlServerActiveDirectoryAdministrator -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -DisplayName "Cloud DBAdmins" `
    -ObjectId $groupId `

# Create the SQL Database 
Write-Host "Creating Azure SQL Database: $sqlDatabaseName"
New-AzSqlDatabase -ResourceGroupName $resourceGroupName `
    -ServerName $sqlServerName `
    -DatabaseName $sqlDatabaseName `
    -RequestedServiceObjectiveName "S2" `
    -MaxSizeBytes 250GB `
    -Edition "Standard" `
    -BackupStorageRedundancy "Local"

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
	
Write-Host "Azure SQL Server $sqlServerName with 'Cloud DBAdmins' as the admin and Database $sqlDatabaseName have been created successfully with private endpoint '$privateEndpointName configured."
