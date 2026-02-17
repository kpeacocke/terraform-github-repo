# Example: Minimal GitHub Repository Module

This example demonstrates a minimal usage of the Terraform module to create and configure a GitHub repository.

## Prerequisites

- Terraform ≥ 1.5.0
- A GitHub Personal Access Token with `repo` scope, exported as `GITHUB_TOKEN`:

```bash
export GITHUB_TOKEN="<your_token>"
```

## Backend Configuration

By default this example uses a local backend:

```hcl
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
```

## Usage

Clone this module and run:

```bash
cd examples/minimal
terraform init
terraform apply
```

The example uses `terraform.tfvars` for variable values. To override any input, you can either edit
`terraform.tfvars` or pass `-var` flags:

```bash
terraform apply -var="name=my-repo" -var="owner=my-org"
```

## Module Call

```hcl
module "github_repo" {
  source = "../.."

  name        = var.name
  owners      = [var.owner]
  visibility  = var.visibility
  license     = "MIT"

  # Enable features
  enforce_gitflow       = var.enforce_gitflow
  enforce_tests         = var.enforce_tests
  enforce_security      = var.enforce_security
  enforce_docs          = var.enforce_docs
  bootstrap_with_templates = var.bootstrap_with_templates
}
```

## Outputs

After `apply`, these outputs will be displayed:

- `repo_name`: The repository name.
- `repo_full_name`: The full name (owner/repo).
- `repo_url`: HTTPS URL of the repository.

```bash
terraform output
```
