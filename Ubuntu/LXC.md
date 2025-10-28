```bash
sudo snap install lxd
sudo lxd init
lxc launch ubuntu:22.04 testvm
lxc exec testvm -- bash
```


#### LXD supports multiple storage backends:
**zfs** → ZFS filesystem
**btrfs** → Btrfs filesystem
**lvm** → Logical Volume Manager
**dir** → Simple directory on host



lxc storage create pool-1 zfs size=20GB
lxc storage list

lxc profile show default 
lxc profile device add default root disk pool=pool-1 path=/

lxc launch ubuntu:24.04 lxc-1
lxc list

lxc network list 
lxc network create lxdbr0 ipv4.address=10.0.3.1/24 ipv4.nat=true ipv6.address=none
lxc profile device add default eth0 nic nictype=bridged parent=lxdbr0 name=eth0



# LXC and LXD Overview

## 1️⃣ What is LXC?

**LXC = Linux Containers**  

LXC is the low-level container technology in Linux. It provides **system containers** (full OS-like environment) using kernel features:  

- **Namespaces** → isolate processes, network, mounts, users  
- **cgroups** → control CPU, memory, IO, etc.  

LXC containers **look and feel like a virtual machine**, but **share the host kernel** (no separate kernel needed).

---

## 2️⃣ What is LXD?

**LXD = “The next-generation LXC”** (Daemon + API)  

LXD is a **management layer on top of LXC**. It provides:

- **REST API** → manage containers remotely  
- **CLI tool (`lxc`)** → easy commands to launch, stop, snapshot containers  
- **Network management** → create bridges and internal networks  
- **Storage management** → integrate ZFS, LVM, directory storage  
- **Clustering support** → multiple hosts can form a cluster  
- **Live migration** → move containers between hosts without downtime

---

## 3️⃣ How LXC/LXD Differ From Docker

| Feature               | LXC/LXD                                    | Docker                              |
|-----------------------|--------------------------------------------|------------------------------------|
| **Type of container**  | System container (full OS)                 | Application container (single app + dependencies) |
| **Kernel sharing**     | Shares host kernel                          | Shares host kernel                  |
| **Init system inside container** | Yes (systemd can run inside)        | Usually no (single process)        |
| **Network**            | Can create bridges, multiple NICs          | Simple NAT or overlay networks      |
| **Storage**            | Can use ZFS, LVM, dir                       | Volumes or bind mounts              |
| **Snapshots & migration** | Full snapshots, live migration           | Limited s


LXC
Package name (Ubuntu/Debian):
sudo apt install lxc lxc-utils lxc-dev


LXD
Package name (Ubuntu/Debian):
//sudo apt install lxd
sudo snap install lxd
