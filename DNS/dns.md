## 1. DNS CLIENT & LOOKUP COMMANDS

nslookup


dig


host (bind-utils)


ping 


curl -I


# 🧭 DNS Record Types – Quick Reference


------------------------------------------------------------------------------------------------------------------------------------------------
| Record Type | Example Command | Description |
|--------------|-----------------|--------------|
| **A** | `dig ece.abc.com A` | Maps a domain name to an **IPv4 address**. |
| **AAAA** | `dig ece.abc.com AAAA` | Maps a domain name to an **IPv6 address**. |
| **MX** | `dig ece.abc.com MX` | Specifies **Mail Exchange servers** responsible for receiving emails. |
| **NS** | `dig ece.abc.com NS` | Lists **Authoritative Name Servers** for the domain. |
| **SOA** | `dig ece.abc.com SOA` | Provides the **Start of Authority record**, containing primary NS, admin email, and zone parameters. |
| **TXT** | `dig ece.abc.com TXT` | Stores **text information**, often used for SPF, DKIM, DMARC, or verification. |
| **CNAME** | `dig ece.abc.com CNAME` | **Canonical Name** alias; maps one domain to another. |
| **SRV** | `dig _sip._tcp.ece.abc.com SRV` | Defines **Service location records** (used in SIP, LDAP, etc.). |
| **PTR** | `dig -x 192.37.7.21` | **Reverse DNS lookup** – maps IP address back to a hostname. |
| **CAA** | `dig ece.abc.com CAA` | Specifies which **Certificate Authorities** can issue SSL certificates for the domain. |
| **NAPTR** | `dig ece.abc.com NAPTR` | **Naming Authority Pointer** used for SIP, ENUM, and VoIP services. |
| **DS** | `dig ece.abc.com DS` | **Delegation Signer** record for DNSSEC chain of trust. |
| **DNSKEY** | `dig ece.abc.com DNSKEY` | Contains **public keys** used in DNSSEC validation. |
| **SPF** | `dig ece.abc.com TXT` (SPF inside TXT) | **Sender Policy Framework** – defines mail servers authorized to send on behalf of domain. |
| **HINFO** | `dig ece.abc.com HINFO` | Provides **host information** like CPU and OS type (rarely used). |
| **LOC** | `dig ece.abc.com LOC` | Specifies **geographical location** (latitude/longitude) of a domain. |
| **TLSA** | `dig _443._tcp.ece.abc.com TLSA` | Used for **DANE/TLS** associations (binds certificates to domain). |
| **ANY** | `dig ece.abc.com ANY` | Requests **all record types** (⚠️ often disabled/restricted). |
-------------------------------------------------------------------------------------------------------------------------------------------------
---


## 🧩 3. DNS CACHE MANAGEMENT
**Ubuntu**
```bash
# Check DNS cache status
systemd-resolve --statistics

# Flush DNS cache
sudo systemd-resolve --flush-caches
```
**RHEL**
```bash
# If using nscd
sudo systemctl restart nscd

# If using dnsmasq
sudo systemctl restart dnsmasq

```

**View Current Resolver Info**
```bash
resolvectl status
systemd-resolve --status
```



## 🧠  4. DNS SERVER TESTING (Local or Remote)

nc -zv <dns_server> 53 or nmap -p 53 <dns_server>

dig AXFR @<dns_server> <domain>

dig @1.1.1.1 example.com A


dig +trace example.com


## 5. CONFIGURING DNS CLIENT (Static Setup)

**🟢 Ubuntu (Netplan)**
```yaml
network:
  version: 2
  ethernets:
    ens33:
      dhcp4: yes
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```

`sudo netplan apply`


**🔴 RHEL / CentOS**
`In /etc/sysconfig/network-scripts/ifcfg-eth0`
```bash
DNS1=8.8.8.8
DNS2=1.1.1.1
```
sudo systemctl restart NetworkManager






------------------------------------------------------------------------------------------------------------
## DNS Fuction
- **name resolution:** how domain names are structured.
- **name registration:** how domain name is registred.
- **name space:**

Reverse DNS resolution:
Domain name format: right to left
Fully qulified domain name (FQDN)

DNS port: 53


1) root
2) zone apex/named domains
    Top level domains(TLD)  com
    second level domain  example 
3) Third level domain (www, gov)




Labels LDH rule (letter, digit, hypen)


#### ROOT Servers: 
A -to- M   --> 13 root servers each one has multiple copies 


Satic(local) Name resoultion: 
-----------------------------
Windows host file: `C:\Windows\System32\drivers\etc\hosts`
Linux hosts file: `/etc/hosts`


cat /etc/resolv.conf

resolvers - negetive caching 

DNS resoltion types :
1. recursive - Client asks resolver to do all the work (normal browser case).
2. iterative - Resolver asks each DNS server in sequence (root → TLD → authoritative).
3. non-recursive - Resolver already knows the answer (from cache).

DNS caching 
/var/cache/nscd/hosts
nscd -g

ipconfig /displaydns
ipconfig /flushdns


dnsmasq
systemd-resolved
unbound
nscd 




browser(cache) ---> Host (DNS cache, /etc/hosts file) ---> recusive query to --> DNS resolver (DNS cache)---interative query ----> root name server
                                                                                                                             <--- zone name servers
                                                                                                                            ----> TLD Servers 
                                                                                                                            <---- send authoritative name servers list
                                                                                                                            ---->  authrotatie anme server                


iterative query/Performs full DNS lookup chain

sudo systemd-resolve --flush-caches
sudo systemd-resolve --statistics






**nano /etc/nsswitch.conf**
```
# /etc/nsswitch.conf
#
# Name Service Switch configuration file.
# Determines the sources for common databases.

passwd:         files sss
group:          files sss
shadow:         files

hosts:          files dns myhostname
networks:       files

protocols:      files
services:       files
ethers:         files
rpc:            files

netgroup:       nis
```

**nano /etc/hosts**
```
# /etc/hosts
# Local static host name resolution

127.0.0.1       localhost
::1             localhost ip6-localhost ip6-loopback

192.168.1.10    web1.mydomain.local web1
192.168.1.11    db1.mydomain.local db1
10.0.0.5        backup-server

# Custom entries
172.16.0.100    appserver.internal appserver

```

**nano /etc/resolv.conf**
```
# Generated by NetworkManager
search mydomain.local corp.internal
nameserver 8.8.8.8
nameserver 1.1.1.1
options timeout:2 attempts:3 rotate
```


1. /etc/hosts           ← static hostname mapping
2. Local DNS cache      ← systemd-resolved / nscd / dnsmasq
3. /etc/resolv.conf     ← tells where to send DNS queries /Defines which DNS servers to use
4. External DNS servers ← recursive / authoritative lookup
5. /etc/nsswitch.conf	← Defines resolution order (which source first, second, etc.)




Browser → OS → Recursive Resolver → Root → TLD → Authoritative → Resolver → OS → Browser → Website

                     ┌────────────────────────────┐
                     │ You type www.example.com   │
                     │ in your browser            │
                     └──────────────┬─────────────┘
                                    │
                                    ▼
                   ┌────────────────────────────────┐
                   │ 1️⃣ Browser Cache               │
                   │ Has it cached the IP?           │
                   └──────────────┬──────────────────┘
                                  │No
                                  ▼
                   ┌────────────────────────────────┐
                   │ 2️⃣ OS Resolver Cache           │
                   │ (e.g., /etc/resolv.conf)        │
                   └──────────────┬──────────────────┘
                                  │No
                                  ▼
                   ┌────────────────────────────────┐
                   │ 3️⃣ Recursive Resolver (DNS)   │
                   │ e.g., 8.8.8.8 or 1.1.1.1       │
                   │ Performs recursive lookup      │
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 4️⃣ Root DNS Servers (13 sets)  │
                   │ Reply: “Ask .com TLD servers”  │
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 5️⃣ TLD Server (.com)          │
                   │ Reply: “Ask ns1.exampledns.com”│
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 6️⃣ Authoritative Server        │
                   │ Returns: www.example.com → IP   │
                   │          93.184.216.34          │
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 7️⃣ Resolver Caches Result      │
                   │ Sends IP to OS Resolver         │
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 8️⃣ OS + Browser Cache          │
                   │ Browser now has IP              │
                   └──────────────┬──────────────────┘
                                  │
                                  ▼
                   ┌────────────────────────────────┐
                   │ 9️⃣ Browser connects to server  │
                   │ TCP/UDP → 93.184.216.34         │
                   │ Loads website                   │
                   └────────────────────────────────┘


```sql
Browser (recursive query)
   ↓
OS (recursive query)
   ↓
Recursive Resolver (does iterative queries)
   ↓
Root DNS → .com TLD → Authoritative Server
   ↑
   └── Resolver collects answer → returns final IP
```
---------------------------------------------------------------------------------------
# Installtion and configuration: