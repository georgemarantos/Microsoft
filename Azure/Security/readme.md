# Microsoft Azure
## Welcome
The following are notes taken as I prepared for my Microsoft certification as well as common scripts and tools that I use in the field.

## Overview
Azure Security refers to the collective measures, tools, and practices in place to protect Azure-based applications, data, and infrastructure from cyber threats. As a major component of the Microsoft Azure Cloud platform, Azure Security is crucial for maintaining the integrity, confidentiality, and availability of cloud resources.

## Key Components:
- **[Azure Active Directory (Azure AD)](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/AzureAD)**
- **[Azure Firewall](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/Firewall)**
- **[Azure Security Center](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/Security-Center)**
- **[Azure Information Protection](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/AIP)**
- **[Azure Network Security Groups (NSGs)](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/NSG)**
- **[Azure Key Vault](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/Key-Vault)**
- **[Virtual Network (VNet) Service Endpoints:](https://github.com/georgemarantos/Microsoft/tree/main/Azure/Security/Service-Enpoints)**

## Best Practices:
1. Implement Strong Identity and Access Management:
   - Regularly review and enforce least privilege access using Azure AD and RBAC.
2. Secure Your Network:
   - Use NSGs, Azure Firewall, and Network Virtual Appliances (NVAs) for network segmentation and protection.
3. Enable Advanced Threat Protection:
   - Utilize Azure Security Center’s advanced threat protection capabilities for real-time threat detection and response.
4. Encrypt Sensitive Data:
   - Apply Azure’s encryption features for data at rest and in transit, and manage encryption keys with Azure Key Vault.
5. Monitor and Log Activity:
   - Enable Azure Monitor and Azure Log Analytics to collect, analyze, and act on telemetry data from your Azure and on-premises environments.
6. Regularly Assess and Remediate Vulnerabilities:
   - Conduct frequent security assessments using Azure Security Center and remediate identified vulnerabilities.