# 🌐 Cloud Networking Terminologies Cheat Sheet

## Core Concepts

  -------------------------------------------------------------------------
  Concept               Azure (VNet)        AWS (VPC)       GCP (VPC)
  --------------------- ------------------- --------------- ---------------
  Virtual Network       VNet (Regional)     VPC (Regional)  VPC Network
                                                            (Global,
                                                            subnets are
                                                            regional)

  Subnet                Subnet              Subnet          Subnet
                                            (AZ-bound)      (Regional)

  Private IP Ranges     RFC 1918            RFC 1918        RFC 1918

  Reserved IPs          5 per subnet (1st:  5 per subnet    4 per subnet
                        Network, 2nd:                       
                        Gateway, 3--4: DNS,                 
                        last: Broadcast)                    
  -------------------------------------------------------------------------

## Connectivity

  ---------------------------------------------------------------------------
  Concept                  Azure               AWS             GCP
  ------------------------ ------------------- --------------- --------------
  Peering                  VNet Peering        VPC Peering     VPC Peering
                           (regional/global)   (cross-region   (global)
                                               possible)       

  VPN                      VPN Gateway,        VPN Gateway,    Cloud VPN,
                           ExpressRoute        Direct Connect  Cloud
                                                               Interconnect

  Load Balancing           Load Balancer (L4), ELB, ALB, NLB   Cloud Load
                           App Gateway (L7),                   Balancing
                           Front Door, Traffic                 (global,
                           Manager                             L4/L7)
  ---------------------------------------------------------------------------

## Security

  ---------------------------------------------------------------------------
  Concept                  Azure               AWS           GCP
  ------------------------ ------------------- ------------- ----------------
  Security Groups          NSG, ASG            Security      Firewall Rules
                                               Groups, NACLs (tag/service
                                                             account-based)

  Firewall                 Azure Firewall      AWS Network   Cloud Firewall,
                                               Firewall      Cloud Armor
                                                             (WAF/DDoS)

  DDoS Protection          DDoS Protection     AWS Shield    Cloud Armor
                           Standard                          
  ---------------------------------------------------------------------------

## Routing & NAT

  ------------------------------------------------------------------------
  Concept                  Azure               AWS           GCP
  ------------------------ ------------------- ------------- -------------
  Routing                  Route Table (UDR)   Route Table   Routes
                                               (per          (system +
                                               subnet/VPC)   custom)

  NAT                      NAT Gateway         NAT Gateway,  Cloud NAT
                                               NAT Instance  
  ------------------------------------------------------------------------

## DNS & IPs

  ------------------------------------------------------------------------
  Concept                  Azure               AWS           GCP
  ------------------------ ------------------- ------------- -------------
  DNS                      Azure DNS, Private  Route 53      Cloud DNS
                           DNS Zones                         

  IP Types                 Private, Public     Private,      Private,
                           (Dynamic/Static)    Public,       Ephemeral,
                                               Elastic IP    Static
                                                             External IP
  ------------------------------------------------------------------------

## Advanced Networking

  ----------------------------------------------------------------------------------
  Concept                  Azure               AWS                    GCP
  ------------------------ ------------------- ---------------------- --------------
  Service Endpoints        Service Endpoints,  VPC Endpoints          Private
                           Private Link        (Interface/Gateway),   Service
                                               PrivateLink            Connect (PSC),
                                                                      VPC SC

  Transit Networking       Virtual WAN,        Transit Gateway        Network
                           Hub-Spoke                                  Connectivity
                                                                      Center, VPC SC

  Proxy / Gateway          App Gateway, API    API Gateway, App Mesh  API Gateway,
                           Management, Front                          Cloud
                           Door                                       Endpoints

  Identity-based Access    Managed Identity +  SG + IAM Roles         Firewall Rules
                           NSG w/ ASG                                 with Service
                                                                      Accounts
  ----------------------------------------------------------------------------------
