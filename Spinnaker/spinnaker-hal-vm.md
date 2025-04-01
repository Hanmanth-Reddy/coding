# Spinnaker Installation


## Install & Configure MinIO (S3-Compatible)
```
curl -o /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x /usr/local/bin/minio

nohup minio server /minio &
```
[OR]
```
sudo mkdir -p /opt/minio
curl -o /usr/local/bin/minio https://dl.min.io/server/minio/release/linux-amd64/minio
chmod +x /usr/local/bin/minio

# Create a MinIO user
sudo useradd -r minio -s /sbin/nologin
sudo chown minio:minio /opt/minio

# Start MinIO as a service
echo '[Unit]
Description=MinIO Storage
After=network.target

[Service]
User=minio
ExecStart=/usr/local/bin/minio server /opt/minio
Restart=always
Environment="MINIO_ACCESS_KEY=admin"
Environment="MINIO_SECRET_KEY=admin123"

[Install]
WantedBy=multi-user.target' | sudo tee /etc/systemd/system/minio.service

sudo systemctl daemon-reload
sudo systemctl enable --now minio

```
 
### Step 1. Install halyard
```
curl -O https://raw.githubusercontent.com/spinnaker/halyard/master/install/debian/InstallHalyard.sh
sudo bash InstallHalyard.sh

hal -v

#### hal command reference doc:
https://spinnaker.io/docs/reference/halyard/commands/

*[or]*

## Update & Install Required Dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y openjdk-11-jdk unzip curl apt-transport-https ca-certificates gnupg2

## Add the Halyard Repository & Install Halyard
curl -fsSL https://spinnaker.io/downloads/apt/pubkey.asc | sudo gpg --dearmour -o /usr/share/keyrings/spinnaker-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spinnaker-keyring.gpg] https://spinnaker.io/downloads/apt stable main" | sudo tee /etc/apt/sources.list.d/spinnaker.list

sudo apt update
sudo apt install -y spinnaker-halyard

## Start Halyard & Verify Installation
sudo systemctl enable halyard
sudo systemctl start halyard
hal --version

```
### Step2: Configure Storage for Spinnaker
Spinnaker needs a persistent storage backend. You can use MinIO (S3-compatible), Google Cloud Storage, or Azure Blob Storage.
```
# To setup Minio as Storage
ENDPOINT=http://localhost:9009                              
MINIO_ACCESS_KEY=minioadmin
MINIO_SECRET_KEY=minioadmin
echo $MINIO_SECRET_KEY | 
     hal config storage s3 edit --endpoint $ENDPOINT \
    --access-key-id $MINIO_ACCESS_KEY \
    --secret-access-key

hal config storage edit --type s3



hal config storage s3 edit --endpoint http://localhost:9000 \
  --access-key-id admin \
  --secret-access-key admin123 \
  --bucket spinnaker

hal config storage edit --type s3


## To setup Google Cloud Storage (GCS) as storage
hal config storage gcs edit --bucket <GCS_BUCKET_NAME> --project <GCP_PROJECT_ID>
hal config storage edit --type gcs

mkdir -p ~/.hal/default/profiles
echo "GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json" | tee ~/.hal/default/profiles/gcs-local.yml


## To setup  Azure Blob Storage as storage
hal config storage azs edit --storage-account-name <AZURE_STORAGE_ACCOUNT> --storage-account-key <AZURE_STORAGE_KEY>
hal config storage edit --type azs


## To setup AWS S3 bucket as storage 

hal config storage s3 edit --bucket <S3_BUCKET_NAME> \
  --access-key-id <AWS_ACCESS_KEY> \
  --secret-access-key <AWS_SECRET_KEY> \
  --region <AWS_REGION>
hal config storage edit --type s3
```




### Step 3: Configure & Install Spinnaker
```
hal version list
export VERSION=1.33.3
hal config version edit --version $VERSION
hal deploy apply
```

### Step 4: Start Spinnaker Services
```
hal deploy connect
http://localhost:9000

hal config security ui edit --override-base-url "http://<LoadBalancerIP>:9000"
hal config security api edit --override-base-url "http://<LoadBalancerIP>:8084"
hal deploy apply
```

### Troubleshooting
```
sudo journalctl -u halyard -f
hal deploy connect


systemctl status redis
systemctl status clouddriver
systemctl status orca
systemctl status front50
systemctl status gate
systemctl status echo
systemctl status rosco
systemctl status igor
systemctl status deck
systemcl status minio
```

### To purge/clean up deployment and Uninstall halyard
```
hal deploy clean
sudo ~/.hal/uninstall.sh
```
#### To upgrade halyard
```
apt-get update
sudo apt --only-upgrade install spinnaker-halyard
```

### hal commands 
```
hal 
	admin 
	backup 
	config
	deploy
	plugins
	shutdown
	spin
	task
	version
```

### Providers:
```
In Spinnaker, providers are integrations to the Cloud platforms you deploy your applications to.
```

### Spinnaker Accounts:
```
you’ll register credentials for your Cloud platforms. 
Those credentials are known as Accounts in Spinnaker, and Spinnaker deploys your applications via those accounts.

for Spinnaker to do anything you must enable at least one """provider""", with one """Account""" added for it.
```



### Spinnaker Componenets
```
Clouddriver - Manages cloud provider-specific operations (like creating and managing resources).
Orca - The orchestration engine responsible for running pipelines and managing task execution.
Deck - The UI for Spinnaker, typically served as a static web app.
Gate - The API gateway that interacts with the UI and external clients.
Echo - Manages notifications and other event-related functionalities.
Front50 - Manages metadata persistence, like application and pipeline configurations.
Igor - Integrates with CI/CD systems (like Jenkins and GitHub).
Rosco - A Packer service for creating machine images.
keel -
kayenta -
fiat -
```

### packages
```
spinnaker-clouddriver
spinnaker-deck
spinnaker-echo
spinnaker-fiat
spinnaker-front50
spinnaker-gate
spinnaker-halyard
spinnaker-igor
spinnaker-kayenta
spinnaker-keel
spinnaker-monitoring
spinnaker-orca
spinnaker-rosco
```

### Supported Identity Providers
```
Oauth 2.0
SAML
LDAP
```