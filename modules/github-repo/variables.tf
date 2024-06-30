variable "name" {
  description = "The name of the GitHub repository to create."
  type        = string
}

variable "owner" {
  description = "The GitHub organization or user account that will own the repository."
  type        = string
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