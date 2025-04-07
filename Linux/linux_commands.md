
which [command]


## OS info
```
cat /etc/os-release
cat /etc/redhat-release
cat /etc/system-release
cat /etc/*-release
```

## Environment Variables
```
env 

/etc/environment 
```

## File Ops and Text processing 
```
cat <<EOF>> example.txt
hello 
how are you ?
EOF

tee -a example.txt <<EOF
hello 
how are you ?
EOF

wc
sort
grep 
egrep
sed

### AWK commands
awk '{print}' employee.txt
awk '/manager|DevOps/'  {print $1, $2, $NF}' employee.txt "
awk options 'selection _criteria {action }' input-file > output-file
```


## Process management
```
ps -ef 
ps -e -o col1, col2, col3 --sort=-cpu,mem
ps -e -C httpd

kill -l
kill -9

pgrep -u elastic ssh
pkill -9 <executable>

top -b -n1
top -b -n1 -H    //top-threads.txt
find /proc -maxdepth 1 -type d -name '[0-9]*' -exec cat {}/status \; | grep <process_name>

nice 
bg
fg %

jobs
```

## Systemd (Systemctl)
```
systemctl status|start|stop|reload|restart|enable|disable|is-enabled|mask|unmask <service-name>


systemctl list-units --all                     // To list active services, devices, mounts, etc.  including inactive 
systemctl list-units --type=service --all
systemctl list-unit-files 

Service units (.service) – Control background services.
Target units (.target) – Group services (like runlevels in SysVinit).
Socket units (.socket) – Handle inter-process communication.
Timer units (.timer) – Alternative to cron jobs.
Device units (.device) – Manage devices.


systemctl cat containerd.service
systemctl show containerd.service


### To set Run Levels
systemctl list-units --type=target --all
systemctl get-default
systemctl set-default multi-user.target
sudo systemctl isolate multi-user.target // To set change immediately 


Runlevel systemd Target	    Purpose
0   	 poweroff.target	Shutdown system
1       (Single User Mode)	rescue.target	Rescue mode
3   	 multi-user.target	Multi-user mode (CLI)
5	     graphical.target	Multi-user mode with GUI
6	     reboot.target	    Reboot




journalctl -u httpd -f  // httpd service dynamic logs
journalctl -b   // to see current boot logs 
```

## CPU
```
sar
sar -q 1 1  //sar-load-average-sampled.txt
sar -S 1 1  //sar-swap-sampled.txt
sar -P ALL 1 5  //sar-cpu-cores.txt
sar -d -p 1 5  //sar-devices.txt
sar -r 1 5  //sar-memory-sampled.txt
sar -n DEV  //sar-network.txt
```

## Memory
```
free -g

swapoff -a 
sed -i '/swap/ s/^/#/' /etc/fstab
```


## Disk Management 
```
df -h
du -sh 

lsblk                        // To displays info about block devices (disks and partitions)
lsblk -o NAME,RA,MOUNTPOINT,TYPE,TRAN,SIZE,MIN-IO,FSTYPE

// A powerful tool for managing disk partitions.
fdisk -l                     // To list partitions
fdisk /dev/sda               // To modify partition 

// parted is a tool for managing disk partitions, similar to fdisk
parted -l                   // To list partitions 
parted /dev/sda             // To modify partion

mkfs                       // create a new file system on a partition.
mkfs.ext4 /dev/sda1        // create an ext4 file system on /dev/sda1 partition
mkfs.vfat /dev/sda1        // create an FAT32 file system on /dev/sda1 partition
mkfs.xfs /dev/sda1         // create an XFS file system on /dev/sda1 partition
xfs_info /apps/data/elastic

mount /dev/sda1 /mnt      //Mounts the /dev/sda1 partition to the /mnt directory.
umount /mnt
mount                      // To show mounted filesystems

mount -a
cat /etc/fstab


dd                                                   // data duplicator - used for copying and converting data between files and devices
                                                        used for various tasks, including creating backups, cloning disks, and generating random data 
dd if=input_file of=output_file                      // Copying Data from One File to Another
dd if=/dev/sdX of=partition_image.img                //Creating a Backup or Disk Image
dd if=/dev/sdX of=/dev/sdY bs=4M                     //Cloning Disk or Partitions
dd if=/dev/urandom of=random_data.bin bs=1M count=10 // Creating Random Data
dd if=input_file of=/dev/null bs=1M                  //Checking Disk or File Read Speed
dd if=/dev/zero of=output_file bs=1M count=10        //Creating a File of a Specific Size
```



## Access Control
```
chmod
4 2 1
u g o ,   r w x 


chown user:group * -Rf
setfacl
setfacl -m u:hanmanth:rwx  /data
setfacl -m g:DevOps :rwx  /data
setfacl -m u:user1:--- /data
getfacl --access /data | setfacl -d -M- /db
getfacl /data/file1 | setfacl --set-file=- /test"


```

## Kernel
```
                              // These settings affect how the Linux kernel interacts with hardware, memory, networking, etc.
sysctl --system              // to load kernel params without reboot
sysctl -a                    // To lists all available kernel parameters a
sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward    // To display specific kernel parameters

/etc/sysctl.conf 

modprobe overlay  // To laod a module 
lsmod | grep overlay  // To list a loaded module


uname -a
dmesg --ctime        // displays kernel messages, helping you diagnose hardware and system-related issues.

timedatectl

```


## Networking
```
ping -c 4 <IP>
telnet <domian/ip> <port>
nc -vz <domain/ip> <port>

ifconfig
ip addr show 
ip rule show
ip -s link show
route -n

netstat -ntulpn
ss -tualno   //Socket Statistics

iptables -L -v -n  //iptables.txt
iptables -L -v -n   //iptables.txt

tcpdump -i <interface> -nn -s0 -A 'tcp port <port>'

wget <url>
curl -O http://example.com/file.zip  //download a file
curl -X POST -d "param1=value1&param2=value2" http://example.com
curl -H "Authorization: Bearer Token" -H "Content-Type: application/json" http://example.com
curl -L http://example.com  //headers only 
curl -X POST -F "file=@localfile.txt" http://example.com/upload  //upload a file
curl -k -u user:password -XPOST  -H "Authorization: Bearer Token" -H "Content-Type: application/json" -d "param1=value1&param2=value2" http://example.com



/etc/hosts
/etc/hosts.allow
/etc/hosts.deny
/etc/resolv.conf
/etc/nsswitch.conf

/etc/networks
/etc/sysconfig/network
/etc/systemconfig/network-scripts


lsof -i @<IP_address>  //To Show Files Opened by a Specific Network Address

lsof -i 4  // Show IPv4 or IPv6 Connections Only
lsof -i 6

lsof -u <username>  // List Open Files by a Specific User
lsof -c <command> // List Files Opened by a Specific Program/Executable
sudo lsof -i :6443 //Find Processes Using a Specific Port

lsof -i tcp  //List Open Files by Network Protocol
lsof -i udp

lsof +D /path/to/directory  //Find Files Opened by a Specific Directory/Mount Point or File System/Specific Device
lsof /mnt/data
lsof /dev/sda1


nmap -p 1-65535 <IP or hostname>  [OR] nmap -p-  <IP or hostname>  -oN scan_results.txt

nmap -p- 192.168.1.1-254  // Scan all ports on range/multiple of IP
nmap -p- 192.168.1.1 192.168.1.2 192.168.1.3
nmap -p- 192.168.1.0/24

nmap -p 1-1000 <target_ip_or_hostname>   //Scan range of ports

nmap -sS -sU -p- <target_ip_or_hostname>  //Scan both TCP & UDP ports
```

## Debug
```
lsof
ulimit -n 
/etc/security/limits.conf
/etc/security/limits.conf as limits.txt

while :; do :; done  // infinite loop for CPU stress
stress --cpu 4 --timeout 60s  // To create CPU stress 
dd if=/dev/zero of=/dev/null bs=1M   // Disk Stress (Indirect CPU Stress) , read from /dev/zero and write to /dev/null , adjust bs - block size

fallocate -l 10M output_file
truncate -s 10M output_file
dd if=/dev/zero of=output_file bs=1M count=10

strace
ltrace

watch -n 1 'command'

```

## proc
```
cat /proc/sys/crypto/fips-enabled
/proc/[PID]/status
cat /proc/cmdline
/proc/[PID]/cmdline
/proc/meminfo
/proc/cpuinfo
/proc/loadavg
/proc/sys/fs/file-max
```

## IO
```
iostat -c -d -x -t -m 1 5
sysstat
iostat 
```

## User mgmt
```

```

## Sudoers mgmt
```
```

## Speacial Commands
```
truncate --size=100M filename.txt

```


## Archive & Compress 
```

```

## Package management
```
rpm -qa 

rpm -ql [package name]
rpm -qf [binary/filename]
yum install bind-tils net-tools -y
```