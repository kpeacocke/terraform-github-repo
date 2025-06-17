# Output Values

This page documents all output values that are exported by the Terraform GitHub Repository module.

## Repository Information

| Name | Description | Type |
|------|-------------|------|
| repository_id | The ID of the repository | `string` |
| repository_name | The name of the repository | `string` |
| repository_full_name | The full name of the repository (owner/name) | `string` |
| repository_html_url | The HTML URL of the repository | `string` |
| repository_ssh_clone_url | The SSH clone URL of the repository | `string` |
| repository_http_clone_url | The HTTPS clone URL of the repository | `string` |
| repository_git_clone_url | The Git clone URL of the repository | `string` |
| repository_node_id | The Node ID of the repository | `string` |

## Branch Information

| Name | Description | Type |
|------|-------------|------|
| default_branch | The default branch of the repository | `string` |
| protected_branches | Map of branch names to protection rule details | `map(any)` |

## Access Information

| Name | Description | Type |
|------|-------------|------|
| collaborators | List of collaborators with their permissions | `list(map(string))` |
| team_permissions | List of teams with their permissions | `list(map(string))` |

## Webhook Information

| Name | Description | Type |
|------|-------------|------|
| webhook_urls | List of webhook URLs configured for the repository | `list(string)` |
| webhook_ids | Map of webhook URLs to their IDs | `map(string)` |

## Usage Example

```hcl
module "github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"
  
  name        = "example-repo"
  description = "Example repository"
}

output "repo_url" {
  value = module.github_repo.repository_html_url
}

output "clone_command" {
  value = "git clone ${module.github_repo.repository_ssh_clone_url}"
}
```

For more detailed information about each output, see the source code or the module's README.
