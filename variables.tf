variable "name" {
  description = "The name of the GitHub repository to create."
  type        = string
}

variable "owners" {
  description = "List of GitHub users or teams who should be set as CODEOWNERS."
  type        = list(string)

  validation {
    condition     = length(var.owners) > 0
    error_message = "You must provide at least one CODEOWNER."
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

variable "enforce_gitflow" {
  description = "Whether to enforce GitFlow naming and branch protection rules."
  type        = bool
  default     = false
}

variable "enforce_tests" {
  description = "Require test coverage or validation before merging PRs."
  type        = bool
  default     = false
}

variable "enforce_security" {
  description = "Enable security tools such as CodeQL scanning and Dependabot alerts."
  type        = bool
  default     = false
}

variable "enforce_docs" {
  description = "Require documentation updates (README, markdown files, etc.) in PRs."
  type        = bool
  default     = false
}

variable "bootstrap_with_templates" {
  description = "If true, initialize the repo with standard files like README.md, LICENSE, SECURITY.md."
  type        = bool
  default     = true
}

variable "enforce_issue_integration" {
  description = "Require PRs to reference GitHub issues (e.g. via #issue-number)."
  type        = bool
  default     = false
}

variable "enforce_project_board" {
  description = "Attach issues/PRs to GitHub Projects if set to true."
  type        = bool
  default     = false
}

variable "traceability_enabled" {
  description = "Enable traceability enforcement such as issue states, assignments, or labels."
  type        = bool
  default     = false
}

variable "enable_weekly_reporting" {
  description = "If true, adds stale issue management and OpenSSF Scorecard workflows."
  type        = bool
  default     = false
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

variable "security_contact" {
  description = "Email or contact address to report security issues."
  type        = string
  default     = "security@your-org.com"
}

variable "enable_auto_labeling" {
  description = "If true, automatically labels PRs and issues based on file paths or content."
  type        = bool
  default     = false
}

variable "enforce_project_board" {
  description = "If true, link issues and PRs to a GitHub project board."
  type        = bool
  default     = false
}

variable "github_project_url" {
  description = "The full URL of the GitHub project to attach issues/PRs to."
  type        = string
  default     = ""
}

variable "enforce_branch_naming" {
  description = "If true, enables branch naming convention enforcement (e.g. feature/*)"
  type        = bool
  default     = false
}