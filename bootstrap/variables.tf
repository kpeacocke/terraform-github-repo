variable "repository" {
  description = "The name of the GitHub repository."
  type        = string
}

variable "branch" {
  description = "The branch to commit files to."
  type        = string
}

variable "owners" {
  description = "List of CODEOWNERS entries (users or teams)."
  type        = list(string)
}

variable "license" {
  description = "License type (e.g., MIT, Apache-2.0)."
  type        = string
}

variable "security_contact" {
  description = "Email or contact for SECURITY.md."
  type        = string
}

variable "languages" {
  description = "List of languages for .gitignore generation."
  type        = list(string)
}
