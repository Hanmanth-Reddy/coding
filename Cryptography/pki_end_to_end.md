
# 🧩 End-to-End PKI Commands and Use Cases

This document explains the complete **PKI (Public Key Infrastructure)** process — from generating keys and CSRs to signing, verifying, and revoking certificates — using **OpenSSL**.

---

## 🧱 1. Setup a Root Certificate Authority (CA)

### **Use Case:** Create an internal CA to sign internal TLS or VPN certificates.

```bash
openssl genrsa -out rootCA.key 4096

openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt   -subj "/C=US/ST=California/L=SanJose/O=ABC Corp/OU=IT/CN=ABC-Root-CA"
```

✅ **Result:**
- `rootCA.key` → Root CA private key  
- `rootCA.crt` → Root CA certificate (self-signed)

---

## 🧾 2. Create Intermediate CA

### **Use Case:** Keep the Root CA offline; use Intermediate CA to issue certificates.

```bash
openssl genrsa -out intermediateCA.key 4096

openssl req -new -key intermediateCA.key -out intermediateCA.csr   -subj "/C=US/ST=California/L=SanJose/O=ABC Corp/OU=Security/CN=ABC-Intermediate-CA"

openssl x509 -req -in intermediateCA.csr -CA rootCA.crt -CAkey rootCA.key   -CAcreateserial -out intermediateCA.crt -days 1825 -sha256   -extfile <(echo "basicConstraints=CA:TRUE,pathlen:0")
```

✅ **Result:**
- `intermediateCA.crt` signed by `rootCA.crt`

---

## 🌐 3. Create a Server Certificate

### **Use Case:** Create TLS cert for a web server.

```bash
openssl genrsa -out webserver.key 2048

openssl req -new -key webserver.key -out webserver.csr   -subj "/C=US/ST=California/L=SanJose/O=ABC Corp/OU=Web/CN=webserver.example.com"

openssl x509 -req -in webserver.csr -CA intermediateCA.crt -CAkey intermediateCA.key   -CAcreateserial -out webserver.crt -days 825 -sha256   -extfile <(echo "subjectAltName=DNS:webserver.example.com,DNS:www.example.com")
```

✅ **Result:**
- `webserver.key` → Private key  
- `webserver.crt` → Signed by Intermediate CA

---

## 👨‍💻 4. Create a Client Certificate

### **Use Case:** Use in mTLS or VPN authentication.

```bash
openssl genrsa -out client.key 2048

openssl req -new -key client.key -out client.csr   -subj "/C=US/ST=California/L=SanJose/O=ABC Corp/OU=Client/CN=hanmanth"

openssl x509 -req -in client.csr -CA intermediateCA.crt -CAkey intermediateCA.key   -CAcreateserial -out client.crt -days 730 -sha256   -extfile <(echo "extendedKeyUsage=clientAuth")
```

✅ Used for:
- mTLS (server verifies client cert)
- VPN authentication

---

## 🧪 5. Verify Certificates

```bash
openssl verify -CAfile <(cat intermediateCA.crt rootCA.crt) webserver.crt
```

Expected output:
```
webserver.crt: OK
```

---

## 🧰 6. Convert Certificate Formats

```bash
# PEM → DER
openssl x509 -in webserver.crt -outform der -out webserver.der

# PEM + Key → PFX (for Windows/IIS)
openssl pkcs12 -export -out webserver.pfx -inkey webserver.key -in webserver.crt   -certfile intermediateCA.crt
```

---

## ❌ 7. Revoke Certificates (CRL Management)

```bash
openssl ca -gencrl -out rootCA.crl -keyfile rootCA.key -cert rootCA.crt

openssl ca -revoke webserver.crt -keyfile intermediateCA.key -cert intermediateCA.crt

openssl ca -gencrl -out intermediateCA.crl -keyfile intermediateCA.key -cert intermediateCA.crt
```

Publish `.crl` file on your internal CA web server.

---

## 🔍 8. OCSP Validation

```bash
openssl ocsp -index index.txt -port 9999 -rsigner intermediateCA.crt -rkey intermediateCA.key -CA rootCA.crt

openssl ocsp -CAfile rootCA.crt -url http://localhost:9999   -issuer intermediateCA.crt -cert webserver.crt
```

---

## 🧩 9. Combine Full Chain

```bash
cat webserver.crt intermediateCA.crt rootCA.crt > fullchain.pem
```

✅ Use `fullchain.pem` for web servers like Nginx/Apache.

---

## 🔒 10. Real-World Use Cases

| Use Case | Certificates Used | Example |
|-----------|------------------|----------|
| HTTPS/TLS | Server + Intermediate + Root | Nginx, Apache |
| VPN | Client + Server + CA | OpenVPN, WireGuard |
| Mutual TLS | Client + Server | API-to-API |
| Email Security | Client | S/MIME |
| Code Signing | Developer cert | Signing binaries |
| Container Security | CA + Server | Harbor registry, K8s webhook |

---
