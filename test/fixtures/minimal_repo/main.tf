output "repository_name" {
  value = module.repo.repository_name
}
module "repo" {
  source = "../../../"

  name                      = var.name
  owners                    = var.owners
  visibility                = var.visibility
  enforce_gitflow           = false
  enforce_tests             = false
  enforce_security          = false
  enforce_docs              = false
  bootstrap_with_templates  = true
  enforce_issue_integration = false
  enforce_project_board     = false
  traceability_enabled      = false
  languages                 = var.languages
  enable_codeql             = var.enable_codeql
  enable_weekly_reporting   = false
  github_token              = var.github_token
  github_owner              = var.github_owner
variable "github_token" {
  description = "GitHub token for API access (used in provisioning wait step)"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner (user or org) for API access (used in provisioning wait step)"
  type        = string
}
}

variable "name" {
  type = string
}

variable "owners" {
  description = "List of GitHub users or orgs for CODEOWNERS."
  type        = list(string)
}
variable "visibility" {
  description = "Whether the repository should be 'private' or 'public'."
  type        = string
  default     = "private"
}
variable "languages" {
  description = "List of languages for CodeQL analysis and templates."
  type        = list(string)
  default     = []
}
variable "enable_codeql" {
  description = "Enable CodeQL analysis workflow."
  type        = bool
  default     = true
}