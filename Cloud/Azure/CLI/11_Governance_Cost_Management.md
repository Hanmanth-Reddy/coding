# 11_Governance_Cost_Management.md

# Azure Governance & Cost Management Hands-On Practice Guide

## 1. Resource Tags
### Apply Tags to Resource Group
```bash
az tag create --resource-id /subscriptions/<sub-id>/resourceGroups/MyRG --tags env=prod owner=hanmanth
```

## 2. Resource Locks
### Add Lock to RG
```bash
az lock create   --name LockRG   --lock-type CanNotDelete   --resource-group MyRG
```

## 3. Azure Policy
### Assign Policy
```bash
az policy assignment create   --name denyPublicIP   --policy "DenyPublicIP"   -g MyRG
```

## 4. Azure Blueprints (via portal + ARM templates)
Blueprints are not fully CLI-supported, but you can assign definitions through ARM or REST.

## 5. Cost Management
### View Usage
```bash
az consumption usage list --start-date 2025-01-01 --end-date 2025-01-31
```
