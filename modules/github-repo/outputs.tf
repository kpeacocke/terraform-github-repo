output "repository_name" {
  value       = github_repository.this.name
  description = "The name of the created GitHub repository."
}

output "repository_full_name" {
  value       = github_repository.this.full_name
  description = "The full name (owner/repo) of the GitHub repository."
}

output "repository_url" {
  value       = github_repository.this.html_url
  description = "The HTTPS URL of the GitHub repository."
}