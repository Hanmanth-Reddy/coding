## Add modules to forwarding IPv4 and letting iptables see bridged traffic
```bash
cat > /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

## To load modules
```bash
modprobe overlay
modprobe br_netfilter

## Verify whether the br_netfilter, overlay modules are loaded 
lsmod | grep br_netfilter
lsmod | grep overlay


## sysctl params required by setup, params persist across reboots
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



## ============ Disable seLinux, iptables and firewall ===========
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

systemctl disable iptables
systemctl stop iptables
systemctl mask iptables
iptables -F && iptables -tnat --flush

systemctl disable firewalld
systemctl stop firewalld
systemctl mask firewalld


## =============== ToDisable Swap =============================
swapoff -a
sed -i '/swap/ s/^/#/' /etc/fstab






















================================ Install Docker and Configure ======================================================

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum update -y && yum install -y  containerd.io-1.2.13 docker-ce-19.03.8 docker-ce-cli-19.03.8


## Create Docker data directory and create xfs file system
mkdir -p /mnt/apps/
ln -s /apps /mnt/apps
mkdir -p /apps/data && mkdir -p /apps/tmp && mkdir /apps/data/docker

mkfs.xfs -f /dev/sdb

cat <<EOF >> /etc/fstab
/dev/sdb /apps/data xfs  defaults,pquota,prjquota  0 0
EOF

mount -a



cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
   "graph": "/apps/data/docker",
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF


systemctl daemon-reload
systemctl enable docker
systemctl restart docker


cat /etc/containerd/config.toml << EOF
[plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
  [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
    SystemdCgroup = true
EOF

systemctl enable containerd
systemctl restart containerd


========================================= Install Kubernetes packages ======================================================
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF


yum install -y kubelet-1.19.14-0 kubeadm-1.19.14-0 kubectl-1.19.14-0 --disableexcludes=kubernetes
yum versionlock add kubectl kubelet kubeadm


cat <<EOF >> /etc/sysconfig/kubelet
export KUBELET_EXTRA_ARGS='--cgroup-driver=systemd --root-dir=/apps/data/k8s/kubelet'
EOF

systemctl daemon-reload
systemctl enable --now kubelet
systemctl restart kubelet




==================================================================================================================================================
There are two cgroup drivers available:
cgroupfs
systemd

the kubelet and the container runtime directly interface with the cgroup filesystem to configure cgroups, so make sure both running in same using SAME CGROUPFS
the kubelet and the container runtime directly interface with the cgroup filesystem to configure cgroups.

Check you init system by using 
#ps -p 1
