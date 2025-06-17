# Advanced Configuration

This guide provides advanced configuration options for the Terraform GitHub Repository module.

## Complete Example

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "advanced-repository"
  description = "Advanced GitHub repository managed by Terraform"
  visibility  = "public"
  
  branch_protection = {
    main = {
      required_reviews             = 2
      required_checks              = ["ci-test", "security-scan"]
      dismiss_stale_reviews        = true
      require_code_owner_reviews   = true
      require_up_to_date_branches  = true
      enforce_admins               = true
    }
  }
  
  topics = [
    "terraform",
    "github",
    "automation"
  ]
  
  template = {
    owner      = "kpeacocke"
    repository = "terraform-github-repo-template"
  }
  
  collaborators = [
    {
      username   = "collaborator1"
      permission = "push"
    },
    {
      username   = "collaborator2"
      permission = "pull"
    }
  ]
}
```

## Working with Teams

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "team-repository"
  description = "Repository with team access"
  visibility  = "private"
  
  teams = [
    {
      name       = "developers"
      permission = "push"
    },
    {
      name       = "security"
      permission = "maintain"
    }
  ]
}
```

## Custom Webhook Configuration

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "webhook-repository"
  description = "Repository with custom webhooks"
  
  webhooks = [
    {
      url          = "https://example.com/webhook"
      content_type = "json"
      events       = ["push", "pull_request"]
      secret       = "webhook-secret"
      active       = true
    }
  ]
}
```
