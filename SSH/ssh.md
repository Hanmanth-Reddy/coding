SSH or secure shell is cryptographic network protcol, Using SSH you can connect (or) login / access / control the remove remote host security over unsecutre network.
It replaces older insecure protocols like Telnet and rlogin.


22 is the default port
you can  change default port by modifiying `/etc/ssh/sshd_config` config file `Port 2222`  and sshd service restart 



`Password-based authentication`: username + password (less secure)
`Key-based authentication`: uses public/private keys (more secure)

`~/.ssh/id_rsa`: `Private key`
`~/.ssh/id_rsa.pub`: `Public key`

`~/.ssh/authorized_keys` Stores public keys of clients allowed to
connect.

`~/.ssh/known_hosts` Stores fingerprints of previously connected hosts to prevent Man-In-The-Middle(MITM) attacks.

#### To disbale password authentication.
```
edit /etc/ssh/sshd_config --> PasswordAuthentication no
and restart the sshd service
```

### To copy public key to remote host

~/.ssh/id_rsa.pub key to remote host ~/.ssh/authorized_keys

1) scp ~/.ssh/id_rsa.pub user@host:~/.ssh/authorized_keys
2) ssh-copy-id user@host

#### To enable verbose/Debug mode
ssh -vvv user@host


### To control access user.groups ,commands ,ip
Allow only specific users or groups
In /etc/ssh/sshd_config ® AllowUsers admin devops; AllowGroups sysadmin

Restrict user to specific commands
In authorized_keys: command="/path/script.sh" ssh-rsa AAAA...

Allow SSH from specific IPs
/etc/hosts.allow: sshd: 192.168.1.0/24
/etc/hosts.deny: sshd: ALL


#### Local SSH Tunneling (a.k.a. SSH port forwarding)
`ssh -L 8080:localhost:80 user@remotehost` forwards local port 8080 to port 80 on remote host.

SSH tunneling  uses an SSH connection as an encrypted pipe to forward TCP connections from one endpoint to another.
It lets you access services that are not directly reachable (firewalls, NAT, internal networks) by carrying the traffic inside the SSH session.

##### syntax
```
ssh -L [bind_address:]local_port:target_host:target_port [user@]ssh_server

ssh -L -N 80:localhost:8080 root@esrch-worker
```

### reverse tunnel - Remote forwarding (-R):
ssh -R remote_port:local_host:local_port user@ssh_server

## Dynamic SSH Tunnel (SOCKS proxy)
ssh -D 


#### Troubleshooting SSH
- systemctl status sshd
- Check firewall (ufw/iptables)
- ssh -vvv user@host
- Check permissions (700 for ~/.ssh, 600 for authorized_keys)
- Correct ownership (user:user)

## Password-less authentication 
ssh-keygen -t ed25519 -C "your_email@example.com"

```vbnet
~/.ssh/id_ed25519          ← Private key (keep safe!)
~/.ssh/id_ed25519.pub      ← Public key (share with server)

### Copy Public Key to Remote Server
ssh-copy-id username@remote_host
```


## Multi Factor Authentication 
1) Public key + password 
2) Software MFA (Google authenticator)
3) Hardware MFA (yubikeys)
4) RSA secureID


```bash
rpm -qa |grep pam
pam-1.3.1-36.el8_10.x86_64
fprintd-pam-1.90.9-2.el8.x86_64
systemd-pam-239-82.el8_10.3.x86_64
```

```bash
Install PAM (Pluggable Authentication Modules) package in host 

apt install libpam-google-authenticator


vim /etc/ssh/sshd_config

UsePAM yes
KbdInteractiveAuthentication yes


/etc/pam.d
vim /etc/pam.d/sshd

auth required pam_google_authenticator.so secret=/home/${USER}/.google_authenticator
```


## SSH File System


## SSH X11 Forwarding 
is a feature of SSH that lets you run graphical applications on a remote Linux/Unix system and have their GUI displayed on your local machine.

/etc/ssh/sshd_config
X11Forwarding yes
X11DisplayOffset 10
X11UseLocalhost yes

systemctl restart sshd

Simple GUI apps: `xclock`, `gedit`, `xterm`,  `firefox`.


Client: 
`ssh -X user@remote_host`
`ssh -Y user@remote_host`

