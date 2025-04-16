variable "name" {
  type        = string
  description = "The name of the GitHub repository."
}

variable "owner" {
  type        = string
  description = "The GitHub user or organization."
}

variable "visibility" {
  type        = string
  description = "Whether the repo is public or private."
  default     = "private"
}

variable "enforce_gitflow" {
  type    = bool
  default = false
}

variable "enforce_tests" {
  type    = bool
  default = false
}

variable "enforce_security" {
  type    = bool
  default = false
}

variable "enforce_docs" {
  type    = bool
  default = false
}

variable "bootstrap_with_templates" {
  type    = bool
  default = true
}

variable "enforce_issue_integration" {
  type    = bool
  default = false
}

variable "enforce_project_board" {
  type    = bool
  default = false
}

variable "traceability_enabled" {
  type    = bool
  default = false
}

variable "enable_weekly_reporting" {
  type    = bool
  default = false
}