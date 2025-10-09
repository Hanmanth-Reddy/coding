# Terminology:

Vnet (Virtual Netowrk) is regional
Vnet network(virtual network) peering

## RFC 1918 - Private CIDR
```
Class A - 10.0.0.0/8 (10.0.0.0 to 10.255.255.255)
Class B - 172.16.0.0/12 (172.16.0.0 to 172.31.255.255)
Class C - 192.168.0.0/16 (192.168.0.0 to 192.168.255.255)
```

Network 

Subnetworks 

## Default reserved IP's in N/W
1st IP - Network 
2nd IP - Gateway
3rd & 4th IP's - DNS servers
Last IP - Broadcost IP

## IP's
Private IP
Public IP (Dynamic , Static)

network security Groups (NSG)
inbound(ingress)/outbound(egress) 



Network security groups(NSG) needs attach to subnets and VM NIC's
VPC firewall rules 


Azure firewall
DNS

Routing

DNS


## Communication with internet.
by default all resources in Vnet can able to communicate with internet

## Communication Between resources
with in Virtual network(Vnet)
through Virtual network(Vnet) peering 
through service endpoints


## Commmunicate with on-prem Resources 
Site to Site VPN
Point to Site VPN ( Cisco Client, ..etc)
Azure Express Route

## Filter network Traffic 
Network Security groups(NSG)
Network Virtual appliance

## Route network traffic 
Route table 
Border gateway protocol(BGP) routes"




# Commands 
## TO create a Virtuals network
```bash
az network vnet create -g group-1 -n eastus-Vnet --address-prefix 10.0.0.0/16 --subnet-name subnet-1 --subnet-prefixes 10.0.0.0/24
```

## To create additional Subnet
```bash
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
```

## Vnet in Japan east region
```bash
az network vnet create -g group-2 -n japan-Vnet --address-prefix 10.1.0.0/16 --subnet-name subnet-1 --subnet-prefixes 10.1.0.0/24 --location japaneast

az network vnet create \
  --resource-group MyRG \
  --name MyVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name MySubnet \
  --subnet-prefix 10.0.1.0/24

# Add Subnet to VNet
az network vnet subnet create \
  --resource-group MyRG \
  --vnet-name MyVNet \
  --name Subnet2 \
  --address-prefix 10.0.2.0/24
```

## Create Network Security Group (NSG)
```bash
az network nsg create \
  --resource-group MyRG \
  --name MyNSG
```
## Create NSG Rule (Allow HTTP)  
```bash
az network nsg rule create \
  --resource-group MyRG \
  --nsg-name MyNSG \
  --name AllowHTTP \
  --priority 100 \
  --access Allow \
  --protocol Tcp \
  --direction Inbound \
  --destination-port-ranges 80
```

## VNet Peering
```bash
az network vnet peering create \
  --name VNet1-to-VNet2 \
  --resource-group MyRG \
  --vnet-name VNet1 \
  --remote-vnet VNet2 \
  --allow-vnet-access
```

## To create Azure Bastion
```bash
az network bastion create \
  --name MyBastion \
  --public-ip-address MyBastionIP \
  --resource-group MyRG \
  --vnet-name MyVNet  
```

## Service Endpoint (Enable on subnet)
```bash
az network vnet subnet update \
  --vnet-name MyVNet \
  --name MySubnet \
  --resource-group MyRG \
  --service-endpoints Microsoft.Storage
```

## Private Endpoint
```bash
az network private-endpoint create \
  --resource-group MyRG \
  --name MyPrivateEndpoint \
  --vnet-name MyVNet \
  --subnet MySubnet \
  --private-connection-resource-id <resource_id> \
  --group-id blob \
  --connection-name MyConnection
```

3. Communication with On-Prem Resources 🏢
## Site-to-Site VPN Gateway
```bash
az network vpn-gateway create \
  --resource-group MyRG \
  --name MyVPNGateway \
  --location eastus \
  --vnet MyVNet \
  --public-ip-address MyVPNIP
```

## Point-to-Site VPN Config
```bash
az network vpn-server-config create \
  --resource-group MyRG \
  --name MyP2SConfig \
  --vpn-client-address-pool 172.16.0.0/24
```

## ExpressRoute Circuit
```bash
az network express-route create \
  --resource-group MyRG \
  --name MyExpressRoute \
  --bandwidth 200 \
  --provider "Equinix" \
  --peering-location "Silicon Valley" \
  --sku-family MeteredData \
  --sku-tier Standard
```


4. Filtering Network Traffic 🚦
## Create Application Security Group (ASG)
```bash
az network asg create \
  --resource-group MyRG \
  --name MyAppSecurityGroup \
  --location eastus
```

## Azure Firewall
```bash
az network firewall create \
  --name MyFirewall \
  --resource-group MyRG \
  --vnet-name MyVNet
```
## Web Application Firewall (WAF) on Application Gateway
```bash
az network application-gateway waf-config set \
  --enabled true \
  --firewall-mode Prevention \
  --resource-group MyRG \
  --gateway-name MyAppGateway
```

## Enable DDoS Protection Plan
```bash
az network ddos-protection create \
  --resource-group MyRG \
  --name MyDDoSPlan
```

5. Routing Network Traffic 🛣️
## Create Route Table
```bash
az network route-table create \
  --name MyRouteTable \
  --resource-group MyRG
```

## Add User Defined Route (UDR)
```bash
az network route-table route create \
  --resource-group MyRG \
  --route-table-name MyRouteTable \
  --name MyRoute \
  --address-prefix 0.0.0.0/0 \
  --next-hop-type Internet
```

## Associate Route Table with Subnet
```bash
az network vnet subnet update \
  --vnet-name MyVNet \
  --name MySubnet \
  --resource-group MyRG \
  --route-table MyRouteTable
```

## NAT Gateway
```bash
az network nat gateway create \
  --resource-group MyRG \
  --name MyNatGateway \
  --public-ip-addresses MyPublicIP
```


6. Additional Networking Components 📦

## Load Balancer (Public)
```bash
az network lb create \
  --resource-group MyRG \
  --name MyLoadBalancer \
  --sku Standard \
  --frontend-ip-name MyFrontEnd \
  --backend-pool-name MyBackEndPool
```

## Application Gateway
```bash
az network application-gateway create \
  --name MyAppGateway \
  --resource-group MyRG \
  --capacity 2 \
  --sku WAF_v2 \
  --public-ip-address MyPublicIP \
  --vnet-name MyVNet \
  --subnet MySubnet
```

## Traffic Manager Profile
```bash
az network traffic-manager profile create \
  --name MyTrafficManager \
  --resource-group MyRG \
  --routing-method Priority \
  --unique-dns-name mytmprofile
```

## Front Door
```bash
az network front-door create \
  --resource-group MyRG \
  --name MyFrontDoor \
  --backend-address myapp.azurewebsites.net
```

## DNS Zone
```bash
az network dns zone create \
  --resource-group MyRG \
  --name mydomain.com
```
## Network Watcher
```bash
az network watcher configure \
  --resource-group MyRG \
  --locations eastus \
  --enabled true
```

## Virtual WAN
```bash
az network vwan create \
  --name MyVWAN \
  --resource-group MyRG \
  --location eastus
```