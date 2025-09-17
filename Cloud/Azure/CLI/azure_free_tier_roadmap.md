# Azure Free Tier Hands-On Roadmap

This document provides a **step-by-step roadmap** for creating resources in the Azure Free Tier, along with commands and concepts explanations. It also includes suggestions for utilizing the $200 credit for learning advanced Azure services like AKS and more.

---

## 1. **Virtual Network (VNet) & Subnets**
**Concept:**
- VNet is a logically isolated network in Azure.
- Subnets divide a VNet into smaller address spaces for organizing resources.

**Command:**
```bash
# Create VNet
az network vnet create \
  -g MyResourceGroup \
  -n MyVNet \
  --address-prefix 10.0.0.0/16 \
  --subnet-name subnet-1 \
  --subnet-prefix 10.0.0.0/24

# Add another subnet
az network vnet subnet create \
  -g MyResourceGroup \
  --vnet-name MyVNet \
  -n subnet-2 \
  --address-prefix 10.0.1.0/24
```

**Free Tier Info:**
- Creating VNets & Subnets is **free**.
- Network Watcher auto-enabled is free unless advanced features are used.

---

## 2. **Virtual Machine (VM)**
**Concept:**
- Compute instance to run OS & applications.
- Free tier: **B1s Linux or Windows VM** with 750 hours/month.

**Command:**
```bash
# Create VM in subnet-1
az vm create \
  -g MyResourceGroup \
  -n MyVM \
  --image UbuntuLTS \
  --size B1s \
  --vnet-name MyVNet \
  --subnet subnet-1 \
  --generate-ssh-keys

# Start/Stop VM
az vm start -g MyResourceGroup -n MyVM
az vm stop -g MyResourceGroup -n MyVM
```

**Free Tier Info:**
- Only 1 B1s VM per region is fully free.

---

## 3. **Storage Account & Blob Storage**
**Concept:**
- Storage account holds blobs, files, tables, and queues.
- Blob storage: Object storage for files/data.

**Command:**
```bash
# Create storage account
az storage account create \
  -g MyResourceGroup \
  -n mystorageacct123 \
  -l japaneast \
  --sku Standard_LRS

# Create blob container
az storage container create \
  -n mycontainer \
  --account-name mystorageacct123

# Upload file
az storage blob upload \
  --container-name mycontainer \
  --file myfile.txt \
  --name myfile.txt \
  --account-name mystorageacct123
```

**Free Tier Info:**
- 5 GB storage free.
- 20,000 read/write operations per month.

---

## 4. **App Service (Web App)**
**Concept:**
- PaaS to host web applications.
- Free tier includes **1 GB storage, 60 CPU minutes/day**.

**Command:**
```bash
# Create App Service plan
az appservice plan create \
  -g MyResourceGroup \
  -n MyAppServicePlan \
  --sku F1 \
  -l japaneast

# Create Web App
az webapp create \
  -g MyResourceGroup \
  -p MyAppServicePlan \
  -n mywebapp123 \
  --runtime "PYTHON|3.9"

# Browse Web App
az webapp browse -g MyResourceGroup -n mywebapp123
```

**Free Tier Info:**
- F1 (Free) plan, limited resources.

---

## 5. **Azure Monitor**
**Concept:**
- Collects metrics & logs from resources.
- Set alerts for VM uptime, CPU usage, etc.

**Command:**
```bash
# Create Log Analytics Workspace
az monitor log-analytics workspace create \
  -g MyResourceGroup \
  -n MyLogAnalytics \
  -l japaneast

# Link VM to workspace
az monitor diagnostic-settings create \
  --resource MyVM \
  --workspace MyLogAnalytics \
  --name MyVMLogs \
  --metrics '[{"category": "AllMetrics", "enabled": true}]'
```

**Free Tier Info:**
- 5 GB data ingestion per month free.
- 31-day retention.

---

## 6. **Cosmos DB (Always Free)**
**Concept:**
- Globally distributed multi-model database.
- Free tier: 400 RU/s + 5 GB storage.

**Command:**
```bash
# Create Cosmos DB account
az cosmosdb create \
  -g MyResourceGroup \
  -n mycosmosdb123 \
  --kind MongoDB \
  -l japaneast \
  --capabilities EnableMongo
```

**Free Tier Info:**
- 400 RU/s + 5 GB storage free.

---

## 7. **Azure Kubernetes Service (AKS)**
**Concept:**
- Managed Kubernetes service.
- Control plane: free.
- Worker nodes: pay only for VMs (use B1s for free-tier testing).
- Integrates with VNets, subnets, and Azure Monitor.

**Command:**
```bash
# Create AKS Cluster
az aks create \
  -g MyAKSResourceGroup \
  -n MyAKSCluster \
  --node-count 1 \
  --enable-addons monitoring \
  --generate-ssh-keys \
  --node-vm-size Standard_B1s \
  --vnet-subnet-id /subscriptions/<sub-id>/resourceGroups/MyResourceGroup/providers/Microsoft.Network/virtualNetworks/MyVNet/subnets/subnet-1

# Connect to AKS
az aks get-credentials -g MyAKSResourceGroup -n MyAKSCluster
kubectl get nodes

# Deploy sample app
kubectl create deployment myapp --image=nginx
kubectl expose deployment myapp --port=80 --type=LoadBalancer
kubectl get svc
```

**Free Tier Info:**
- Control plane free, 1 B1s node for learning.
- Integrates with Azure Monitor for metrics.

---

## ⚡ Using $200 Free Credit for Learning
- **Try larger VM sizes or multiple nodes** in AKS without worrying about free tier limits.
- **Experiment with Azure Databases** beyond free tier (SQL, PostgreSQL, MySQL).
- **Use Azure Cognitive Services or AI services** for practice.
- **Try Load Balancers, Application Gateway, Traffic Manager**.
- **Experiment with multiple VNets and peering**.
- **Deploy containerized apps across multiple subnets or regions**.
- Always monitor consumption: `az consumption usage list --output table`

---

### ⚡ Summary Roadmap
1. **Networking:** VNet + Subnets → Free
2. **Compute:** VM (B1s) → 750 hours free/month
3. **Storage:** Storage Account + Blob → 5 GB free
4. **Web App:** App Service Free Plan → 1 GB storage
5. **Monitoring:** Azure Monitor Logs → 5 GB free
6. **Database:** Cosmos DB → Always free tier
7. **AKS:** Managed Kubernetes → Control plane free, nodes pay per VM
8. **Use $200 credit:** Explore advanced services like multi-node AKS, larger VMs, databases, AI services, and networking experiments

