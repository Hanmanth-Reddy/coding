# Setup glusterFS 

### Step 1: Install glusterFS server on all nodes
```
# Update system
sudo dnf update -y  # RHEL-based
sudo apt update -y && sudo apt upgrade -y  # Ubuntu-based

# Install required packages
sudo dnf install -y glusterfs-server  # RHEL-based
sudo apt install -y glusterfs-server  # Ubuntu-based

# Start and enable GlusterFS service
sudo systemctl enable --now glusterd

# Verify installation
gluster --version
```

### Step 2: Disable or Configure Firewall
```
# Open GlusterFS ports
sudo firewall-cmd --add-service=glusterfs --permanent
sudo firewall-cmd --reload
```

### Step 3: Add Peer Probe the Nodes
```
## on node1
gluster peer probe node2
gluster peer probe node3

## check status
gluster peer status
```

### Step 4: Create a GlusterFS Volume
```
## Replicated Volume (Data redundancy)
gluster volume create vol1 replica 3 node1:/data/brick1 node2:/data/brick1 node3:/data/brick1 force

## Distributed Volume (Improved storage utilization)
gluster volume create vol1 node1:/data/brick1 node2:/data/brick1 node3:/data/brick1 force

## Start the volume:
gluster volume start vol1
gluster volume info
```

### Step 5: Mount the GlusterFS Volume on Client
```
sudo apt install -y glusterfs-client  # Ubuntu
sudo dnf install -y glusterfs-fuse    # RHEL

# Create mount point
sudo mkdir -p /mnt/glusterfs

# Mount the volume
sudo mount -t glusterfs node1:/vol1 /mnt/glusterfs

# Verify mount
df -hT

## To make it persistent across reboots, add this to /etc/fstab:
cat << EOF | tee -a /etc/fstab
node1:/vol1  /mnt/glusterfs  glusterfs  defaults,_netdev  0  0
EOF
```

## Step 6: Verify & Test
```
gluster volume status
gluster volume heal vol1 info

touch /mnt/glusterfs/testfile
ls -l /mnt/glusterfs/
```


Enable self-heal:
gluster volume set vol1 cluster.self-heal-daemon on
Tune performance:
gluster volume set vol1 performance.cache-size 256MB
