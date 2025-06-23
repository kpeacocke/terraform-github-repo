# Resources

This page documents all Terraform resources created by the Terraform GitHub Repository module.

## Core Resources

| Resource Type | Purpose |
|---------------|---------|
| `github_repository` | Creates the GitHub repository |
| `github_branch` | Creates additional branches if specified |
| `github_branch_default` | Sets the default branch |

## Protection Resources

| Resource Type | Purpose |
|---------------|---------|
| `github_branch_protection` | Applies branch protection rules |
| `github_branch_protection_v3` | Applied for older GitHub Enterprise instances |

## Access Resources

| Resource Type | Purpose |
|---------------|---------|
| `github_repository_collaborator` | Adds collaborators to the repository |
| `github_team_repository` | Adds team access to the repository |

## Configuration Resources

| Resource Type | Purpose |
|---------------|---------|
| `github_repository_file` | Creates files in the repository |
| `github_repository_webhook` | Creates webhooks for the repository |
| `github_repository_deploy_key` | Adds deploy keys to the repository |
| `github_issue_label` | Creates custom issue labels |

## Security Resources

| Resource Type | Purpose |
|---------------|---------|
| `github_repository_vulnerability_alerts` | Enables vulnerability alerts |
| `github_repository_code_scanning_security` | Enables code scanning (if available) |
| `github_repository_secret_scanning` | Enables secret scanning |

## Resource Dependency Graph

```text
github_repository
├── github_branch
├── github_branch_default
├── github_branch_protection
├── github_repository_collaborator
├── github_team_repository
├── github_repository_file
├── github_repository_webhook
├── github_repository_deploy_key
├── github_issue_label
├── github_repository_vulnerability_alerts
├── github_repository_code_scanning_security
└── github_repository_secret_scanning
```

## Resource Configuration

Most resources in this module are created conditionally based on the provided input variables.
For example, branch protection rules are only created if the `branch_protection` variable is provided.

For more detailed information about each resource and its configuration, see the source code or the module's README.
