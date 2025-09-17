# Azure Additional Services Learning Guide

This document provides a guide for exploring **additional Azure services** beyond the free-tier roadmap. It includes concepts, use cases, and basic `az` commands for hands-on learning.

---

## 1. **Azure Key Vault & Cert Manager**
**Concept:**
- Key Vault stores secrets, keys, and certificates securely.
- Cert Manager can manage SSL/TLS certificates for your applications.

**Commands:**
```bash
# Create Key Vault
az keyvault create -g MyResourceGroup -n MyKeyVault -l japaneast

# Add a secret
az keyvault secret set --vault-name MyKeyVault --name MySecret --value "MySecretValue"

# List secrets
az keyvault secret list --vault-name MyKeyVault
```

---

## 2. **Web Application Firewall (WAF)**
**Concept:**
- Protects web apps from common threats and attacks.
- Can be deployed with **Application Gateway** or **Front Door**.

**Command:**
```bash
# Create Application Gateway with WAF
az network application-gateway create \
  -g MyResourceGroup \
  -n MyAppGateway \
  --sku WAF_v2 \
  --capacity 2 \
  --vnet-name MyVNet \
  --subnet subnet-1 \
  --public-ip-address MyPublicIP
```

---

## 3. **Public Static IP**
**Concept:**
- Assign a fixed IP to VMs, Load Balancers, or Application Gateway.

**Command:**
```bash
# Create static public IP
az network public-ip create \
  -g MyResourceGroup \
  -n MyStaticIP \
  --allocation-method Static \
  --sku Standard
```

---

## 4. **Load Balancer**
**Concept:**
- Distributes incoming traffic across multiple VMs.
- Two types: **Basic** (free) and **Standard** (paid).

**Command:**
```bash
az network lb create \
  -g MyResourceGroup \
  -n MyLoadBalancer \
  --sku Basic \
  --frontend-ip-name MyFrontEnd \
  --backend-pool-name MyBackEndPool
```

---

## 5. **NAT Gateway**
**Concept:**
- Provides outbound internet connectivity for VMs in a private subnet.

**Command:**
```bash
# Create NAT Gateway
az network nat gateway create \
  -g MyResourceGroup \
  -n MyNATGateway \
  --public-ip-addresses MyStaticIP \
  --idle-timeout 10

# Associate NAT Gateway with subnet
az network vnet subnet update \
  -g MyResourceGroup \
  --vnet-name MyVNet \
  --name subnet-1 \
  --nat-gateway MyNATGateway
```

---

## 6. **Disks & Azure Files**
**Concept:**
- **Managed Disks**: Persistent storage for VMs.
- **Azure Files**: SMB/NFS file shares for apps.

**Commands:**
```bash
# Create managed disk
az disk create -g MyResourceGroup -n MyDisk --size-gb 32 --sku Standard_LRS

# Attach disk to VM
az vm disk attach -g MyResourceGroup --vm-name MyVM --disk MyDisk

# Create Azure File Share
az storage share create -n myfileshare --account-name mystorageacct123
```

---

## 7. **Azure DNS**
**Concept:**
- Manage domain names and DNS records for applications.

**Commands:**
```bash
# Create DNS zone
az network dns zone create -g MyResourceGroup -n example.com

# Add A record
az network dns record-set a add-record -g MyResourceGroup -z example.com -n www -a 40.112.72.205
```

---

## 8. **Azure DevOps**
**Concept:**
- CI/CD pipelines, repositories, work items, and test plans.
- Integrates with Azure Repos, Pipelines, and Artifacts.

**Getting Started:**
- Sign up: https://dev.azure.com
- Create a project → Create repository → Set up pipeline → Deploy resources.
- Azure CLI can trigger pipelines using `az pipelines run`.

```bash
# Trigger a pipeline
az pipelines run --name MyPipeline --branch main --org https://dev.azure.com/MyOrg/ --project MyProject
```

---

## 9. **Other Services to Explore with Learning Credit**
- **Azure Container Registry (ACR)** → Store Docker images.
- **Azure Kubernetes Service (AKS)** → Multi-node clusters.
- **Application Insights** → Monitor apps.
- **Event Grid & Event Hub** → Event-driven architecture.
- **Logic Apps & Functions** → Serverless workflows.
- **Cosmos DB, SQL, MySQL, PostgreSQL** → Explore managed databases.
- **Azure Front Door** → Global load balancing & WAF.
- **Traffic Manager** → DNS-based load balancing.

---

This guide allows you to **experiment hands-on** with multiple Azure services using your **$200 free credit**, learn networking, security, storage, CI/CD, and Kubernetes deployments.

