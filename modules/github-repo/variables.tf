variable "name" {
  description = "Name of the GitHub repository"
  type        = string
}

variable "owner" {
  description = "GitHub organization or user name"
  type        = string
}

variable "visibility" {
  description = "Visibility of the repo: public or private"
  type        = string
  default     = "private"
}

variable "enforce_gitflow" {
  description = "Enforce GitFlow naming and branching strategy"
  type        = bool
  default     = false
}

variable "enforce_tests" {
  description = "Enforce presence of tests and test coverage thresholds"
  type        = bool
  default     = false
}

variable "enforce_security" {
  description = "Enable security features like CodeQL and Dependabot"
  type        = bool
  default     = false
}

variable "enforce_docs" {
  description = "Enforce documentation requirements and coverage"
  type        = bool
  default     = false
}

variable "bootstrap_with_templates" {
  description = "Bootstrap repo with standard documentation files"
  type        = bool
  default     = true
}

variable "enforce_issue_integration" {
  description = "Enforce linkage between PRs and issues"
  type        = bool
  default     = false
}

variable "enforce_project_board" {
  description = "Enable GitHub Projects automation"
  type        = bool
  default     = false
}

variable "traceability_enabled" {
  description = "Enable requirement traceability enforcement"
  type        = bool
  default     = false
}

variable "enable_weekly_reporting" {
  description = "Enable weekly scorecard reporting and stale issue automation"
  type        = bool
  default     = false
}

# .gitignore managed via Terraform

resource "github_repository_file" ".gitignore" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository = github_repository.this.name
  file       = ".gitignore"
  content    = <<-EOT
    # === Terraform ===
    *.tfstate
    *.tfstate.*
    .terraform/
    .terraform.lock.hcl
    crash.log
    *.backup

    # === Terratest / Test Artifacts ===
    *.out
    *.test
    *.log
    test/__pycache__/
    test/tmp/
    test/fixtures/.terraform/

    # === VSCode / IDEs ===
    .vscode/
    .idea/
    *.swp

    # === OS Artifacts ===
    .DS_Store
    Thumbs.db

    # === Go ===
    vendor/
    *.exe
    *.exe~
    *.dll
    *.so
    *.dylib
    *.test
    *.tmp
    *.coverprofile
    *.log
    *.mod
    *.sum

    # === Node (if used for scripts) ===
    node_modules/
    npm-debug.log*
    yarn-debug.log*
    yarn-error.log*

    # === GitHub Actions artifacts ===
    .github/workflows/.DS_Store

    # === Local credentials or environment ===
    .env
    .env.*
    *.env.local
    .envrc

    # === Test binary ===
    test/bin/
  EOT
  overwrite_on_create = true
  commit_message      = "Add .gitignore for Terraform + testing"
}
