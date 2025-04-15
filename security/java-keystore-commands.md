# ☕ Java KeyStore (JKS)

The Java Keystore (JKS) is a repository (basically a file) used by Java applications to store cryptographic keys, certificates, and secrets in a secure way.  
It's commonly used for things like SSL/TLS encryption, authentication, and digital signatures.

---

## 📥 Get Certificate of a Site and Import into Default Truststore (`cacerts`)

```bash
ex +'/BEGIN CERTIFICATE/,/END CERTIFICATE/p' <(echo | openssl s_client -showcerts -connect webexapis.com:443) -scq > app.cer

/apps/java/current/bin/keytool -genkey -alias apphubtruststore -keyalg RSA -keystore apphub.jks

# /apps/java/current/bin/keytool -import -alias apphub -file apphub.cer -keystore apphub.jks -storepass apphub

/apps/java/current/bin/keytool -import -trustcacerts -alias apphub -file /users/esp/app.cer -keystore cacerts  
```

---

## 🛠️ Create Custom Truststore

```bash
keytool -genkey -alias exampletruststore -keyalg RSA -keystore mytruststore.jks
```

---

## 📋 List All Certificates in Truststore

```bash
keytool -list -keystore mytruststore.jks
```

---

## ➕ Import a Certificate into Custom Truststore

```bash
keytool -import -alias example -file example.cer -keystore mytruststore.jks -storepass changeit
```

---

## 🚀 Run JAR File with Custom Truststore

```bash
java -Djavax.net.ssl.trustStore=/some/loc/on/server/mytruststore.jks \
     -Djavax.net.ssl.trustStorePassword=changeit \
     -jar run.jar
```
