# modules/github-repo/variables.tf

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

# modules/github-repo/main.tf

resource "github_repository" "this" {
  name        = var.name
  visibility  = var.visibility
  description = "Managed by Terraform."
  auto_init   = true
  has_issues  = true
  has_wiki    = true
  has_projects = true
  owner       = var.owner
}

resource "github_repository_file" "bootstrap_docs" {
  for_each = var.bootstrap_with_templates ? {
    "README.md"        = "# ${var.name}\n\nProject initialized via Terraform."
    "LICENSE"          = "MIT License"
    "SECURITY.md"      = "# Security Policy\n\nPlease report vulnerabilities..."
    "CONTRIBUTING.md"  = "# Contributing\n\nHow to contribute to this project."
    "CODE_OF_CONDUCT.md" = "# Code of Conduct\n\nBe excellent to each other."
  } : {}

  repository = github_repository.this.name
  file       = each.key
  content    = each.value
  overwrite_on_create = true
  commit_message      = "Add ${each.key} via Terraform bootstrap"
}

resource "github_branch_protection" "main" {
  count = var.enforce_gitflow ? 1 : 0

  repository_id = github_repository.this.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = [] # Add CI contexts here when available
  }

  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }

  restrictions {
    users = []
    teams = []
  }

  require_signed_commits = true
  allows_deletions       = false
  allows_force_pushes    = false
}

resource "github_repository_file" "branch_naming_action" {
  count = var.enforce_gitflow ? 1 : 0

  repository         = github_repository.this.name
  file               = ".github/workflows/enforce-branch-naming.yml"
  content            = <<-EOT
    name: Enforce Branch Naming

    on:
      pull_request:
        types: [opened, edited, reopened]

    jobs:
      check-branch-name:
        runs-on: ubuntu-latest
        steps:
          - name: Validate branch name
            run: |
              BRANCH_NAME=${GITHUB_HEAD_REF}
              if [[ ! $BRANCH_NAME =~ ^(feature|bugfix|hotfix|release)\/.*$ ]]; then
                echo "Branch name '$BRANCH_NAME' does not follow GitFlow naming conventions."
                exit 1
              fi
  EOT
  overwrite_on_create = true
  commit_message      = "Add GitFlow branch naming enforcement"
}
