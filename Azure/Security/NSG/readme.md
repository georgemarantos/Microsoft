# Azure Network Security Groups (NSGs)
## Overview
Azure Network Security Groups (NSGs) are used to filter network traffic to and from Azure resources in an Azure Virtual Network. NSGs can contain multiple inbound and outbound security rules that enable you to filter traffic to and from resources by source and destination IP address, port, and protocol. They are essential for controlling network security within Azure.

## Functionality
 - Traffic Filtering: Filter network traffic to and from Azure resources within an Azure Virtual Network.
 - Rule Assignment: Assign security rules to specific subnets or virtual machine network interfaces.
 - Priority-based Rules: Prioritize rules within the NSG to control traffic flow.
 - Stateful Firewall: Maintain information about active connections and tailor security rules based on the state of these connections.
 - Tag-based Rules: Utilize tags for streamlined management of rules across multiple resources.

## Use Cases
 - Network Segmentation: Implement network segmentation for enhanced security.
 - Micro-segmentation: Enable micro-segmentation to protect individual workloads.
 - Dev/Test Environments: Create isolated environments for development and testing.
 - Regulatory Compliance: Enforce network traffic rules to meet compliance requirements.

## Best Practices
1. Least Privilege Access: Implement the principle of least privilege to minimize exposure to attacks.
2. Rule Prioritization: Manage rule priority carefully to ensure desired traffic flow.
3. Regular Audits: Conduct regular audits of NSG rules for security compliance and optimization.
4. Tag Management: Utilize tags for efficient management of NSG rules.
5. Integration with Azure Services: Integrate NSGs with other Azure services like Azure Monitor and Azure Security Center.
6. Logging and Monitoring: Enable diagnostic logging and use Azure Network Watcher for monitoring.
7. Documentation: Maintain detailed documentation of NSG rules and configurations.
8. Change Management: Use a structured change management process for updating NSG rules.
