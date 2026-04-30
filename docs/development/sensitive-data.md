# Handling Sensitive Data in Terraform

This document provides guidance on managing sensitive data in Terraform configurations, particularly for this module.
It specifically covers handling GitHub tokens.

## Mark Variables as Sensitive

Always mark variables containing tokens, passwords or other credentials as sensitive:

```hcl
variable "github_token" {
  description = "GitHub personal access token"
  type        = string
  sensitive   = true  # This prevents the value from being shown in CLI output
}
```

## Use `-compact-warnings` when Running Terraform

When running Terraform commands, use the `-compact-warnings` flag to reduce the chance of sensitive values appearing in logs:

```bash
terraform plan -compact-warnings
```

## Delete Plan Files After Use

Terraform plan files contain a snapshot of all values, including sensitive ones. Always delete them after use:

```bash
terraform plan -out=tfplan.binary
# Use the plan...
rm -f tfplan.binary  # Delete immediately after use
```

## Use GitHub Actions Secrets

In CI/CD workflows, use GitHub Actions secrets rather than environment files:

```yaml
env:
  TF_VAR_github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Use Terraform's `nonsensitive()` Function Carefully

The `nonsensitive()` function unwraps sensitive values and should be used cautiously.
Only use it in cases where you need to output a value and are certain it's safe to do so.

## Avoid Logging Sensitive Values

Avoid debug outputs or logging that might capture sensitive values:

```hcl
# BAD - might log sensitive value
output "debug_token" {
  value = var.github_token
}

# GOOD - keeps value sensitive
output "token_provided" {
  value = var.github_token != null ? "Yes" : "No"
  sensitive = false
}
```

## Test with Dummy Values

For testing, use placeholder values instead of real tokens when possible.
