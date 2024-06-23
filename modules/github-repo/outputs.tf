# modules/github-repo/outputs.tf

output "repository_name" {
  description = "The name of the created GitHub repository"
  value       = github_repository.this.name
}

output "repository_full_name" {
  description = "The full name (owner/repo) of the GitHub repository"
  value       = github_repository.this.full_name
}

output "repository_url" {
  description = "The URL of the GitHub repository"
  value       = github_repository.this.html_url
}