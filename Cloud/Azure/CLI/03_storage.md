# 03_Storage.md

# Azure Storage Hands-On Practice Guide

## 1. Create a Storage Account
```bash
az storage account create   -g MyStorageRG   -n mystorageacct123   -l eastus   --sku Standard_LRS   --kind StorageV2
```

## 2. Blob Storage
### Create a container
```bash
az storage container create   -g MyStorageRG   --account-name mystorageacct123   -n mycontainer   --public-access blob
```

### Upload / Download Blob
```bash
az storage blob upload   -g MyStorageRG   --account-name mystorageacct123   -c mycontainer   -f ./file.txt   -n file.txt

az storage blob download   -g MyStorageRG   --account-name mystorageacct123   -c mycontainer   -n file.txt   -f ./downloaded_file.txt
```

## 3. File Share
```bash
az storage share create   -g MyStorageRG   --account-name mystorageacct123   -n myfileshare
```

## 4. Table Storage
```bash
az storage table create   -g MyStorageRG   --account-name mystorageacct123   -n mytable
```

## 5. Queue Storage
```bash
az storage queue create   -g MyStorageRG   --account-name mystorageacct123   -n myqueue
```

## 6. Lifecycle Management (Blob Tiering)
```bash
az storage account management-policy create   -g MyStorageRG   --account-name mystorageacct123   --policy @policy.json
```
