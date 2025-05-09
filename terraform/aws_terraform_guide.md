
# AWS Authentication - IAM & Terraform Concepts

This document explains AWS authentication using IAM and how Terraform interacts with AWS, including key Terraform components.

---

## 1. Provider

```hcl
provider "aws" {
  region     = "us-west-2"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
```

Alternatively, use environment variables:

```bash
export AWS_ACCESS_KEY_ID=your-access-key
export AWS_SECRET_ACCESS_KEY=your-secret-key
```

---

## 2. Resources

```hcl
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

---

## 3. Variables

```hcl
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "region" {
  default = "us-west-2"
}
```

---

## 4. Modules

```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my-vpc"
}
```

---

## 5. Statefile

Track resources in `terraform.tfstate`.

```bash
terraform import aws_instance.web i-12345678
```

---

## 6. Backend / Remote State

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "state.tfstate"
    region = "us-west-2"
  }
}
```

---

## 7. Data Sources

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*"]
  }
}
```

---

## 8. Outputs

```hcl
output "instance_id" {
  value = aws_instance.web.id
}
```

---

## 9. Provider Block

Specify credentials and region.

---

## 10. Workspaces

```bash
terraform workspace new staging
terraform workspace select staging
```

---

## 11. Provisioners

```hcl
provisioner "remote-exec" {
  inline = ["sudo yum update -y"]
}
```

---

## 12. Meta-Arguments

- `count`, `for_each`, `depends_on`, `provider`

---

## 13. Local Values

```hcl
locals {
  instance_type = "t2.micro"
}
```

---

## 14. Lifecycle Rules

```hcl
lifecycle {
  prevent_destroy = true
}
```

---

## 15. Remote Execution

Used in CI/CD systems like GitHub Actions or Terraform Cloud.

---

## 16. Dynamic Blocks

```hcl
dynamic "tag" {
  for_each = var.tags
  content {
    key   = tag.key
    value = tag.value
  }
}
```

---

## 17. IAM Roles and Policies

- Use `aws_iam_role`, `aws_iam_policy`, `aws_iam_role_policy_attachment` for role-based authentication.

---

## Terraform Commands

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

---
