## Active Directory Domain Services
# What it is:
A directory service that provides a centralized, hierarchical database of objects in a network (like users, computers, printers, and services) and allows administrators to manage permissions and access to network resources.

# Important protocols for AD DS to function:
- <b>LDAP (Lightweight Directory Access Protocol):</b> Used to query and modify items in Active Directory.
- <b>Kerberos:</b> A network authentication protocol within AD DS, providing secure authentication for user and computer accounts.
- <b>DNS (Domain Name System):</b> Essential for AD DS to function correctly as it relies on DNS for name resolution.
- <b>SMB (Server Message Block):</b> Used for file and printer sharing, as well as for access to remote file systems.
- <b>NTLM (NT LAN Manager):</b> An older security protocol, still supported in AD DS for backward compatibility.

# FSMO (Flexible Single Master Operation) Roles:
- <b>Enterprise-wide Operations:</b>
     - <b>Schema Master:</b> Responsible for managing changes to the schema, ensuring consistency across the forest. This role is often combined with the domain naming master.
     - <b>Domain Naming Master:</b> Responsible for adding or removing domains from a forest. This role is often combined with the schema master.
- <b>Domain Operations:</b>
     - <b>RID Master:</b> Responsible for processing all RID pool requests. The security identifiers (SIDs) for every security principal (objects like users, user groups) consists of a domain-specific SID and a RID specific to the specific object. Every domain controller in a domain has a set of RIDs it can use for the objects it creates however if the set is about to run out, the domain controller requests the RID master for more RIDs. 
     - <b>PDC Emulator:</b> Responsible for password changes and time synchronization within a domain. All other DCs in the domain sync with the PDC emulator. The PDC emulator also acts as the domain's authority on passwords for DCs. Any changes to the password are replicated preferentially to the PDC. If another DC gets an incorrect password, it first checks with the PDC to see if the password has been changed before telling the user that the password is wrong. 
     - <b>Infrastructure Master:</b> Responsible for maintains security identifiers (SIDs) and distinguished names for objects in other domains. When an object in a domain references another object, the infrastructure master DC will provide the updated data. The infrastructure master gets this data from the global catalog, and the role must be carried out by a server that doesn’t host the global catalog. 

# Global Catalog Servers:
