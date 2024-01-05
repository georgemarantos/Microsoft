# Set Azure Subscription ID
$global:subscriptionId = "your-subscription-id"

# Set Resource Group Name
$global:resourceGroupName = "your-resource-group-name"

# Set Region for Resource Group and VNets
$global:azureRegion = "East US"

# Set Mandatory Tags
$global:tags = @{
    Environment = "Prod";
    Owner = "YourName";
    Requester = "RequesterName";
#   Division = "DivisionCode";
    Department = "ResourceDepartment";
    AccountNumber = "AccountNumberCode"
}

# Define VNets and their properties
$global:vnets = @(
    @{
        Name = "VNet1";
        AddressSpace = "10.0.0.0/16";
        Subnets = @(
            @{ Name = "Subnet1"; AddressPrefix = "10.0.1.0/24" },
            @{ Name = "Subnet2"; AddressPrefix = "10.0.2.0/24" },
            @{ Name = "Subnet3"; AddressPrefix = "10.0.3.0/24" }
        )
    },
    @{
        Name = "VNet2";
        AddressSpace = "10.1.0.0/16";
        Subnets = @(
            @{ Name = "Subnet1"; AddressPrefix = "10.1.1.0/24" },
            @{ Name = "Subnet2"; AddressPrefix = "10.1.2.0/24" },
            @{ Name = "Subnet3"; AddressPrefix = "10.1.3.0/24" }
        )
    },
    @{
        Name = "VNet3";
        AddressSpace = "10.2.0.0/16";
        Subnets = @(
            @{ Name = "Subnet1"; AddressPrefix = "10.2.1.0/24" },
            @{ Name = "Subnet2"; AddressPrefix = "10.2.2.0/24" },
            @{ Name = "Subnet3"; AddressPrefix = "10.2.3.0/24" }
        )
    }
)

# Indicate that the variables have been set
$global:variablesConfigured = $true
