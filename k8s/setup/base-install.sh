## Add modules to forwarding IPv4 and letting iptables see bridged traffic
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

## To load modules
modprobe overlay
modprobe br_netfilter

## Verify whether the br_netfilter, overlay modules are loaded 
lsmod | grep br_netfilter
lsmod | grep overlay


##  Add below required params in file to persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sed -i '/net.ipv4.ip_forward/d' /etc/sysctl.conf


## Apply sysctl to load kernel params without reboot
sysctl --system

## To verify Kernel parameters.
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward


## To Stop,Disable& mask the seLinux, iptables and firewall services
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

iptables -F && iptables -tnat --flush
systemctl disable iptables
systemctl stop iptables
systemctl mask iptables

systemctl disable firewalld
systemctl stop firewalld
systemctl mask firewalld


##  To Disable Swap
swapoff -a
sed -i '/swap/ s/^/#/' /etc/fstab


## install Container Runtime - contianerd 
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo

yum install containerd.io -y

containerd config default > /etc/containerd/config.toml

sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

systemctl restart containerd

## Install kubeadm, kubelet & kubectl
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.31/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF


## Install kubeadm, kubelet & kubelet 
#yum install -y kubelet-1.19.14-0 kubeadm-1.19.14-0 kubectl-1.19.14-0 --disableexcludes=kubernetes
#yum versionlock add kubectl kubelet kubeadm
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
