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


#### SSH Tunneling (a.k.a. SSH port forwarding)
`ssh -L 8080:localhost:80 user@remotehost` forwards local port 8080 to port 80 on remote host.

SSH tunneling  uses an SSH connection as an encrypted pipe to forward TCP connections from one endpoint to another.
It lets you access services that are not directly reachable (firewalls, NAT, internal networks) by carrying the traffic inside the SSH session.

##### syntax
```
ssh -L [bind_address:]local_port:target_host:target_port [user@]ssh_server
```

### reverse tunnel - Remote forwarding (-R):
ssh -R remote_port:local_host:local_port user@ssh_server

## Dynamic SSH Tunnel (SOCKS proxy)

#### Troubleshooting SSH
- systemctl status sshd
- Check firewall (ufw/iptables)
- ssh -vvv user@host
- Check permissions (700 for ~/.ssh, 600 for authorized_keys)
- Correct ownership (user:user)
