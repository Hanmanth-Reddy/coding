Encryption / Decription 

## 🔐 1. Symmetric Encryption
In **symmetric encryption, the same/single secret key** is used for both **encryption and decryption.**

Very fast and efficient (good for large data).Simple to implement.
Key distribution is risky — both parties need the same secret key. If key is stolen, communication is compromised.


* Data confidentiality (protecting files, messages, network data)
* Encrypting private keys (in PEM files)
* Secure file transfer / backups
* TLS/SSL session encryption (HTTPS, VPNs, etc.)

## 🔑 2. Asymmetric Encryption (Public Key Encryption)

In **asymmetric encryption**, two different but mathematically related keys are used:
**Public Key** (shared with everyone)
**Private Key** (kept secret)

1. Sender encrypts data using the **receiver’s public key.**
2. Only the **receiver’s private key** can decrypt it.


**Algorithm type**	Two-key system — a public key (for encrypting / verifying) and a private key (for decrypting / signing).
**Purpose**	Secure key exchange, digital signatures, certificate generation, etc.
**Used** in	TLS/SSL (HTTPS), SSH, PKI (certificates), email encryption, etc.
**OpenSSL** support	Fully supports RSA, EC (Elliptic Curve), and Ed25519 keys.

OpenSSL as a toolkit = supports **both symmetric + asymmetric + hashing + signing + PKI**

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Category                     | Example Commands                                           | Algorithms Shown         | Purpose                                            |
| ---------------------------- | ---------------------------------------------------------- | ------------------------ | -------------------------------------------------- |
| **Message Digest (Hashing)** | `openssl dgst`                                             | sha256, blake2, md5...   | One-way integrity check                            |
| **Cipher (Symmetric)**       | `openssl enc`                                              | aes, des, camellia...    | Fast, reversible encryption                        |
| **Public Key / Asymmetric**  | `openssl genpkey`, `pkey`, `pkeyutl`, `req`, `x509`, `rsa` | RSA, EC, Ed25519, DSA... | Key pair management, signatures, hybrid encryption |
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

## 🧾 3. PKI (Public Key Infrastructure)
**PKI** is the framework and system that manages **public-key encryption and digital certificates.**

**PKI enables:**
✅ Encryption
✅ Authentication
✅ Integrity
✅ Non-repudiation


1. **CA (Certificate Authority):** Issues and signs digital certificates (e.g., DigiCert, Let's Encrypt).
2. **RA (Registration Authority):** Verifies **user/systems identity** before certificate issuance.
3. **Certificate:** Digital file containing **public key + owner info + CA signature.**
4. **CRL (Certificate Revocation List)/ OCSP (Online Certificate Status Protocol):** Mechanisms to revoke expired or compromised certificates.
5. **Repository:** Stores and distributes certificates.

**CRL** is a digitally signed list issued by a Certificate Authority (CA) that contains serial numbers of certificates that have been revoked. The CRL helps clients (like browsers or servers) check if a certificate is still trustworthy.
**OCSP** is a real-time, online protocol used to check the revocation status of a certificate **without downloading** the entire CRL. While CRLs can become large and are updated periodically, OCSP provides faster, on-demand verification.

A repository in PKI is a **publicly accessible database or directory** that stores and distributes:
* Digital certificates (both user and CA)
* Certificate Revocation Lists (CRLs)
* Policy documents

Typical Implementations: **LDAP directories, HTTP/HTTPS servers , File shares**



**PKI Example Use:**
* HTTPS websites
* Email encryption (S/MIME)
* Code signing
* VPNs (IPSec certificates)

## 🔁 4. Hashing

Hashing converts data of any size into a **fixed-size string (hash value or digest)**. It is **one-way** — you cannot reverse it back to the original data.

```mathematica
Plaintext --> [Hash Function] --> Hash Value (e.g., 32/64 characters)
```

**Example algorithms:**
* MD5 (obsolete)
* SHA-1 (obsolete)
* SHA-256, SHA-512 (secure and widely used)

**Properties:**
**Deterministic:** Same input → same output.
**One-way:** Can’t derive original input.
**Collision resistant:** Two inputs shouldn’t give same hash.
**Avalanche effect:** Small input change → large output change.

Uses:
* Password storage (hashed form). pw hashing in some legacy systems, though modern password hashing uses stronger, salted algorithms like bcrypt, scrypt, or Argon2)
* Data integrity checks (e.g., file checksum, openssl dgst -sha256 file.txt)
* Digital signatures (hash before signing)
* Blockchain transactions
* Certificate fingerprinting (in PKI)


----------------------------------------------------
## 🔐 1. Core Cryptographic Concepts

These are the fundamentals — the building blocks of all cryptographic systems:

- **Plaintext / Ciphertext**

- **Key / Keyspace / Key Management**

- **Encryption & Decryption**

- **Symmetric Encryption (AES, DES, ChaCha20)**

- **Asymmetric Encryption (RSA, ECC, Diffie-Hellman)**

- **Hashing (SHA-2, SHA-3, BLAKE2)**

- **Encoding vs Encryption vs Hashing**

- **Entropy & Random Number Generation**

- **Initialization Vector (IV), Salt, Nonce**

- **Digital Signatures**


## 🧾 2. Public Key Infrastructure (PKI) & Certificates

This is what powers secure web communication (HTTPS), VPNs, and more:

- **PKI Architecture (CA, RA, CRL, OCSP)**
- **Digital Certificates (X.509 format)**
- **Certificate Lifecycle (issue, renew, revoke)**
- **Certificate Chains / Trust Hierarchies**
- **Self-signed vs CA-signed Certificates**
- **TLS/SSL Protocols**
- **Mutual TLS (mTLS)**
- **Certificate Pinning**
- **Key Distribution & Key Exchange Protocols (e.g., Diffie–Hellman, ECDH)**


## 🧠 3. Cryptographic Algorithms & Standards

Important families of cryptographic algorithms:

**🔸 Symmetric**
AES (Rijndael) , DES / 3DES, Blowfish / Twofish, ChaCha20 / Salsa20

**🔸 Asymmetric**
RSA, ECC (Elliptic Curve Cryptography), ElGamal, DSA (Digital Signature Algorithm), Diffie-Hellman (Key exchange)

**🔸 Hash Functions**
MD5 (deprecated), SHA-1 (deprecated), SHA-2 family (SHA-224, 256, 384, 512), SHA-3 (Keccak), BLAKE2 / BLAKE3

**🔸 MAC / HMAC**
Message Authentication Codes: combine hashing + secret key for integrity & authenticity.


## 🧩 4. Cryptographic Protocols
Used to establish trust, confidentiality, and integrity between systems:
- **SSL / TLS**
- **IPSec (used in VPNs)**
- **SSH (Secure Shell)**
- **PGP / GPG (Pretty Good Privacy for emails)**
- **Kerberos**
- **S/MIME (Email encryption)**
- **OAuth 2.0 / OpenID Connect (for secure authentication)**


## 🔏 5. Digital Signatures & Authentication

These provide authenticity and non-repudiation:

Digital Signatures (RSA, ECDSA)
Certificate Signing Requests (CSR)
Timestamping
Non-repudiation
Digital vs Electronic Signatures
Challenge–Response Authentication

## 💾 6. Data Integrity & Verification

To ensure that data hasn’t been modified:

- **Checksums (CRC32, Adler32)**
- **MAC (Message Authentication Code)**
- **HMAC (Hashed MAC)**
- **File integrity monitoring tools (tripwire, AIDE)**

## 🧱 7. Advanced / Modern Cryptography

These are cutting-edge or specialized areas:

- **Zero-Knowledge Proofs (ZKP)** → Prove something is true without revealing the actual data.
- **Homomorphic Encryption** → Compute on encrypted data without decrypting it.
- **Post-Quantum Cryptography (PQC)** → Cryptography resistant to quantum computers.
- **Threshold Cryptography / Secret Sharing**
- **Blockchain Cryptography (ECDSA, Merkle Trees)**
- **Ring Signatures / Blind Signatures**

## 🔑 8. Key Management & Security

Critical for DevOps, cloud, and enterprise systems:

- **Key Generation**
- **Key Rotation / Renewal**
- **Key Escrow / Backup**
- **Key Storage (HSMs, Vaults like HashiCorp Vault, AWS KMS, GCP KMS)**
- **Key Destruction / Expiry**

## 🧰 9. Cryptography Tools & Libraries

You’ll often use these in practice:

- **OpenSSL**
- **GnuPG (GPG)**
- **HashiCorp Vault**
- **Keytool (Java Keystore)**
- **Certbot / ACME for SSL**
- **Libsodium / NaCl**
- **Python cryptography library**
- **Bouncy Castle (Java)**

## 🧪 10. Cryptanalysis (Breaking Crypto)

Understanding weaknesses helps secure systems better:

- **Brute Force**
- **Dictionary / Rainbow Table Attacks**
- **Man-in-the-Middle (MITM)**
- **Replay Attacks**
- **Side-Channel Attacks (timing, power analysis)**
- **Padding Oracle Attacks**