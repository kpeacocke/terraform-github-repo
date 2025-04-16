output "repository_name" {
  description = "The name of the created GitHub repository."
  value       = module.github_repo.repository_name
}

output "repository_full_name" {
  description = "The full name (owner/repo) of the created GitHub repository."
  value       = module.github_repo.repository_full_name
}

output "repository_url" {
  description = "The HTTPS URL of the created GitHub repository."
  value       = module.github_repo.repository_url
}

output "branch_protection_enforcement" {
  description = "Map of branch patterns to admin enforcement status."
  value       = module.github_repo.branch_protection_enforcement
}

output "branch_protection_rule_ids" {
  description = "List of branch protection rule resource IDs for each release branch."
  value       = module.github_repo.branch_protection_rule_ids
}
