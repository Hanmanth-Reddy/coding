
# GCP Authentication - Service Accounts & Terraform Concepts

This document covers how GCP authentication via service accounts works in Terraform, along with key Terraform components and syntax.

---

## 1. Providers

Terraform uses **providers** to interact with cloud platforms, SaaS providers, and other APIs.

```hcl
provider "google" {
  credentials = file("path-to-service-account.json")
  project     = "your-gcp-project-id"
  region      = "your-region"
}
```

- `google` is the official provider for GCP.
- You authenticate using a **Service Account JSON key file**.

---

## 2. Resources

Resources are the core building blocks in Terraform.

```hcl
resource "google_compute_instance" "vm_instance" {
  name         = "my-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}
```

---

## 3. Variables

Variables allow parameterization of Terraform code.

**variables.tf**
```hcl
variable "instance_name" {
  type        = string
  description = "Name of the VM instance"
  default     = "my-instance"
}
```

**terraform.tfvars**
```hcl
instance_name = "custom-instance"
```

---

## 4. Modules

Modules allow code reusability and organization.

```hcl
module "network" {
  source  = "./modules/network"
  network_name = "my-vpc"
}
```

---

## 5. Statefile

Terraform keeps track of resources in a **state file** (`terraform.tfstate`).

```bash
terraform show
terraform state list
terraform state show <resource>
terraform import <resource> <existing-id>
```

---

## 6. Backend / Remote State

Backends define where Terraform stores state files.

**Example: GCS as backend**
```hcl
terraform {
  backend "gcs" {
    bucket  = "my-terraform-state-bucket"
    prefix  = "terraform/state"
  }
}
```

Run:  
```bash
terraform init
```

---

## 7. Data Sources

Used to fetch information from existing infrastructure.

```hcl
data "google_compute_image" "debian" {
  family  = "debian-11"
  project = "debian-cloud"
}
```

---

## 8. Outputs

Expose information after deployment.

```hcl
output "instance_ip" {
  value = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
```

---

## 9. Provider Block

Defined in the root module for specifying credentials and regions.

```hcl
provider "google" {
  credentials = file("account.json")
  region      = "us-central1"
  project     = "my-project"
}
```

---

## 10. Workspaces

Allow multiple state environments (e.g., dev, prod).

```bash
terraform workspace new dev
terraform workspace select dev
terraform workspace list
```

---

## 11. Provisioners

Used for configuration inside resources (e.g., SSH commands).

```hcl
provisioner "remote-exec" {
  inline = [
    "sudo apt update",
    "sudo apt install nginx -y"
  ]
}
```

---

## 12. Meta-Arguments

Special arguments used in resources:
- `count` — Create multiple resources
- `for_each` — Loop over maps/sets
- `depends_on` — Control dependencies
- `provider` — Override default provider

---

## 13. Local Values

Simplify expressions by assigning them to names.

```hcl
locals {
  instance_type = "e2-medium"
}
```

Usage:
```hcl
machine_type = local.instance_type
```

---

## 14. Lifecycle Rules

Control create/delete/update behaviors.

```hcl
resource "google_compute_instance" "vm" {
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [metadata]
  }
}
```

---

## 15. Remote Execution

Run Terraform in CI/CD or cloud platforms (e.g., Terraform Cloud, GitHub Actions).

- Requires backend configuration.
- Set environment variables for credentials.

---

## 16. Dynamic Blocks

Used for generating nested blocks dynamically.

```hcl
variable "tags" {
  type = list(string)
  default = ["web", "prod"]
}

resource "google_compute_instance" "example" {
  dynamic "tags" {
    for_each = var.tags
    content {
      key = tags.value
    }
  }
}
```

---

## 17. Service Principals (GCP)

> In GCP, **Service Accounts** are the equivalent of **Service Principals** in Azure.

- You create a service account in IAM.
- Assign roles (like `roles/editor`, `roles/compute.admin`)
- Generate and download a **JSON key**.
- Use this key in your provider block to authenticate.

---

## Useful Terraform Commands

```bash
terraform init        # Initialize configuration
terraform plan        # Preview changes
terraform apply       # Apply changes
terraform destroy     # Destroy infrastructure
terraform fmt         # Format configuration
terraform validate    # Validate syntax
```

---

Let me know if you want this in `.docx`, `.pdf`, or as a sample Terraform project repo too!
