variable "name" {
  description = "Name of the GitHub repository."
  type        = string
}

variable "owner" {
  description = "GitHub user or organization that will own the repository."
  type        = string
}

variable "visibility" {
  description = "Visibility of the repository."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Visibility must be either 'private' or 'public'."
  }
}

variable "enforce_gitflow" {
  description = "Enforce GitFlow-based branch protection and naming policies."
  type        = bool
  default     = false
}

variable "enforce_tests" {
  description = "Require test presence and validation on PRs."
  type        = bool
  default     = false
}

variable "enforce_security" {
  description = "Enable security policies (CodeQL, Dependabot, etc.)."
  type        = bool
  default     = false
}

variable "enforce_docs" {
  description = "Require documentation updates in PRs."
  type        = bool
  default     = false
}

variable "bootstrap_with_templates" {
  description = "Bootstrap repo with README, LICENSE, and SECURITY files."
  type        = bool
  default     = true
}

variable "enforce_issue_integration" {
  description = "Require PRs to reference issues."
  type        = bool
  default     = false
}

variable "enforce_project_board" {
  description = "Enable project board enforcement."
  type        = bool
  default     = false
}

variable "traceability_enabled" {
  description = "Enable traceability checks and tagging."
  type        = bool
  default     = false
}

variable "enable_weekly_reporting" {
  description = "Enable automation for stale issues, repo scorecard, etc."
  type        = bool
  default     = false
}