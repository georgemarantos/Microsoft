# DNS
## Overview
Domain Name System (DNS) plays a pivotal role in Active Directory Domain Services (AD DS). It is essential for locating Active Directory domain controllers and services, enabling computers and users within an AD DS environment to find each other and communicate efficiently.

## How It Functions:
1. <b>Service Location:</b>
   - DNS is used in AD DS to locate services like domain controllers, global catalog servers, and other essential AD DS services.
   - AD DS relies on DNS service records (SRV records) to facilitate the location of these services.
2. <b>Domain Name Hierarchy:</b>
   - The structure of DNS domains often mirrors the structure of AD DS domains, providing a coherent naming structure for both.
3. <b>Dynamic DNS Updates:</b>
   - AD DS supports dynamic update of DNS records, allowing domain controllers and other AD DS resources to automatically register and update their DNS records as needed.

## Best Practices:
1. <b>Integrate DNS with AD DS:</b>
   - Where possible, use Active Directory-integrated DNS zones to leverage AD DS for DNS data replication and security
2. <b>Secure DNS Zones:</b>
   - Use secure dynamic updates, especially in Active Directory-integrated zones, to prevent unauthorized updates to DNS records.
   - Configure external time sources that are reliable and preferably use multiple sources to avoid issues if one goes down.
3. <b>Multiple DNS Servers:</b>
   - Deploy multiple DNS servers to provide redundancy and load balancing, ensuring DNS availability.</b>
4. <b>DNS Forwarders and Conditional Forwarders:
   - Use DNS forwarders and conditional forwarders to manage and optimize external DNS traffic.

## Things to Research:
DNSSEC