# 12_Advanced_Topics.md

# Azure Advanced Networking & Security Hands-On Practice Guide

## 1. Azure Private Link
### Create Private Endpoint
```bash
az network private-endpoint create   -g MyNetRG   -n MyPrivateEndpoint   --vnet-name MyVnet   --subnet MySubnet   --private-connection-resource-id <resource-id>   --group-ids sqlServer   --connection-name MySQLPrivateConnection
```

## 2. Service Endpoints
### Enable Service Endpoint for Storage
```bash
az network vnet subnet update   -g MyNetRG   -n MySubnet   --vnet-name MyVnet   --service-endpoints Microsoft.Storage
```

## 3. Azure Firewall
### Deploy Firewall
```bash
az network firewall create   -g MyNetRG   -n MyFirewall   -l eastus
```

## 4. Web Application Firewall (WAF)
### Enable WAF on Application Gateway
```bash
az network application-gateway waf-config set   -g MyNetRG   --gateway-name MyAppGW   --enabled true   --firewall-mode Prevention
```

## 5. Azure Bastion
### Deploy Bastion Host
```bash
az network bastion create   -g MyNetRG   -n MyBastion   --public-ip-address MyBastionIP   --vnet-name MyVnet   -l eastus
```

## 6. DDoS Protection
### Enable DDoS Protection Plan
```bash
az network ddos-protection create   -g MyNetRG   -n MyDDoSPlan   -l eastus
```

### Link VNet to Plan
```bash
az network vnet update   -g MyNetRG   -n MyVnet   --ddos-protection-plan /subscriptions/<sub-id>/resourceGroups/MyNetRG/providers/Microsoft.Network/ddosProtectionPlans/MyDDoSPlan
```

## 7. Multi-Region Deployments
- Use **Traffic Manager** or **Front Door** for global load balancing.
- Replicate resources with **Geo-Redundant Storage** and **Cross-Region Load Balancing**.
