// GitFlow module: placeholder for branch protection enforcement

variable "repository" { type = string }

// Enforce GitFlow branch protection for the default branch
resource "github_branch_protection" "main" {
  repository = var.repository
  pattern    = var.branch

  enforce_admins = true

  required_status_checks {
    strict   = true
    contexts = []
  }

  required_pull_request_reviews {
    dismiss_stale_reviews          = true
    require_code_owner_reviews     = true
    required_approving_review_count = 1
  }
}
