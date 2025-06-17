# Compliance

This guide explains how to use the Terraform GitHub Repository module to help meet compliance requirements.

## Compliance Features

The module provides several features that help meet common compliance requirements:

### Audit Logging

All changes to repository settings are tracked through Terraform state and can be integrated with audit systems.

### CODEOWNERS Enforcement

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "compliant-repository"
  description = "Compliance-focused GitHub repository"
  
  branch_protection = {
    main = {
      require_code_owner_reviews = true
    }
  }
  
  files = {
    "CODEOWNERS" = {
      content = <<-EOT
      # Default owners for everything
      *       @kpeacocke/security-team
      
      # Owners for specific files
      *.tf    @kpeacocke/platform-team
      *.md    @kpeacocke/docs-team
      EOT
    }
  }
}
```

### Security Policies

The module can automatically create security policies:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "compliant-repository"
  description = "Compliance-focused GitHub repository"
  
  files = {
    "SECURITY.md" = {
      content = file("${path.module}/templates/SECURITY.md")
    }
  }
}
```

## Compliance Reports

The module can generate compliance reports through Terraform outputs that can be used for audit purposes.

## Integration with Compliance Tools

The module works well with compliance scanning tools like:

- Checkov
- Terrascan
- tfsec
- Snyk
