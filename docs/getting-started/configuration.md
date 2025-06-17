# Configuration

This guide explains how to configure the Terraform GitHub Repository module for your specific use case.

## Basic Configuration

To use this module, add it to your Terraform configuration with the required variables:

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "example-repository"
  description = "Example GitHub repository managed by Terraform"
  visibility  = "private"
}
```

## Configuration Variables

The module accepts the following configuration variables:

| Variable | Description | Type | Default |
|----------|-------------|------|---------|
| name | Repository name | `string` | Required |
| description | Repository description | `string` | `""` |
| visibility | Repository visibility (public, private) | `string` | `"private"` |

## Advanced Configuration

For advanced configuration options, see the [Advanced Configuration](../user-guide/advanced-configuration.md) guide.
