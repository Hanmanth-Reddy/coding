# NFS Server Setup
```
## Install NFS server and Enable,start the NFS server service
sudo dnf update -y
sudo dnf install -y nfs-utils

##sudo apt update  //Ubuntu
##sudo apt install nfs-kernel-server -y  //Ubuntu



sudo systemctl enable --now nfs-server
sudo systemctl start nfs-server

## Create an NFS Shared Directory
sudo mkdir -p /mnt/nfs_share
sudo chown -R <user>:<group> /mnt/nfs_share
sudo chmod 777 /mnt/nfs_share

## Configure NFS Exports
cat <<EOF | sudo tee -a /etc/exports
/mnt/nfs_share 192.168.1.0/24(rw,sync,no_root_squash,no_subtree_check)
/mnt/nfs_share 192.168.1.100(rw,sync,no_root_squash,no_subtree_check)
EOF

### Apply the export configuration and restart nfs-server
sudo exportfs -a && sudo systemctl restart nfs-server

## Verify if NFS shares are available and nfs server running
sudo exportfs -v && sudo systemctl status nfs-server
```


# NFS Client Setup
```
sudo dnf install -y nfs-utils
## sudo apt install nfs-common -y  \\ Ubuntu


sudo mkdir -p /mnt/nfs_client


## mount the NFS Share
sudo mount -t nfs <NFS_SERVER_IP>:/mnt/nfs_share /mnt/nfs_client

cat <<EOF | sudo tee -a /etc/fstab
<NFS_SERVER_IP>:/mnt/nfs_share /mnt/nfs_client nfs defaults 0 0
EOF
```