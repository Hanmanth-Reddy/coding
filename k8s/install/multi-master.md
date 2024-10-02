
## Stacked Multi Master Setup
1) Run follwoing command on one control plane
sudo kubeadm init \
--control-plane-endpoint "LOAD_BALANCER_DNS:LOAD_BALANCER_PORT" \
--pod-network-cidr "192.168.0.0/16"
--service-cidr "10.96.0.0/12"
--upload-certs 

2) Step 1 generate join command for other controlplane nodes and worker nodes.
   execute "kubeadm token create --print-join-command" , if you don't have join command.

## External etcd multimaster/control planes.

