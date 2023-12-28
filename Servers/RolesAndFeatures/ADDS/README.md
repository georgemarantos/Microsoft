## Active Directory Domain Services
# What it is:
A directory service for Windows domain networks storing information about assets and users and information on which users have access to what which assets.

# Important protocols for AD DS to function:
- Kerberos for authentication.
- LDAP for accesing directory services across IP.
- DNS

# FSMO roles or Flexible Single Master Operation:
- <b>Schema Master:</b> Responsible for updating the directory schema for an entire forest. This role is often combined with the domain naming master.
- <b>Domain Naming Master:</b> Responsible for adding or removing domains from a forest. This role is often combined with the schema master.
- <b>RID Master Role:</b> Responsible for processing all RID pool requests. The SID for every security principal (objects like users, user groups) consists of a domain-specific SID and a RID specific to the specific object. Every domain controller in a domain has a set of RIDs it can use for the objects it creates however if the set is about to run out, the domain controller requests the RID master for more RIDs. 
- <b>PDC Emulator Role:</b> Responsible for telling the rest of the DCs what the time is. All other DCs in the domain sync with the PDC emulator. The PDC emulator also acts as the domain's authority on passwords for DCs. Any changes to the password are replicated preferentially to the PDC. If another DC gets an incorrect password, it first checks with the PDC to see if the password has been changed before telling the user that the password is wrong. 
- <b>Infrastructure Master role:</b> Responsible for having the updated SIDs and distinguished names for objects in a domain. When an object in a domain references another object, the infrastructure master DC will provide the updated data. The infrastructure master gets this data from the global catalog, and the role must be carried out by a server that doesn’t host the global catalog. 
