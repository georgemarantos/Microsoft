## Group Policy
# Overview
Group Policy is a feature in Windows that provides centralized management and configuration of operating systems, applications, and users' settings in an Active Directory environment. It allows administrators to implement specific configurations for users and computers within the organization.

# How It Functions:
1. Group Policy Objects:
   - GPOs are the core of the Group Policy functionality. They contain specific settings made by administrators.
   - These settings are then applied to user and computer objects within Active Directory.
2. Scope of Management:
   - GPOs can be linked to domains, OUs (Organizational Units), and sites within Active Directory.
   - The scope defines which users and computers the policies apply to.
3. Policy Processing:
   - GPOs are processed in the following order: Local Group Policy, Site, Domain, and then OU.
   - Policies applied later can override those applied earlier.


# Best Practices:
1. Minimal Use of GPOs:
   - Use the minimum number of GPOs necessary to accomplish your objectives to avoid overloading the system.
2. Organize with OU Structure:
   - Design an Organizational Unit structure that mirrors the GPO application strategy for efficient policy application.
3. Consistent Naming Convention:
   - Adopt a clear and consistent naming convention for GPOs for easy identification and management.
4. Use Group Policy for Security Settings:
   - Leverage Group Policy for implementing security settings like password policies, user rights assignments, and audit policies.

# Troubleshooting:
Checks if the Group Policy Client service is running on the client machine.
```
Get-Service gpsvc | Select Status
```

Forces immediate update of group policies on a client.
```
gpupdate /force
```

Checks for Sysvol share availability and domain controller advertising.
```
dcdiag /e /test:sysvolcheck /test:advertising
```

Lists all GPOs with their status and version for version consistency check.
```
Get-GPO -All | ft DisplayName, GpoStatus, Version
```