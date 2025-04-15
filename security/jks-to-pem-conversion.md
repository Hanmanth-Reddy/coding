# 🔐 Convert JKS to PEM and Extract Keys Using keytool & OpenSSL

## 1. Convert JKS to PKCS#12 Format
```bash
keytool -importkeystore -srckeystore client.keystore.jks -destkeystore new-store.p12 -deststoretype PKCS12
```

## 2. Extract Certificate from PKCS#12
```bash
openssl pkcs12 -in new-store.p12 -out certificate.pem
```

## 3. Extract Encrypted Private Key (Without Certificates)
```bash
openssl pkcs12 -in new-store.p12 -nocerts -out wso2.key -passin pass:ciscoCM1234stg
```

## 4. Convert to Unencrypted Private Key
```bash
openssl rsa -in wso2.key -out wso2.key
```
