# 09_AI_Analytics_BigData.md

# Azure AI, Analytics & Big Data Hands-On Practice Guide

## 1. Azure Cognitive Services (AI)
### Create Resource
```bash
az cognitiveservices account create   -g MyAIGRG   -n mycogsvc123   -l eastus   --kind CognitiveServices   --sku S1
```

## 2. Azure Databricks
### Create Workspace
```bash
az databricks workspace create   -g MyAIGRG   -n mydatabricks123   -l eastus   --sku standard
```

### Connect via CLI / Notebook
```bash
databricks workspace ls /
```

## 3. Azure Synapse Analytics / Data Factory
### Create Data Factory
```bash
az datafactory create   -g MyAIGRG   -n mydatafactory123   -l eastus
```

### Create Pipeline
```bash
az datafactory pipeline create   -g MyAIGRG   -f pipeline.json   -n MyPipeline123   -n mydatafactory123
```

## 4. HDInsight / Event Hubs / Stream Analytics
### Create HDInsight Cluster
```bash
az hdinsight create   -g MyAIGRG   -n myhdcluster123   -t spark   -l eastus   --storage-account mystorageacct123
```

### Create Event Hub Namespace & Hub
```bash
az eventhubs namespace create   -g MyAIGRG   -n myehnamespace123   -l eastus

az eventhubs eventhub create   -g MyAIGRG   --name myhub123   --namespace-name myehnamespace123
```

### Create Stream Analytics Job
```bash
az stream-analytics job create   -g MyAIGRG   -n mystreamjob123   -l eastus   --output-error-policy Stop
```
