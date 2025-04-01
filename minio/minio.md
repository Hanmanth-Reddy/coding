Minio is Object(BLOB - Documents, Photos, Videos) storage server. Object storage is widely used in modern computing for handling large amounts of unstructured data, like multimedia files, backups, log data, and more.

##In Windows 
downlaod minio and set path
```
minio server C:\minio --console-address :9001
minio server C:\minio-data --console-address :9001

nohup minio server /minio --address localhost:9009 --console-address <ip/hostname>:9007 &
```

## In Linux, Install & Configure MinIO (S3-Compatible)
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