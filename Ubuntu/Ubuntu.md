**Linux kernel** = the core of the operating system (handles hardware, memory, processes).
**Linux Distribution (distro)** = a complete OS built around the Linux kernel, including:
- Package manager
- Software repositories
- Desktop environment (optional)
- Tools and utilities
- Libraries
- Userland tools
- Optional GUI (desktop environment)


#### Package Managers:
```bash
apt-get - advanced package tool get 
apt - advanced package tool 
dpkg - debian package
snap 
flatpak

.deb - debian /ubuntu
.rpm - RHEL, CentOS, Fedora, openSUSE
.snap , .flatpak , .AppImage --> spports Ubuntu, RHEL


apt / dpkg	-- Core system packages, server apps, stability-critical installs
snap	-- Desktop apps, newer versions, auto-updates, Ubuntu-focused apps
flatpak	-- Desktop apps, cross-distro apps, sandboxed environments
```

```
apt 
  list - list packages based on package names
  search - search in package descriptions
  show - show package details
  install - install packages
  reinstall - reinstall packages
  remove - remove packages
  autoremove - Remove automatically all unused packages
  update - update list of available packages
  upgrade - upgrade the system by installing/upgrading packages
  full-upgrade - upgrade the system by removing/installing/upgrading packages
  edit-sources - edit the source information file
  satisfy - satisfy dependency strings
```









🧭 1. Package Management (apt / dpkg)
RHEL: yum, dnf, .rpm
Ubuntu: apt, dpkg, .deb

repositories are defined in `/etc/apt/sources.list` and `/etc/apt/sources.list.d/`

Use of PPA (Personal Package Archives)

🌐 2. Network Configuration (Netplan)
**RHEL:** `/etc/sysconfig/network-scripts/, nmcli`
**Ubuntu:** `/etc/netplan/*.yaml → applies to systemd-networkd or NetworkManager`

🧱 3. Security: AppArmor vs SELinux
RHEL: SELinux
Ubuntu: AppArmor

Selinx works at system-level (files, services )
AppArmor works similarly(seLinux) but uses path-based rules instead of labels.

🛠️ 4. Firewall (UFW)

RHEL: firewalld
Ubuntu: ufw (Uncomplicated Firewall)

firewall works at networklevel

firewalld → protects network entry
SELinux/AppArmor → protects system internals (processes, files, memory, sockets, devices)

🧩 5. Cloud-Init

Ubuntu is the default OS for most cloud platforms (AWS, Azure, GCP).
It uses cloud-init to configure networking, users, SSH keys, and packages during boot.

⚙️ 7. Service Management (systemd)

Same as RHEL 8/9, but you can focus on:
- systemctl, journalctl
- Services installed via snap behave slightly differently

8. User and Group Management
Mostly same, but learn:
adduser (interactive version of useradd)
Default home and shell configuration differences in /etc/adduser.conf

🌩️ 9. LXD/LXC Containers
Ubuntu has LXD as a native system container solution (alternative to Docker).



# RHEL vs Ubuntu — Key Differences for DevOps/Linux Admins

| **Area** | **RHEL** | **Ubuntu** | **What You Should Learn** |
|-----------|-----------|-------------|-----------------------------|
| **Package System** | RPM | DEB | `apt`, `dpkg` |
| **Repositories** | YUM/DNF repos | APT sources + PPA | How to manage `/etc/apt/sources.list` |
| **Network Config** | ifcfg, nmcli | Netplan (YAML) | Netplan syntax |
| **Security** | SELinux | AppArmor | AppArmor management |
| **Firewall** | firewalld | ufw | ufw basics |
| **Cloud Init** | optional | default | `cloud-init` |
| **Containers** | podman/docker | LXD/LXC, docker | LXD usage |
| **System Tools** | subscription-manager | Canonical Livepatch, Snap | Snap, Livepatch, Pro |
