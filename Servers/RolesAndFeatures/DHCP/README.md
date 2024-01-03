# DHCP
## Overview
Dynamic Host Configuration Protocol (DHCP) is a network management protocol used on Internet Protocol (IP) networks. In a Windows Server environment, the DHCP role is crucial for automatically assigning IP addresses and other network configuration parameters to devices on the network, thereby reducing the need for a network administrator to manually assign IP addresses to all networked devices.

## How It Functions:
1. <b>IP Address Allocation:</b>
   - DHCP servers assign IP addresses to clients for a set lease period. This allocation can be dynamic (changing each time a device connects to the network) or reserved (permanently assigning a specific IP address to a particular device).
   - AD DS relies on DNS service records (SRV records) to facilitate the location of these services.
2. <b>Network Configuration:</b>
   - Beyond IP addresses, DHCP also assigns other necessary configuration information to clients, such as subnet mask, default gateway, and DNS server addresses.
3. <b>Lease Management:</b>
   - DHCP manages the lease time for IP addresses. When a lease expires, the IP address is returned to the pool for reallocation.
4. <b>Renewal and Rebinding:</b>
   - DHCP clients attempt to renew their lease as it nears expiration. If the original DHCP server is unreachable during renewal, clients try rebinding with any available DHCP server to maintain network connectivity.

## Best Practices:
1. <b>High Availability:</b>
   - Implement DHCP failover or clustering to ensure continuous network service availability.
2. <b>Secure DHCP Configuration:</b>
   - Enable DHCP audit logging for tracking client-server transactions and potential unauthorized access.
   - Implement DHCP snooping on network switches if available to prevent rogue DHCP servers.
3. <b>Scope and Lease Management:</b>
   - Set lease duration based on the type of network and client mobility. Shorter leases for Wi-Fi networks and longer leases for more static networks.
4. <b>Reservations and Exclusions:</b>
   - Use address reservations for devices that need a constant IP address, such as printers and servers.
   - Set exclusions to prevent DHCP from assigning specific IP addresses that are in use or reserved for other purposes.
5. <b>Integration with DNS:</b>
   - Enable dynamic update of DNS records from DHCP to maintain current DNS information for network hosts.