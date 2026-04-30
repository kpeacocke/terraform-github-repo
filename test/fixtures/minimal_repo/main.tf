output "repository_name" {
  value = module.repo.repository_name
}
module "repo" {
  source = "../../../"

  name                               = var.name
  owners                             = var.owners
  visibility                         = var.visibility
  license                            = var.license
  enforce_gitflow                    = false
  enforce_tests                      = false
  enforce_security                   = false
  enforce_docs                       = false
  bootstrap_with_templates           = true
  enforce_issue_integration          = false
  enforce_project_board              = false
  traceability_enabled               = false
  languages                          = var.languages
  enable_codeql                      = var.enable_codeql
  enable_weekly_reporting            = false
  disable_actions_until_provisioning = true # Keep actions disabled to avoid permissions issues
  github_token                       = var.github_token
  github_owner                       = var.github_owner
}

variable "github_token" {
  description = "GitHub token for API access (used in provisioning wait step)"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner (user or org) for API access (used in provisioning wait step)"
  type        = string
}

variable "name" {
  type = string
}

variable "owners" {
  description = "List of GitHub users or orgs for CODEOWNERS."
  type        = list(string)

  validation {
    condition     = length(var.owners) > 0
    error_message = "Missing required variable 'owners'"
  }
}
variable "visibility" {
  description = "Whether the repository should be 'private' or 'public'."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Visibility must be either 'private' or 'public'."
  }
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

variable "license" {
  description = "The open source license to apply (MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0)."
  type        = string
  default     = "MIT"

  validation {
    condition = contains(
      ["MIT", "Apache-2.0", "GPL-3.0", "BSD-3-Clause", "MPL-2.0"],
      var.license
    )
    error_message = "License must be one of: MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0"
  }
}