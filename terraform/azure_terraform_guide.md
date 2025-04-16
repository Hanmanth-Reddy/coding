
# Azure Authentication - Service Principals & Terraform Concepts

This guide explains how to authenticate to Azure using a Service Principal and Terraform concepts.

---

## 1. Provider

```hcl
provider "azurerm" {
  features {}
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
```

---

## 2. Resources

```hcl
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "East US"
}
```

---

## 3. Variables

```hcl
variable "client_id" {}
variable "client_secret" {}
variable "subscription_id" {}
variable "tenant_id" {}
```

---

## 4. Modules

```hcl
module "network" {
  source = "./modules/network"
}
```

---

## 5. Statefile

```bash
terraform state list
terraform state show <resource>
```

---

## 6. Backend / Remote State

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateacct"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
```

---

## 7. Data Sources

```hcl
data "azurerm_subscription" "primary" {}
```

---

## 8. Outputs

```hcl
output "resource_group_name" {
  value = azurerm_resource_group.example.name
}
```

---

## 9. Provider Block

Include Azure AD SP credentials.

---

## 10. Workspaces

```bash
terraform workspace new dev
terraform workspace select dev
```

---

## 11. Provisioners

```hcl
provisioner "local-exec" {
  command = "echo Deployment complete"
}
```

---

## 12. Meta-Arguments

`count`, `for_each`, `depends_on`

---

## 13. Local Values

```hcl
locals {
  location = "East US"
}
```

---

## 14. Lifecycle Rules

```hcl
lifecycle {
  ignore_changes = [tags]
}
```

---

## 15. Remote Execution

Used in CI/CD with Azure DevOps or Terraform Cloud.

---

## 16. Dynamic Blocks

```hcl
dynamic "tags" {
  for_each = var.tags
  content {
    key   = tags.key
    value = tags.value
  }
}
```

---

## 17. Service Principals

- Create an Azure AD Application.
- Assign roles to the Service Principal.
- Use SP credentials in provider block.

---

## Terraform Commands

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

---
