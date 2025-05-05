# Quick Start

Get up and running with the Terraform GitHub Repository Module in just a few minutes.

## Basic Repository

Create a simple repository with default security settings:

```hcl title="main.tf"
module "my_repo" {
  source = "kpeacocke/terraform-github-repo/github"
  
  name       = "my-new-repo"
  owners     = ["@my-team"]
  visibility = "private"
}
```

```bash
terraform init
terraform apply
```

## Secure Repository

Create a repository with enhanced security features:

```hcl title="main.tf"
module "secure_repo" {
  source = "kpeacocke/terraform-github-repo/github"
  
  name       = "secure-project"
  owners     = ["@security-team", "@dev-team"]
  visibility = "private"
  
  # Security Features
  enforce_gitflow   = true
  enforce_security  = true
  enable_codeql     = true
  enable_dependabot = true
  
  # Branch Protection
  release_branches = ["main", "release/*"]
  
  # Automation
  allow_auto_merge = true
  enable_dependabot_autoapprove = true
}
```

## Enterprise Repository

Create a repository with full enterprise governance:

```hcl title="main.tf"
module "enterprise_repo" {
  source = "kpeacocke/terraform-github-repo/github"
  
  name       = "enterprise-app"
  owners     = ["@platform-team"]
  visibility = "private"
  
  # Repository Configuration
  languages = ["go", "python", "javascript"]
  license   = "Apache-2.0"
  
  # Governance & Compliance
  enforce_gitflow           = true
  enforce_tests             = true
  enforce_security          = true
  enforce_docs              = true
  enforce_issue_integration = true
  traceability_enabled      = true
  
  # Security Scanning
  enable_codeql             = true
  enable_dependabot         = true
  enable_secret_scanning    = true
  enable_secret_scanning_push_protection = true
  
  # Branch Configuration
  release_branches = ["main", "release/*", "hotfix/*"]
  status_check_contexts = [
    "ci/build",
    "ci/test",
    "ci/security-scan"
  ]
  
  # Project Integration
  enforce_project_board = true
  github_project_url    = "https://github.com/orgs/kpeacocke/projects/1"
}
```

## Outputs

Access repository information:

```hcl title="outputs.tf"
output "repository_url" {
  description = "The HTTPS URL of the repository"
  value       = module.my_repo.repository_url
}

output "clone_url" {
  description = "The SSH clone URL"
  value       = module.my_repo.repository_ssh_clone_url
}

output "repository_id" {
  description = "The GitHub repository ID"
  value       = module.my_repo.repository_id
}
```

## What Happens Next?

When you apply the configuration, the module will:

1. **Create the repository** with your specified settings
2. **Set up branch protection** on main and release branches  
3. **Configure security features** like CodeQL and secret scanning
4. **Add template files** (README, LICENSE, SECURITY.md, etc.)
5. **Enable workflows** for CI/CD and security automation
6. **Configure Dependabot** for dependency management

## Verification

Check that everything was created correctly:

```bash
# View the repository
gh repo view kpeacocke/my-new-repo

# Check branch protection
gh api repos/kpeacocke/my-new-repo/branches/main/protection

# List workflows
gh workflow list --repo kpeacocke/my-new-repo
```

## Next Steps

- [Configuration Guide](configuration.md) - Understand all available options
- [Security Features](../user-guide/security-features.md) - Deep dive into security capabilities
- [Examples](../examples/basic.md) - More comprehensive examples
