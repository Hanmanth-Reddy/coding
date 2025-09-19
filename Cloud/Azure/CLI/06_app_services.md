# 06_App_Services.md

# Azure App Services Hands-On Practice Guide

## 1. App Service Plan
```bash
az appservice plan create   -g MyAppRG   -n MyAppServicePlan   -l eastus   --sku B1   --is-linux
```

## 2. Web App (Linux)
```bash
az webapp create   -g MyAppRG   -n mywebapp123   --plan MyAppServicePlan   --runtime "PYTHON:3.11"
```

### Deploy Code from Local Git
```bash
az webapp deployment source config-local-git   -g MyAppRG   -n mywebapp123
```

## 3. Azure Functions
### Create Function App
```bash
az functionapp create   -g MyAppRG   -n myfuncapp123   --storage-account mystorageacct123   --consumption-plan-location eastus   --runtime python
```

### Deploy Function Code
```bash
func azure functionapp publish myfuncapp123
```

## 4. Logic Apps
### Create Logic App (Consumption)
```bash
az logic workflow create   -g MyAppRG   -n mylogicapp123   -l eastus   --definition @logicappdefinition.json
```

## 5. Event Grid
### Create Topic
```bash
az eventgrid topic create   -g MyAppRG   -n mytopic123   -l eastus
```

### Subscribe to Topic
```bash
az eventgrid event-subscription create   -g MyAppRG   --name mysub123   --source-resource-id /subscriptions/<sub-id>/resourceGroups/MyAppRG/providers/Microsoft.EventGrid/topics/mytopic123   --endpoint https://mywebhook.site/endpoint
```
