```bash
sudo snap install lxd
sudo lxd init
lxc launch ubuntu:22.04 testvm
lxc exec testvm -- bash
```


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


