# 🔐 Secure Communication: TCP Connection and TLS Handshake

---

## 📶 TCP Connection Establishment

Before any secure communication happens, a basic TCP connection is established using the **three-way handshake**:

1. **SYN** – Client sends a synchronization request to the server.
2. **SYN-ACK** – Server acknowledges with a SYN-ACK response.
3. **ACK** – Client sends an ACK back to complete the handshake.

---

## 🔒 TLS (SSL) Handshake

This occurs **after** the TCP connection is established, initiating a secure communication channel using TLS (formerly SSL).

### 1. ClientHello (Client Initiation)

The browser or client sends a **ClientHello** message to the server. This message includes:

- ✅ TLS version supported by the client  
- ✅ List of cipher suites (encryption algorithms and key exchange methods) the client supports  
- ✅ A client-generated random value  
- ✅ (Optional) Extensions such as SNI (Server Name Indication)

---

### 2. ServerHello & Server Authentication

The server responds with a **ServerHello** message and certificate information:

- ✅ Selects the highest TLS version supported by both sides  
- ✅ Chooses a cipher suite from the client’s list  
- ✅ Sends its own random value  
- ✅ Sends its **digital certificate**, which includes its **public key** and identity

#### 🔍 Client Validates the Certificate:
- Checks whether the certificate is issued by a **trusted Certificate Authority (CA)**  
- Ensures the certificate is **not expired or revoked**  
- Verifies that the **domain name** matches the certificate

---

### 3. Key Exchange & Session Key Generation

- 🔐 The client generates a **pre-master secret**.
- 🔐 This pre-master secret is **encrypted with the server’s public key** (from the certificate) and sent to the server.
- 🔐 The server decrypts the pre-master secret using its **private key**.

#### 🔑 Both parties now:
- Derive the **same session key** from the pre-master secret and exchanged random values.
- This session key is used for **symmetric encryption** going forward.

---

### 4. Secure Data Exchange

Using the session key:
- All communication between client and server is **encrypted with symmetric encryption** (faster and more efficient than asymmetric encryption).

---

### 5. Data Integrity and Authentication

To ensure that the data hasn't been tampered with:
- 🔐 A **Message Authentication Code (MAC)** is attached with each encrypted message.
- ✅ The recipient verifies the MAC to ensure **data integrity** and authenticity.

---

### 6. Decryption and Display

- The browser uses the session key to **decrypt** the received data.
- Once decrypted, the browser processes or displays the information (e.g., webpage content).

---

### 7. Session Renewal & Reauthentication

- TLS sessions are **not infinite**.
- Periodically, the client and server may perform a **session renegotiation**:
  - 🔄 New session keys are generated to maintain **forward secrecy** and **enhanced security**.

---

## ✅ Summary

| Step | Description |
|------|-------------|
| TCP | Basic 3-way connection |
| TLS Handshake | ClientHello, ServerHello, cert exchange |
| Auth & Cert Validation | Client checks server’s identity |
| Key Exchange | Pre-master secret → session key |
| Data Security | Symmetric encryption + MAC |
| Decryption | Browser decrypts with session key |
| Renewal | Session renegotiation for long-lived sessions |

---

### ℹ️ Note:
This process is part of **HTTPS (HTTP over TLS)**. While SSH also establishes secure connections, it follows a different handshake protocol. This explanation specifically applies to **TLS/SSL**, used in web browsers and APIs.












# 🔐 SSH Handshake vs TLS/SSL Handshake

This document outlines the SSH handshake process and highlights key differences from the TLS/SSL handshake used in HTTPS.

---

## 🚀 Overview

| Feature              | SSH                                    | TLS/SSL                                |
|----------------------|-----------------------------------------|-----------------------------------------|
| Used For             | Remote shell access, file transfer      | Secure websites, APIs                   |
| Protocol Layer       | Application layer                       | Transport layer                         |
| Authentication       | User + Host                             | Server (Client optional)                |
| Key Exchange         | DH/ECDH + Host Key                      | RSA, ECDHE, DH                          |
| Default Port         | 22                                      | 443                                     |
| Session Resumption   | No (each connection is fresh)           | Yes (via session tickets/resumption)   |

---

## 📡 SSH Handshake Steps

## 🧱 High-Level Steps of SSH Handshake
1. TCP Connection
2. Protocol Version Exchange
3. Key Exchange (KEX)
4. Server Authentication
5. User Authentication


### 1. 🔌 TCP Connection
- Client initiates a TCP connection to the SSH server (usually on port `22`).

---

### 2. 📦 Protocol Version Exchange
- Client and server exchange SSH protocol versions:
  ```text
  Client: SSH-2.0-OpenSSH_8.9
  Server: SSH-2.0-OpenSSH_7.4

## 🔑 3. Key Exchange (KEX)

SSH initiates a key exchange phase to securely establish a **shared secret (session key)** between the client and the server. This is typically done using:

- **Diffie-Hellman (DH)**
- **Elliptic Curve Diffie-Hellman (ECDH)**
- **Curve25519 (modern and preferred)**

### 🔐 Host Key Authentication

As part of the key exchange, the **server sends its host public key** to prove its identity.

The client checks this key against:

- Known entries in `~/.ssh/known_hosts`
- Trusted certificate authorities (in enterprise setups)

> ⚠️ If the server’s host key is not recognized, the client prompts the user:
> _“Are you sure you want to continue connecting (yes/no)?”_

---

## 👤 4. User Authentication

Once the secure channel is in place, the client authenticates **as a user** to the server. SSH supports multiple authentication mechanisms:

### 🔐 Public Key Authentication (Preferred)
- The client proves it possesses the **private key** that corresponds to a **public key** stored on the server (in `~/.ssh/authorized_keys`).
- Uses digital signature for proof, without exposing the private key.

### 🔑 Password Authentication
- Client sends a password securely over the encrypted channel.
- Not as secure or scalable as public key authentication.

### 🔁 Keyboard-Interactive
- Used for multi-factor methods or systems like PAM.
- Server sends one or more prompts to the client (e.g., OTP, questions).

### 🧾 GSSAPI Authentication (Optional)
- Uses Kerberos or similar systems for Single Sign-On (SSO).

---

## 🔐 5. Encrypted Session Established

Once authentication succeeds, SSH establishes a secure, encrypted session:

- All data between client and server is encrypted using the **session key**.
- Encryption and MAC algorithms ensure:
  - **Confidentiality** (data privacy)
  - **Integrity** (no tampering)
  - **Authentication** (trusted communication)

### 🔧 Capabilities After Session Start

SSH enables multiple secure functionalities:

- 🖥 **Remote Command Execution**
- 📁 **File Transfers** (via SCP, SFTP)
- 🔀 **Tunneling / Port Forwarding**
- 🧩 **Multiple channels over one connection** (e.g., terminal + file transfer)

---







## SSL handshake
============= TCP Connection =================
1) TCP connection Establishment.



============= SSH Handshake ==================
1) Browser/Client sending a "ClientHello" message to the server

This message includes information such as 
	a) the TLS version supported by the client, 
	b) a list of cipher suites (encryption algorithms and key exchange methods) it supports
	3) and a random value.

2) Server Authentication (SSL/TLS Handshake):
  a) The server responds with a "ServerHello" message, with the
	selecting the highest TLS version that both the client and server support.
	The server also chooses a cipher suite from the list provided by the client and 
	sends its own random value.
	the certificate is issued by a trusted CA and contains the server's public key.

  b) The browser performs several checks on the server's certificate to ensure the server's identity and the integrity of the certificate:
      It verifies whether the certificate is issued by a trusted CA.
      It checks if the certificate has expired or is still valid.

  c) The browser generates a pre-master secret and encrypts it with the server's public key and send back to encrypted pre-master secret the server.

3) Key Exchange and Session Key Generation:
   a) The server decrypts the pre-master secret using its private key.
   b) Both the browser & the server independently generate a session key based on the pre-master secret.
      This session key will be used to encrypt and decrypt data during the secure communication session.
	  
4) Secure Data Exchange:
With the session key now established, the browser and server can exchange data securely using symmetric encryption. 
   
5) Data Integrity and Authentication:
  a) To ensure the integrity of the data, a Message Authentication Code (MAC) is often used. This code is generated using a shared secret key and is sent along with the encrypted data.
  b) The browser can verify the integrity of the received data by checking the MAC.

6) Data Decryption and Display:
  a) The browser uses the session key to decrypt the received data, making it readable and usable.

7) Renewal and Reauthentication:
  a) The SSL/TLS session has a limited lifetime. To maintain security, the browser and server periodically renegotiate the session, generating new encryption keys.
