output "repository_name" {
  description = "The name of the created GitHub repository."
  value       = github_repository.this.name
}

output "repository_full_name" {
  description = "The full name (e.g., owner/repo) of the GitHub repository."
  value       = github_repository.this.full_name
}

output "repository_url" {
  description = "The HTTPS URL of the GitHub repository."
  value       = github_repository.this.html_url
}

output "repository_ssh_clone_url" {
  description = "The SSH URL of the GitHub repository."
  value       = github_repository.this.ssh_clone_url
}

output "repository_http_clone_url" {
  description = "The HTTP(S) clone URL of the GitHub repository."
  value       = github_repository.this.http_clone_url
}

output "repository_id" {
  description = "The GitHub repository ID."
  value       = github_repository.this.id
}

output "repository_default_branch" {
  description = "The default branch of the GitHub repository."
  value       = github_repository.this.default_branch
}

output "repository_node_id" {
  description = "The GraphQL node ID of the GitHub repository."
  value       = github_repository.this.node_id
}

output "branch_protection_patterns" {
  description = "List of protected branch patterns and their status."
  value = [
    for i in range(length(var.release_branches)) : {
      pattern = var.release_branches[i]
      protection_id = try(github_branch_protection.release[i].id, null)
      enforced = try(github_branch_protection.release[i].enforce_admins, null) != null
    }
  ]
}

output "branch_protection_rule_ids" {
  description = "List of branch protection rule resource IDs for each release branch."
  value       = [for bp in github_branch_protection.release : try(bp.id, null)]
}

output "branch_protection_enforcement" {
  description = "Map of branch patterns to admin enforcement status."
  value       = { for bp in github_branch_protection.release : bp.pattern => try(bp.enforce_admins, null) }
}

locals {
  workflow_resources = flatten([
    github_repository_file.auto_approve_dependabot,
    github_repository_file.codeql_workflow,
    github_repository_file.dependabot,
    github_repository_file.ci_enforcement_workflow,
    github_repository_file.stale,
    github_repository_file.scorecard,
    github_repository_file.traceability,
    github_repository_file.build,
    github_repository_file.release
  ])
}

output "workflow_file_shas" {
  description = "Map of workflow file paths to commit SHAs."
  value       = { for r in local.workflow_resources : r.path => try(r.sha, null) }
}

output "workflow_file_urls" {
  description = "Map of workflow file paths to HTML URLs in the repository."
  value       = { for r in local.workflow_resources : r.path => try(r.html_url, null) }
}

output "codeowners_file_url" {
  description = "The HTML URL of the CODEOWNERS file."
  value       = github_repository_file.codeowners.html_url
}

output "dependabot_config_url" {
  description = "The HTML URL of the Dependabot configuration file."
  value       = github_repository_file.dependabot.html_url
}

