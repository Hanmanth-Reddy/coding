# TO create a Virtuals network 
az network vnet create -g group-1 -n eastus-Vnet --address-prefix 10.0.0.0/16 --subnet-name subnet-1 --subnet-prefixes 10.0.0.0/24

## To create additional Subnet
az network vnet subnet create \
  --resource-group <resource-group-name> \
  --vnet-name <vnet-name> \
  --name <subnet-name> \
  --address-prefix <CIDR-block>

az network vnet subnet create \
  --resource-group group-1 \
  --vnet-name eastus-Vnet \
  --name subnet-2 \
  --address-prefix 10.0.1.0/24


## Vnet in Japan east region
az network vnet create -g group-2 -n japan-Vnet --address-prefix 10.1.0.0/16 --subnet-name subnet-1 --subnet-prefixes 10.1.0.0/24 --location japaneast



## Terminology:

Vnet is regional.

<b>RFC 1918 Private CIDR ranges<b>
```
Class A - 10.0.0.0/8 (10.0.0.0 to 10.255.255.255)
Class B - 172.16.0.0/12 (172.16.0.0 to 172.31.255.255)
Class C - 192.168.0.0/16 (192.168.0.0 to 192.168.255.255)
```

Public IP & Private IP

By Default Azure will reserve 5 IP's in each subnetwork.
````
1st IP - Network 
2nd IP - gateway
3rd & 4th IP's - DNS servers
```

Network level- network security Groups(NSG)
inbound/outbound 
Azure firewall
DNS
virtual network peering
routing