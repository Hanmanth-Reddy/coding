# 07_Monitoring_Management.md

# Azure Monitoring & Management Hands-On Practice Guide

## 1. Azure Monitor
### Enable Monitor on a VM
```bash
az monitor diagnostic-settings create   --resource /subscriptions/<sub-id>/resourceGroups/MyComputeRG/providers/Microsoft.Compute/virtualMachines/MyUbuntuVM   --name MyDiagSettings   --workspace /subscriptions/<sub-id>/resourceGroups/MyMonitorRG/providers/Microsoft.OperationalInsights/workspaces/MyLogWorkspace   --metrics '[{"category": "AllMetrics","enabled": true}]'
```

### Create Metric Alert
```bash
az monitor metrics alert create   -g MyMonitorRG   -n CPUHighAlert   --scopes /subscriptions/<sub-id>/resourceGroups/MyComputeRG/providers/Microsoft.Compute/virtualMachines/MyUbuntuVM   --condition "avg Percentage CPU > 80"   --description "Alert when CPU > 80%"   --severity 2
```

## 2. Log Analytics
### Create Workspace
```bash
az monitor log-analytics workspace create   -g MyMonitorRG   -n MyLogWorkspace   -l eastus
```

### Query Example
```bash
az monitor log-analytics query   --workspace MyLogWorkspace   --analytics-query "AzureActivity | take 10"
```

## 3. Application Insights
### Create AI Resource
```bash
az monitor app-insights component create   -g MyMonitorRG   -n MyAppInsights   -l eastus   --application-type web
```

### Query Example
```bash
az monitor app-insights query   -a MyAppInsights   --analytics-query "requests | take 10"
```

## 4. Automation & Runbooks
### Create Automation Account
```bash
az automation account create   -g MyMonitorRG   -n MyAutomation   -l eastus
```

### Create Runbook
```bash
az automation runbook create   -g MyMonitorRG   -n MyRunbook   --automation-account-name MyAutomation   --type PowerShell
```

### Start Runbook
```bash
az automation runbook start   -g MyMonitorRG   -n MyRunbook   --automation-account-name MyAutomation
```
