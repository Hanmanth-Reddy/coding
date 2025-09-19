# Azure Networking Overview

## 1. Communication with Internet 🌍
- **Outbound internet access**: By default, all Azure resources in a VNet can communicate **outbound** to the internet.  
- **Inbound internet access**: Blocked by default; requires:  
  - **Public IP address** (Basic/Standard SKU)  
  - **Azure Load Balancer / Application Gateway / NAT Gateway**  
  - **Firewall rules** or **NSG rules** to allow inbound  

---

## 2. Communication Between Azure Resources 🔗
- **Within same VNet**: Resources can communicate freely (unless blocked by NSG).  
- **Across VNets**:  
  - **VNet Peering** – private, low-latency, high-bandwidth connection between VNets (can be in different regions).  
  - **VNet-to-VNet VPN** – encrypted tunnel, often used across regions when peering isn’t possible.  
- **Through Service Endpoints**: Connect securely to Azure services (Storage, SQL, etc.) via Azure backbone (still uses public IP of service).  
- **Private Link / Private Endpoint**: Access PaaS services privately over your VNet (no public exposure).  
- **Azure Bastion**: Secure RDP/SSH to VMs without exposing public IPs.  

---

## 3. Communication with On-Prem Resources 🏢
- **Site-to-Site VPN (IPsec/IKE)** – connects your on-premises network to Azure VNet via VPN device.  
- **Point-to-Site VPN** – individual clients (laptops, remote users) connect securely. Supports:  
  - Native Azure VPN client  
  - OpenVPN / IKEv2 / SSTP / Cisco AnyConnect, etc.  
- **Azure ExpressRoute** – private dedicated connection to Azure (doesn’t traverse internet).  
- **ExpressRoute Direct** – dual 100 Gbps connections for high availability.  
- **ExpressRoute Global Reach** – connect multiple on-prem locations via Microsoft backbone.  

---

## 4. Filtering Network Traffic 🚦
- **Network Security Groups (NSG)** – basic inbound/outbound rules at subnet or NIC level.  
- **Application Security Groups (ASG)** – group VMs logically and apply NSG rules.  
- **Azure Firewall** – fully managed, stateful firewall with threat intelligence.  
- **Web Application Firewall (WAF)** – protects web apps (via Application Gateway, Front Door, or CDN).  
- **Network Virtual Appliances (NVA)** – third-party firewalls (Cisco, Palo Alto, Fortinet, etc.).  
- **DDoS Protection**:  
  - Basic (free, automatic)  
  - Standard (enhanced protection with telemetry & mitigation).  

---

## 5. Routing Network Traffic 🛣️
- **System routes**: Default routes automatically created by Azure.  
- **User-defined routes (UDR)**: Custom routes to control traffic flow (e.g., force tunneling).  
- **NAT Gateway**: Provide scalable outbound internet connectivity with SNAT.  
- **Route Table**: Attach to subnets to override system routes.  
- **BGP (Border Gateway Protocol)**: Used with ExpressRoute / VPN to advertise routes dynamically.  

---

## 6. Additional Networking Components 📦
- **Azure Load Balancer**: Distributes traffic at L4 (TCP/UDP).  
- **Application Gateway**: L7 load balancer with SSL offload, WAF, URL-based routing.  
- **Traffic Manager**: DNS-based global traffic distribution.  
- **Front Door**: Global application acceleration + WAF + SSL offloading at Microsoft edge.  
- **Azure DNS / Private DNS Zones**: Manage public and private DNS resolution.  
- **Azure Monitor / Network Watcher**: Packet capture, connection monitor, topology view.  
- **Virtual WAN**: Unified hub-and-spoke networking for large enterprises.  
