# 🌐 Cloud Networking Terminologies
## 🔹 Core Concepts

### VNet / VPC

Azure → Virtual Network (VNet) (regional)

AWS → Virtual Private Cloud (VPC) (regional)

GCP → VPC Network (global, but subnets are regional)

### Subnet / Subnetworks

Azure → Subnet (inside a VNet)

AWS → Subnet (inside a VPC, tied to an AZ)

GCP → Subnet (regional, part of global VPC)

### Private IP ranges

RFC 1918 (Class A, B, C ranges — same across all clouds)

### Reserved IPs

Azure → 5 IPs reserved per subnet (1st: network, 2nd: gateway, 3–4: DNS, last: broadcast)

AWS → 5 IPs reserved per subnet (same roles)

GCP → 4 IPs reserved per subnet (network, gateway, DNS, broadcast not exposed)

## 🔹 Connectivity

### Peering

Azure → VNet Peering (regional/global)

AWS → VPC Peering (cross-region possible)

GCP → VPC Peering (global)

### Hybrid Connectivity

Azure → VPN Gateway, ExpressRoute

AWS → VPN Gateway, Direct Connect

GCP → Cloud VPN, Cloud Interconnect

### Load Balancing

Azure → Azure Load Balancer (L4), Application Gateway (L7), Front Door, Traffic Manager (DNS-based)

AWS → ELB/ALB/NLB (L4/L7)

GCP → Cloud Load Balancing (global, L4/L7)

##🔹 Security

### Security groups

Azure → NSG (Network Security Group), ASG (Application Security Group)

AWS → Security Groups, NACLs (Network ACLs)

GCP → Firewall Rules (at VPC-level, tag/service account-based)

### Firewall

Azure → Azure Firewall

AWS → AWS Network Firewall

GCP → Cloud Firewall (built-in), Cloud Armor (L7 DDoS/WAF)

### DDoS Protection

Azure → DDoS Protection Standard

AWS → AWS Shield (Standard, Advanced)

GCP → Cloud Armor

## 🔹 Routing & NAT

### Routing Tables

Azure → Route Table (UDR – User Defined Route)

AWS → Route Table (per subnet or VPC)

GCP → Routes (system-generated + custom)

### NAT

Azure → NAT Gateway

AWS → NAT Gateway, NAT Instance

GCP → Cloud NAT

## 🔹 DNS & IPs

### DNS

Azure → Azure DNS, Private DNS Zones

AWS → Route 53 (public & private zones)

GCP → Cloud DNS (public & private zones)

### IP Types

Azure → Private IP, Public IP (dynamic/static)

AWS → Private IP, Public IP, Elastic IP (static)

GCP → Private IP, Ephemeral External IP, Static External IP

## 🔹 Advanced Networking

Service Endpoints / Private Access

Azure → Service Endpoints, Private Link

AWS → VPC Endpoints (Interface & Gateway), PrivateLink

GCP → Private Service Connect (PSC), VPC Service Controls

### Transit Networking

Azure → Virtual WAN, Hub-Spoke model

AWS → Transit Gateway

GCP → Network Connectivity Center, VPC SC

### Proxy / Gateway

Azure → Application Gateway, API Management, Front Door

AWS → API Gateway, App Mesh

GCP → API Gateway, Cloud Endpoints, Global LB

Identity-based Access

Azure → Managed Identity + NSG rules with ASGs

AWS → Security Groups tied with IAM roles

GCP → Firewall rules using Service Accounts

gcloud iam 



User,Group,Service Account , G Suite / Google Workspace (Google Cloud Identity + Productivity apps like Gmail, Calendar, Drive, Docs, Sheets, Meet), domain


gcloud projects add-iam-policy-binding my-project \
  --member="serviceAccount:ci-bot@my-project.iam.gserviceaccount.com" \
  --role="roles/storage.admin"

Service Account format:
serviceaccoutname@<project-id>.iam.gserviceaccount.com

Consider all above conversation and provide all Azure and AWS IAM conecpts, I want to learn
