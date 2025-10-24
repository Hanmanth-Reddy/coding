# VPN types:
1. Site to Site VPN (L2L/S2S)

```pgsql
Branch Router ───(IPSec Tunnel via Internet)───▶ HQ Router
     |                                           |
 [Branch LAN]                              [HQ LAN]
```
2. Remote VPN
```pgsql
User Laptop ───(Encrypted Tunnel via Internet)───▶ Company VPN Gateway ───▶ Internal Network
```
3. Cloud VPN
```pgsql
On-Prem Firewall ───(IPSec Tunnel)───▶ GCP/AWS/Azure Cloud Gateway
```

# VPN Protocols:
A VPN protocol is a set of rules and technologies that determine how a VPN connection is established, encrypted, and transmitted.
Each protocol offers a trade-off between:

🔒 Security
⚡ Speed
🧩 Compatibility
🛰️ Stability (especially over unstable networks)



PPTP - point to point tunneling protocol
L2TP - Layer 2 tunneling protocol 
SSTP - Secure socket tunneling protocol
IPsec - IP securtiy
SSL - Secure socket layer 