# Installation

## Requirements

- **Terraform**: >= 1.5.0
- **GitHub Provider**: >= 6.0
- **GitHub Token**: Personal access token or GitHub App credentials

## GitHub Provider Setup

### Using Personal Access Token

```hcl title="providers.tf"
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "github" {
  token = var.github_token
  owner = var.github_owner
}
```

### Using GitHub App (Recommended for Organizations)

```hcl title="providers.tf"
provider "github" {
  app_auth {
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    pem_file        = var.github_app_pem_file
  }
  owner = var.github_owner
}
```

## Token Permissions

Your GitHub token needs the following permissions:

### For Personal Access Tokens

- `repo` - Full control of private repositories
- `admin:repo_hook` - Repository webhooks and services
- `admin:org` - Full control of orgs and teams (if managing org repos)
- `delete_repo` - Delete repositories (if cleanup is needed)

### For GitHub Apps

- **Repository permissions:**
  - Administration: Read & write
  - Contents: Read & write  
  - Issues: Read & write
  - Metadata: Read
  - Pull requests: Read & write
  - Security events: Read & write

## Environment Variables

Set up your environment:

```bash title=".env"
# GitHub Configuration
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
GITHUB_OWNER=kpeacocke

# Optional: GitHub App Configuration
GITHUB_APP_ID=123456
GITHUB_APP_INSTALLATION_ID=12345678
GITHUB_APP_PEM_FILE=path/to/private-key.pem
```

## Terraform Variables

Create a `terraform.tfvars` file:

```hcl title="terraform.tfvars"
github_token = "ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
github_owner = "kpeacocke"
```

## Verify Installation

Test your setup:

```bash
terraform init
terraform plan
```

You should see output indicating Terraform can authenticate with GitHub and plan repository creation.

## Next Steps

- [Quick Start Guide](quick-start.md) - Create your first repository
- [Configuration Guide](configuration.md) - Understand all available options
