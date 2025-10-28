**Dynamic Host Configuration Protocol (DHCP)** is a network management protocol that automates `IP address assignment` and `network configuration.`

DHCP server manages `IP pools` and `leases` addresses to clients dynamically


**DHCP terms:** Scope, Lease, Reservation, Exclusion, Relay , DHCP DORA process (Discover ® Offer ® Request ® Acknowledge)

DHCP follows a four-step DORA process for IP allocation.

The DHCP server listens on UDP port 67, clients use port 68.


DHCP Relay Agent (IP helper) help clients in different subnets reach the server.

DHCP leases are time-based and renewed automatically.


### DNS Configuration 


# DHCP Configuration Snippets for Different Network Environments

## 1. Basic Subnet Configuration with Range and Router Options

**Ubuntu / Debian (`/etc/dhcp/dhcpd.conf`):**
```bash
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.10 192.168.1.100;
  option routers 192.168.1.1;
  option domain-name-servers 8.8.8.8, 8.8.4.4;
  default-lease-time 600;
  max-lease-time 7200;
}
```

**2. Static IP Reservation Using MAC Address**
```bash
host printer01 {
  hardware ethernet 00:1A:2B:3C:4D:5E;
  fixed-address 192.168.1.200;
}
```



3. Multiple Subnet Handling
```bash
# Subnet 192.168.1.0/24
subnet 192.168.1.0 netmask 255.255.255.0 {
  range 192.168.1.10 192.168.1.100;
  option routers 192.168.1.1;
}

# Subnet 192.168.2.0/24
subnet 192.168.2.0 netmask 255.255.255.0 {
  range 192.168.2.10 192.168.2.100;
  option routers 192.168.2.1;
}
```

4. DHCP Relay Setup with IP Helper-Address
```bash
# On router interface facing the subnet
interface GigabitEthernet0/1
 ip helper-address 192.168.1.254   # DHCP server IP
## This forwards DHCP requests from clients in one subnet to the DHCP server in another subnet.
```


5. Integration with DNS Servers
```bash
# In dhcpd.conf
option domain-name "example.com";
option domain-name-servers 8.8.8.8, 8.8.4.4;

# For Dynamic DNS updates (optional)
ddns-update-style interim;
zone example.com. {
  primary 192.168.1.10;
  key rndc-key;
}
```

**Ubuntu/Debian:**
```bash
apt install isc-dhcp-server
/etc/default/isc-dhcp-server
sudo dhcpd -t
sudo systemctl restart isc-dhcp-server
```

/etc/dhcp/dhcpd.conf, 

**RHEL/CentOS/Rocky:**
```bash
yum install dhcp-server
/etc/default/dhcpd.conf
sudo dhcpd -t
sudo systemctl restart dhcpd
```

#### Debug
• **Check service:** systemctl status dhcpd or isc-dhcp-server
• **Syntax check:** dhcpd -t
• **Logs:** journalctl -u dhcpd or /var/log/syslog
• **Packet capture:** tcpdump -n port 67 or 68





# DHCP client 


## Ubuntu
```bash
sudo apt update
sudo apt install isc-dhcp-client -y


# Identify your network interface
ip link

# Bring interface up
sudo ip link set dev <interface> up

# Request IP via DHCP
sudo dhclient <interface>
sudo dhclient enp0s3

## Release IP address
sudo dhclient -r <interface>  



sudo nano /etc/netplan/01-netcfg.yaml

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s3:
      dhcp4: true
      dhcp6: false
```

sudo netplan apply
ip addr show enp0s3

```










## RHEL
```bash

sudo yum install dhclient -y   # RHEL7
sudo dnf install dhclient -y   # RHEL8/9

# Identify your network interface
ip link

# Bring interface up
sudo ip link set dev <interface> up

# Request IP via DHCP
sudo dhclient <interface>


Edit network interface file:
RHEL7: /etc/sysconfig/network-scripts/ifcfg-<interface>
RHEL8/9: NetworkManager handles it, but old config files still work.

nano /etc/sysconfig/network-scripts/ifcfg-enp0s3
DEVICE=enp0s3
BOOTPROTO=dhcp
ONBOOT=yes
TYPE=Ethernet



# RHEL7
sudo systemctl restart network

# RHEL8/9
sudo nmcli connection reload
sudo nmcli connection up enp0s3


## Verfy IP
ip addr show enp0s3



## Using nmcli (NetworkManager CLI)
You can also configure DHCP via nmcli without editing files:
# Set interface to use DHCP
sudo nmcli con mod enp0s3 ipv4.method auto

# Bring it up
sudo nmcli con up enp0s3

```

----------------------------------------------------------------------------------
| OS     | Temp DHCP       | Persistent DHCP                                     |
| ------ | --------------- | --------------------------------------------------- |
| Ubuntu | `sudo dhclient` | Netplan (`/etc/netplan/*.yaml`)                     |
| RHEL   | `sudo dhclient` | `/etc/sysconfig/network-scripts/ifcfg-*` or `nmcli` |
----------------------------------------------------------------------------------

