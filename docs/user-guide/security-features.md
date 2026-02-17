# Security Features

This guide describes the security features provided by the Terraform GitHub Repository module.

## Branch Protection

Branch protection rules help enforce quality and security standards on your code:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "secure-repository"
  description = "Security-focused GitHub repository"
  
  branch_protection = {
    main = {
      required_reviews             = 2
      required_checks              = ["security-scan"]
      dismiss_stale_reviews        = true
      require_code_owner_reviews   = true
      require_signed_commits       = true
      enforce_admins               = true
    }
  }
}
```

## Vulnerability Alerting

The module enables vulnerability alerting by default:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name                 = "secure-repository"
  description          = "Security-focused GitHub repository"
  vulnerability_alerts = true
}
```

## Secret Scanning

Secret scanning helps protect against accidentally committed secrets:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name            = "secure-repository"
  description     = "Security-focused GitHub repository"
  secret_scanning = true
}
```

## Security Workflows

The module can automatically set up security workflows:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "secure-repository"
  description = "Security-focused GitHub repository"
  
  security_workflows = {
    enable_codeql        = true
    enable_dependency_review = true
    enable_secret_scanning = true
  }
}
```
