# 08_DevOps_CICD.md

# Azure DevOps & CI/CD Hands-On Practice Guide

## 1. Azure DevOps Project
### Create Project
```bash
az devops project create --name MyProject
```

### Create Repo
```bash
az repos create --name MyRepo --project MyProject
```

### Create Pipeline (YAML)
```bash
az pipelines create   --name MyPipeline   --project MyProject   --repository MyRepo   --branch main   --yml-path azure-pipelines.yml
```

### Queue Pipeline Run
```bash
az pipelines run --name MyPipeline --project MyProject
```

## 2. GitHub Actions with Azure
### Create Service Principal
```bash
az ad sp create-for-rbac --name MyGitHubSP --role Contributor --scopes /subscriptions/<sub-id>
```

### Use SP in GitHub Secrets for Deployment
```yaml
# Example GitHub Actions snippet
- uses: azure/login@v1
  with:
    creds: ${{ secrets.AZURE_CREDENTIALS }}
```

## 3. Terraform / Bicep Practice
### Initialize Terraform
```bash
terraform init
```

### Apply Terraform Script
```bash
terraform apply -auto-approve
```

### Deploy Bicep Template
```bash
az deployment group create   -g MyRG   --template-file main.bicep
```
