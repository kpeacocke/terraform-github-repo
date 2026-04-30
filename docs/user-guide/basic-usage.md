# Basic Usage

This guide provides basic usage examples for the Terraform GitHub Repository module.

## Creating a Repository

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "example-repository"
  description = "Example GitHub repository managed by Terraform"
  visibility  = "private"
}
```

## Adding Branch Protection

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "example-repository"
  description = "Example GitHub repository managed by Terraform"
  visibility  = "private"
  
  branch_protection = {
    main = {
      required_reviews = 1
      required_checks  = ["ci-test"]
    }
  }
}
```

## Next Steps

For more advanced usage, check out the [Advanced Configuration](advanced-configuration.md) guide  
or the [Security Features](security-features.md) documentation.
