# Enterprise Setup Example

This example demonstrates how to use the module in an enterprise environment with team permissions  
and advanced security features.

## Usage

```hcl
module "enterprise_github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "enterprise-app"
  description = "Enterprise application repository with security features"
  visibility  = "private"
  
  branch_protection = {
    main = {
      required_reviews           = 2
      required_checks            = ["ci-test", "security-scan", "compliance-check"]
      dismiss_stale_reviews      = true
      require_code_owner_reviews = true
      require_signed_commits     = true
    }
    
    production = {
      required_reviews           = 3
      required_checks            = ["ci-test", "security-scan", "compliance-check", "performance-test"]
      dismiss_stale_reviews      = true
      require_code_owner_reviews = true
      require_signed_commits     = true
      enforce_admins             = true
    }
  }
  
  teams = [
    {
      name       = "developers"
      permission = "push"
    },
    {
      name       = "security-team"
      permission = "maintain"
    },
    {
      name       = "operations"
      permission = "maintain"
    },
    {
      name       = "senior-leadership"
      permission = "admin"
    }
  ]
  
  vulnerability_alerts = true
  secret_scanning      = true
  
  files = {
    "CODEOWNERS" = {
      content = <<-EOT
      # Default owners
      *                 @org/security-team
      
      # Infrastructure
      *.tf             @org/platform-team
      *.tfvars         @org/platform-team
      
      # CI/CD
      /.github/        @org/platform-team
      
      # Application code
      /src/            @org/developers
      /test/           @org/developers
      EOT
    },
    
    "SECURITY.md" = {
      content = file("${path.module}/templates/SECURITY.md")
    }
  }
  
  webhooks = [
    {
      url          = "https://security.example.com/webhook"
      content_type = "json"
      events       = ["push", "pull_request"]
      secret       = var.webhook_secret
      active       = true
    }
  ]
}
```

## Features Demonstrated

- Private repository with multiple branch protection rules
- Team access management
- Security features (vulnerability alerts, secret scanning)
- CODEOWNERS setup
- Security policy
- Security webhook integration

## How to Apply

1. Copy the example code to your Terraform configuration
2. Replace `x.y.z` with the latest module version
3. Set up the required teams in your GitHub organization
4. Set the `webhook_secret` variable
5. Run `terraform init` and `terraform apply`
