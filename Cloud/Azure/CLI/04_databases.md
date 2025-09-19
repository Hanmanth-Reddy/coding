# 04_Databases.md

# Azure Databases Hands-On Practice Guide

## 1. Azure SQL Database
### Create SQL Server
```bash
az sql server create   -g MyDatabaseRG   -n mysqlserver123   -l eastus   -u sqladminuser   -p StrongPassword123!
```

### Create SQL Database
```bash
az sql db create   -g MyDatabaseRG   -s mysqlserver123   -n mydatabase   --service-objective S0
```

### Configure Firewall (allow client IP)
```bash
az sql server firewall-rule create   -g MyDatabaseRG   -s mysqlserver123   -n AllowMyIP   --start-ip-address 203.0.113.5   --end-ip-address 203.0.113.5
```

### Connect via sqlcmd
```bash
sqlcmd -S mysqlserver123.database.windows.net -U sqladminuser -P StrongPassword123!
```

## 2. Azure Cosmos DB (SQL API)
### Create Cosmos Account
```bash
az cosmosdb create   -g MyDatabaseRG   -n mycosmosdb123   -c SQL   --locations regionName=eastus failoverPriority=0 isZoneRedundant=False
```

### Create Database and Container
```bash
az cosmosdb sql database create   -g MyDatabaseRG   --account-name mycosmosdb123   -n mycosmosdbdb

az cosmosdb sql container create   -g MyDatabaseRG   --account-name mycosmosdb123   --database-name mycosmosdbdb   -n mycontainer   --partition-key-path /id
```

## 3. Azure Cache for Redis
```bash
az redis create   -g MyDatabaseRG   -n myredis123   -l eastus   --sku Standard   --vm-size C1
```

## 4. Azure Data Lake Storage Gen2
```bash
az storage account create   -g MyDatabaseRG   -n mydatalakestorage123   -l eastus   --sku Standard_LRS   --kind StorageV2   --enable-hierarchical-namespace true
```

## 5. Azure Synapse Analytics
### Create Synapse Workspace
```bash
az synapse workspace create   -g MyDatabaseRG   -n mysynapsews123   -l eastus   --storage-account mydatalakestorage123   --file-system mysynapsefs
```

### Create Dedicated SQL Pool
```bash
az synapse sql pool create   -g MyDatabaseRG   -n mysynapsesqlpool   --workspace-name mysynapsews123   --performance-level DW100c
```
