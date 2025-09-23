# 10_Backup_DR.md

# Azure Backup & Disaster Recovery Hands-On Practice Guide

## 1. Azure Backup
### Create Recovery Services Vault
```bash
az backup vault create   -g MyRecoveryRG   -n MyBackupVault   -l eastus
```

### Enable Backup for VM
```bash
az backup protection enable-for-vm   --vault-name MyBackupVault   -g MyRecoveryRG   --vm MyUbuntuVM   --policy-name DefaultPolicy
```

### Trigger Backup
```bash
az backup protection backup-now   --vault-name MyBackupVault   -g MyRecoveryRG   --container-name IaasVMContainer;iaasvmcontainerv2;MyRecoveryRG;MyUbuntuVM   --item-name MyUbuntuVM
```

## 2. Azure Site Recovery (ASR)
### Enable Replication for VM
```bash
az backup vault backup-properties set   --name MyBackupVault   -g MyRecoveryRG   --backup-storage-redundancy GeoRedundant
```

### Enable Replication to Secondary Region
```bash
az backup protection enable-for-vm   --vault-name MyBackupVault   -g MyRecoveryRG   --vm MyUbuntuVM   --policy-name MyASRPolicy
```
