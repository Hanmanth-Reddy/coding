## What is MetalLB?
MetalLB is a network load-balancer implementation for bare-metal Kubernetes clusters. 

### Install MetalLB
```
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb --namespace metallb-system --create-namespace
```
### Configure IP Address Pool (Layer 2 Mode Example):
```
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: my-pool
  namespace: metallb-system
spec:
  addresses:
  - 192.168.1.100-192.168.1.110  # Allocate a range of IPs
```

### Configure L2 Advertisement:
```
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: l2adv
  namespace: metallb-system
spec:
  ipAddressPools:
  - my-pool
```


## How MetalLB Works

MetalLB operates in two modes for assigning external IPs:

### ● Layer 2 Mode (ARP/NDP-based)
1. Uses **Address Resolution Protocol (ARP)** (IPv4) or **Neighbor Discovery Protocol (NDP)** (IPv6) to announce the external IP.
2. The node with the service responds to ARP/NDP requests, directing traffic to the right pod.
3. Simple setup, but only works in a **single L2 network (same subnet)**.

### ● BGP Mode (Border Gateway Protocol)
1. Uses **BGP** to announce service IPs to routers.
2. More scalable and suitable for **multi-subnet or large networks**.
3. Requires a **BGP-enabled router** to handle the route announcements.

## **Why Use MetalLB?**
✅ **Enables LoadBalancer services** on bare-metal Kubernetes.  
✅ **Simple Layer 2 mode** for small/local clusters.  
✅ **BGP mode** for larger, enterprise-scale deployments.  
✅ **Works with existing networking stacks** (e.g., Calico, Cilium, Flannel).  
✅ **Lightweight and easy to deploy.**  


## When to Use MetalLB?
🔹 Running Kubernetes **on bare-metal** (no cloud load balancer).
🔹 Need **external IPs** for LoadBalancer services.
🔹 Want a **simple and lightweight** load-balancer solution.
🔹 Have a **BGP-capable router** and want **advanced networking**.