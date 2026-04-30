# Security-First Configuration Example

This example demonstrates how to create a repository with a security-first approach using this module.

## Usage

```hcl
module "security_first_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "secure-application"
  description = "Security-focused application repository"
  visibility  = "private"
  
  # Enable all security features
  vulnerability_alerts = true
  secret_scanning      = true
  advanced_security    = true
  
  # Strict branch protection
  branch_protection = {
    main = {
      required_reviews             = 2
      required_checks              = ["security-scan", "sast", "dependency-review", "codeql"]
      dismiss_stale_reviews        = true
      require_code_owner_reviews   = true
      require_signed_commits       = true
      require_up_to_date_branches  = true
      enforce_admins               = true
    }
  }
  
  # Create security workflows
  files = {
    ".github/workflows/codeql.yml" = {
      content = file("${path.module}/templates/workflows/codeql.yml")
    },
    ".github/workflows/dependency-review.yml" = {
      content = file("${path.module}/templates/workflows/dependency-review.yml")
    },
    ".github/workflows/secret-scanning.yml" = {
      content = file("${path.module}/templates/workflows/secret-scanning.yml")
    },
    ".github/workflows/sast.yml" = {
      content = file("${path.module}/templates/workflows/sast.yml")
    },
    "SECURITY.md" = {
      content = file("${path.module}/templates/SECURITY.md")
    },
    "CODEOWNERS" = {
      content = <<-EOT
      # Security team owns all security configurations
      /.github/workflows/codeql.yml              @org/security-team
      /.github/workflows/dependency-review.yml   @org/security-team
      /.github/workflows/secret-scanning.yml     @org/security-team
      /.github/workflows/sast.yml                @org/security-team
      /SECURITY.md                              @org/security-team
      
      # Default ownership
      *                                         @org/developers @org/security-team
      EOT
    }
  }
  
  # Security reporting webhook
  webhooks = [
    {
      url          = "https://security.example.com/reports"
      content_type = "json"
      events       = ["push", "pull_request", "code_scanning_alert", "security_advisory"]
      secret       = var.webhook_secret
      active       = true
    }
  ]
}
```

## Security Features Demonstrated

- Advanced security features (vulnerability alerts, secret scanning, advanced security)
- Strict branch protection rules
- Code signing requirements
- Security-focused workflows (CodeQL, dependency review, secret scanning, SAST)
- Security policy document
- Security ownership in CODEOWNERS
- Security reporting webhook

## How to Apply

1. Copy the example code to your Terraform configuration
2. Replace `x.y.z` with the latest module version
3. Create the necessary workflow template files
4. Set up the required teams in your GitHub organization
5. Set the `webhook_secret` variable
6. Run `terraform init` and `terraform apply`

## Security Best Practices

This example incorporates the following security best practices:

- Required code reviews
- Signed commits
- Automated security scanning
- Clear security ownership
- Dependency monitoring
- Secret scanning
- Security policy
