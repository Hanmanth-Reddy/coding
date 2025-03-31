# Install and SetUp MicroK8s

## Step 1.1: Install MicroK8s on Ubuntu/Debian
```
sudo snap install microk8s --classic
### To install a specific version
sudo snap install microk8s --classic --channel=1.28/stable
```

## Step 1.2: Install MicroK8s on RHEL 9 / CentOS / Fedora
```
#### Instll and enable snap
sudo yum install epel-release -y
sudo yum install snapd -y
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo systemctl restart snapd

### install microk8s using snap
snap install microk8s -y 
```

## Step 2: Verify Installation
```
microk8s status --wait-ready

### By default, MicroK8s requires root or sudo privileges. To avoid using sudo for each command, add your user to the microk8s group:
sudo usermod -aG microk8s $USER
newgrp microk8s
microk8s status
```


## Step 3: Enable MicroK8s Add-ons
MicroK8s comes with several add-ons to extend its functionality. Some commonly used add-ons are:
```bash
### 3.1 Enable DNS, Storage, and Dashboard
microk8s enable dns storage dashboard

### 3.2 Enable MetalLB (Load Balancer)

microk8s enable metallb

Set an IP range when prompted (e.g., `192.168.1.100-192.168.1.200`).
### 3.3 Enable Ingress Controller
microk8s enable ingress

### 3.4 Enable Registry (for local images)
microk8s enable registry

### 3.5 Enable Metrics Server (for monitoring)
microk8s enable metrics-server

#### Enable Istio Service Mesh
microk8s enable istio
```

### Step 4: To connect K8s dashboard
```
microk8s dashboard-proxy
```

## Step 5: Configure kubectl
```
alias kubectl='microk8s kubectl'

echo "alias kubectl='microk8s kubectl'" >> ~/.bashrc
source ~/.bashrc
### To use an external kubectl with MicroK8s:
microk8s config > ~/.kube/config
```

## Step 6: Enable High Availability (HA)
```
### On first node & Copy the provided join command.
microk8s add-node

## on second and third master nodes
microk8s join 192.168.1.10:25000/<TOKEN>
microk8s enable ha-cluster
microk8s kubectl get nodes

### On worker node run the copied command:
microk8s join <master-ip>:<port> --worker

### To remove node 
microk8s remove-node <node-name>
microk8s remove-node <node-name> --force
```

## Step 7: Backup and Restore MicroK8s
Backup MicroK8s Data & Restore MicroK8s from Backup
```bash
microk8s backup --filename microk8s-backup.tar.gz
microk8s restore microk8s-backup.tar.gz
```

## Step 8: Restart MicroK8s and Reset or Remove MicroK8s
```bash
microk8s stop
microk8s start

microk8s reset  # Resets MicroK8s but keeps installed Snap
sudo snap remove microk8s  # Completely removes MicroK8s
```