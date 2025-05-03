

module "repo" {
  source       = "../../../"
  name         = var.name
  owners       = var.owners
  github_token = var.github_token
  github_owner = var.github_owner
}


output "repository_name" {
  value = module.repo.repository_name
}


variable "name" {
  type = string
}

variable "owners" {
  type = list(string)
}

variable "github_token" {
  description = "GitHub token for API access (used in provisioning wait step)"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner (user or org) for API access (used in provisioning wait step)"
  type        = string
}


