# 05_Identity_Security.md

# Azure Identity & Security Hands-On Practice Guide

## 1. Azure Active Directory (AAD)
### Create a User
```bash
az ad user create   --display-name "John Doe"   --user-principal-name john.doe@mytenant.onmicrosoft.com   --password "StrongPassword123!"   --force-change-password-next-login true
```

### Create a Group
```bash
az ad group create   --display-name "Developers"   --mail-nickname "developers"
```

## 2. Role-Based Access Control (RBAC)
### Assign Role to User
```bash
az role assignment create   --assignee john.doe@mytenant.onmicrosoft.com   --role "Contributor"   --scope /subscriptions/<subscription-id>/resourceGroups/MyDatabaseRG
```

## 3. Managed Identity
### Assign System-Assigned Managed Identity to VM
```bash
az vm identity assign   -g MyComputeRG   -n MyUbuntuVM
```

## 4. Azure Key Vault
### Create Key Vault
```bash
az keyvault create   -g MySecurityRG   -n mykeyvault123   -l eastus
```

### Add a Secret
```bash
az keyvault secret set   --vault-name mykeyvault123   -n MySecret   --value "SuperSecretValue123"
```

### Access Policy
```bash
az keyvault set-policy   -g MySecurityRG   -n mykeyvault123   --spn <service-principal-id>   --secret-permissions get list
```

## 5. Azure Security Center / Defender
### Enable Standard Tier
```bash
az security pricing create   --name VirtualMachines   --tier Standard
```

### View Security Alerts
```bash
az security alert list --query "[].{name:name,severity:severity}" -o table
```
