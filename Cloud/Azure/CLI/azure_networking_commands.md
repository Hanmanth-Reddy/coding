# Azure Networking CLI Practice Guide

This guide provides hands-on commands for building and managing Azure networking resources.  
Before starting, set your defaults:

```bash
az group create -n MyResourceGroup -l eastus
```

---

## 1. Communication with Internet 🌍

### Create a Public IP (Static or Dynamic)
```bash
# Static Public IP
az network public-ip create   -g MyResourceGroup   -n MyPublicIP   --sku Standard   --allocation-method Static
```

```bash
# Dynamic Public IP
az network public-ip create   -g MyResourceGroup   -n MyDynamicIP   --sku Basic   --allocation-method Dynamic
```
... (truncated for brevity, but includes all commands from earlier full practice guide)
