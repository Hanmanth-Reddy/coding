
# 🔐 Generate CSR (Certificate Signing request) and self signed Certificates

## Method 1: 
#### Step 1: Generate Private
```bsah
openssl genrsa -out yourdomain.key 2048

## To verify PrivateKey content

openssl rsa -text -in yourdomain.key -noout
```
#### Step 2: Use Private key to generate CSR
```bash
openssl req -new -key yourdomain.key -out yourdomain.csr
```

#### Step 3: Generate Self signed certs using CSR
```bash
openssl x509 -req -in yourdomain.csr -signkey yourdomain.key -out yourdomain.crt -days 365

```


## Medthod 2:
#### Step 1: Generate CSR along with privateKey
```bash
openssl req -new -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr

```
#### Step 2: Generate Self Singed certs using CSR
```bash
openssl x509 -req -in domain.csr -signkey domain.key -out certificate.crt -days 365

```


## Method 3:
#### Step 1: Generate CSR with Subject Details (no prompt) along with privateKey
``` bash
openssl req -new -newkey rsa:2048 -nodes -keyout private.key -out request.csr   \
-subj "/C=US/ST=California/L=SanJose/O=AI Systems Inc./OU=IT/CN=example.aisystems.com/emailAddress=hanmanth.scm@gmail.com"

[or]

openssl req -new -newkey rsa:2048 -nodes -keyout ElasticCloudEnterprise.key -out ElasticCloudEnterprise.csr   \
-subj "/C=US/ST=California/L=San Jose/O=Cisco Systems Inc./OU=M1788009/CN=*.ece-alln.cisco.com"    \
-addext "subjectAltName=DNS:ece.cisco.com,DNS:*.ece.cisco.com, DNS:ece-alln.cisco.com,DNS:*.ece-alln.cisco.com" 
```

#### Step 2: Generate Self Singed certs using CSR
```bash
openssl x509 -req -in request.csr -signkey private.key -out certificate.crt -days 365
```


## Method 4:
#### Generate Private Key and Self-Signed Certificate in One Command
```bash
openssl req -x509 -newkey rsa:2048 -keyout private.key -out certificate.crt -days 365 -nodes
```



---

## To verify PrivateKey content
```bash
openssl rsa -text -in yourdomain.key -noout
```
## To verify CSR information
```bash
openssl req -text -in domain.csr -noout -verify
```
## View Certificate Details
```bash
openssl x509 -in certificate.crt -text -noout
```

---


## Convert PEM to PKCS#12 (.p12) format
```bash
openssl pkcs12 -export -out certificate.p12 -inkey private.key -in certificate.crt
```





=================== command to connect server using client and get some info  ===========================
openssl s_client -connect domain.com:443 < /dev/null
openssl s_client -connect domain.com:443 -showcerts < /dev/null
openssl s_client -connect techtarget.com:443 -tlsextdebug -msg   // To check for Heartbleed Vulnerability
openssl s_client -connect example.com:443 -cert client_cert.pem -key client_key.pem  // specify client cert 

//To check whether server supports specific TLS version
openssl s_client -connect example.com:443 -ssl3
openssl s_client -connect example.com:443 -tls1
openssl s_client -connect example.com:443 -tls1_1
openssl s_client -connect example.com:443 -tls1_2

openssl s_client -connect techtarget.com:443 < /dev/null | openssl x509 -text -noout


============================ X509=================================================
openssl x509 -in certificate.crt -text -noout
openssl x509 -outform der -in certificate.pem -out certificate.der
openssl x509 -inform der -in certificate.der -out certificate.pem

openssl x509 -in certificate.crt -noout -dates
openssl x509 -in certificate.crt -noout -fingerprint
openssl x509 -in certificate.crt -noout -serial


openssl verify -CAfile ca.crt certificate.crt

openssl x509 -in certificate.crt -pubkey -noout > public_key.pem //Extact publich key from Digitalcert

========================== TO generate privateKey ================================
openssl genrsa -out private.key 2048
openssl genpkey -algorithm RSA -out private.key
