
# Terraform CLI Commands Cheat Sheet

A handy guide to essential Terraform commands grouped by purpose.

---

## 🔧 Terraform Commands


terraform plan --detroy 
terraform destroy --target=modules.dev_Env_module


-var -var-file -target -refresh

```bash
terraform init -reconfigure



terraform plan -destroy
terraform plan -var-file=prod.tfvars
terraform plan --var-file=prod.tfvars
terraform plan -out v1plan


terraform plan -var="region=us-west1"
terraform plan --var="region=us-west1"


terraform apply --auto-aprove

terraform apply -target=aws_instance.example
terraform apply --target=aws_instance.example
```



```bash
terraform init                    # Initialize the working directory
terraform validate                # Validate the syntax
terraform plan                    # Preview changes (dry run)
terraform apply                   # Provision resources
terraform apply -var 'key=value' # Apply with variable override
terraform apply -auto-approve    # Apply without interactive approval
terraform destroy                # Destroy infrastructure
terraform destroy -auto-approve  # Destroy without confirmation
```

---

## 📦 Resource Management

```bash
terraform show                      # Show state or plan details
terraform state list                # List all resources in the state
terraform state show <resource>    # Show details of a specific resource
terraform taint <resource>         # Mark a resource for recreation
terraform untaint <resource>       # Remove taint mark from a resource, to prevent its recreation.
```

---

## 🌐 Workspace Management

```bash
terraform workspace list             # List all workspaces
terraform workspace create staging   # Create a new workspace
terraform workspace select production # Select a specific workspace
```

---

## 📤 Variables and Outputs

```bash
terraform output                    # Show all outputs defined in the configuration
terraform output <variable_name>    # Show a specific output variable value
```

---

## 🗃️ State and Collaboration

```bash
terraform state pull               # Pull the remote state from the remote backend.
terraform state push               # Push local state to remote backend
terraform refresh                  # Sync real-world state with Terraform state file
terraform lock                     # Lock the state for safe collaboration/to prevent concurrent operations
terraform unlock                   # Manually unlock the state
```

---



## Terraform Concepts
```bash
1)  Providers: Terraform uses **providers** to interact with cloud platforms, SaaS providers, and other APIs.
2)  Resources: Resources are the core building blocks in Terraform.
3)  Variables: Variables allow parameterization of Terraform code.
4)  Modules:   Modules allow code reusability and organization.
5)  Statefile: Terraform keeps track of resources in a **state file** (`terraform.tfstate`).
6)  backends or remote state: Backends define where Terraform stores state files.
7)  Data Sources: Used to fetch information from existing infrastructure.
8)  Outputs: Expose information after deployment. 
9)  Provider block: Defined in the root module for specifying credentials and regions. 
10) workspace: Allow multiple state environments (e.g., dev, prod).
11) Provisioners , to addtional config steps: Used for configuration inside resources (e.g., SSH commands).
12) Meta-Arguments
13) Local Values: Simplify expressions by assigning them to names. 
14) Life CycleRules: Control create/delete/update behaviors.
15) Remote Execution: Run Terraform in CI/CD or cloud platforms (e.g., Terraform Cloud, GitHub Actions). 
16) Dynamic blocks: Used for generating nested blocks dynamically.
17) Service Pricipals: In GCP, **Service Accounts** are the equivalent of **Service Principals** in Azure.
18) Terraform settings block
```


## Syntax:

#### Provider
provider "cloud_provider"{
"key1" = "val1"

}

---
#### Resources sytax
resource "resource_type" "resource_block_name"
{
key1 = "va11"
"key2" = "val2"
}

---

#### Variable
terraform.tfvars
variables.tf

variable "name" {
type = string
description = "description about the file"
default = "default_value"
}

---

#### Statefile
terraform.tfstate

terraform import 

---

#### Backend





#### Modules 
