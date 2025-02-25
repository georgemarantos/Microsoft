# Set Application Variables
$appname = "gmarantos"
$securezone = "development"
$region = "eastus2"
$appver = "01"
$customer = "xxx"

# Set Application Sizing Variables

# TIER OPTIONS:
# - Free: Limited features, for testing purposes only
# - Basic: Single-instance, no auto-scale, cost-effective
# - Standard: Auto-scaling enabled, multiple instances
# - Premium: High-performance, advanced networking options
# - Isolated: Dedicated environment for high-security applications
$tier = "Basic"  # Choose from: Free, Basic, Standard, Premium, Isolated

# WORKER OPTIONS:
# - 1: Single worker instance (default for Basic tier)
# - 2-10: More workers, applicable to Standard, Premium, and Isolated tiers
$workers = "1"  # Number of worker instances, depends on the selected tier

# SIZE OPTIONS:
# - Small: Lower resource allocation, suitable for lightweight applications
# - Medium: Balanced compute and memory
# - Large: Higher compute and memory, suitable for intensive workloads
# - ExtraLarge: Maximum resources, for high-demand applications
$size = "Small"  # Choose from: Small, Medium, Large, ExtraLarge

# Set Networking Variables
$vnet = "vnet-gmarantos-sandbox-eastus2"
$subnet = "default"
$privateEndpointResourceGroup = "rg-gmarantos-development-eastus2"

Write-Host "Variables Have Been Set."
