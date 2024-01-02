## Time Synchronization
# Overview
Time synchronization is a critical aspect of Active Directory Domain Services (AD DS). It ensures that all computers within an AD DS environment have their clocks set consistently. This is essential because many AD DS operations depend on the Kerberos authentication protocol, which requires time to be synchronized within a network to prevent replay attacks and ensure the security of the authentication process.

# How It Functions:
1. Hierarchy and Protocol:
   - AD DS uses the Network Time Protocol (NTP) for time synchronization.
   - In an AD DS environment, there is a hierarchy for how time is synchronized:
    - The Primary Domain Controller (PDC) emulator in the forest root domain is the authoritative time server for the entire forest.
    - Other domain controllers synchronize time with the PDC emulator.
    - Member servers and client computers, in turn, synchronize their time with a domain controller in their domain.
2. Kerberos Dependency:
   - Kerberos, the default authentication protocol in AD DS, is highly sensitive to time discrepancies.
   - Kerberos typically allows for a 5-minute time difference between the authenticating entities. Beyond this, authentication requests may fail.

# Best Practices:
1. Configure Authoritative Time Server:
   - Ensure that the PDC emulator in the forest root domain is configured to synchronize with a reliable external time source.
2. Time Source Hierarchy:
   - Maintain the default time synchronization hierarchy where domain controllers sync with the PDC emulator, and clients sync with their respective domain controllers.
3. Use Reliable External Time Sources:
   - Configure external time sources that are reliable and preferably use multiple sources to avoid issues if one goes down.
4. Security Considerations:
   - Secure your NTP traffic to prevent man-in-the-middle attacks that could manipulate time synchronization.

# Final Thoughts:
The PDC emulator should not be pointing to the CMOS or time drift will likely occur at some point and cause severe issues with users and servers on the network. Having the PDC point to a reliable external time source such as pool.ntp.org and the clients syncing to the domain controler should be the best configuration. I achieve this by running the following command on the PDC: ```w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org"```