# Input Variables

This page documents all input variables that can be provided to the Terraform GitHub Repository module.

## Required Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the repository | `string` | n/a | yes |

<!-- markdownlint-disable MD013 -->
## Optional Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| description | Description of the repository | `string` | `""` | no |
| visibility | Visibility of the repository: public or private | `string` | `"private"` | no |
| auto_init | Set to true to initialize the repository with a README | `bool` | `false` | no |
| topics | List of topics to add to the repository | `list(string)` | `[]` | no |
| issue_labels | Custom issue labels to add to the repository | `map(object({ name = string, color = string, description = string }))` | `{}` | no |
| has_issues | Set to true to enable issues in the repository | `bool` | `true` | no |
| has_projects | Set to true to enable projects in the repository | `bool` | `false` | no |
| has_wiki | Set to true to enable wiki in the repository | `bool` | `false` | no |
| has_discussions | Set to true to enable discussions in the repository | `bool` | `false` | no |
| delete_branch_on_merge | Set to true to automatically delete head branches after merge | `bool` | `true` | no |
| archive_on_destroy | Set to true to archive the repository on destroy | `bool` | `false` | no |
| vulnerability_alerts | Set to true to enable vulnerability alerts | `bool` | `true` | no |
| secret_scanning | Set to true to enable secret scanning | `bool` | `true` | no |
| advanced_security | Set to true to enable advanced security if available | `bool` | `false` | no |
| branch_protection | Branch protection rules | `map(object({ ... }))` | `{}` | no |
| collaborators | List of collaborators to add to the repository | `list(object({ username = string, permission = string }))` | `[]` | no |
| teams | List of teams to give access to the repository | `list(object({ name = string, permission = string }))` | `[]` | no |
| files | Map of files to create in the repository | `map(object({ content = string }))` | `{}` | no |
| webhooks | List of webhooks to add to the repository | `list(object({ url = string, ... }))` | `[]` | no |
| template | Template repository to use | `object({ owner = string, repository = string })` | `null` | no |
| license_template | License template to use | `string` | `null` | no |
| gitignore_template | Gitignore template to use | `string` | `null` | no |

## Branch Protection Variables

The `branch_protection` variable accepts the following parameters:

```hcl
branch_protection = {
  main = {
    required_reviews           = number
    required_checks            = list(string)
    dismiss_stale_reviews      = bool
    require_code_owner_reviews = bool
    require_signed_commits     = bool
    enforce_admins             = bool
    require_up_to_date_branches = bool
  }
}
```

## Webhook Variables

The `webhooks` variable accepts the following parameters:

```hcl
webhooks = [
  {
    url          = string
    content_type = string
    events       = list(string)
    active       = bool
    secret       = string (optional)
  }
]
```

For more detailed information about each variable, see the source code or the module's README.
