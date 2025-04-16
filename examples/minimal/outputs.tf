output "repo_name" {
  description = "The name of the GitHub repository."
  value       = module.github_repo.repository_name
}

output "repo_full_name" {
  description = "The full name (owner/repo) of the GitHub repository."
  value       = module.github_repo.repository_full_name
}

output "repo_url" {
  description = "The HTTPS URL of the GitHub repository."
  value       = module.github_repo.repository_url
}
