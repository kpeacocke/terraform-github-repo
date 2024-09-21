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

