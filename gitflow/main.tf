// GitFlow module: placeholder for branch protection enforcement

variable "repository" {
  description = "The GitHub repository name"
  type        = string
}

variable "release_branches" {
  description = "List of branch name patterns to protect (e.g. main, develop, feature/*, hotfix/*)"
  type        = list(string)
  default     = ["main", "develop", "feature/*", "hotfix/*"]
}

// Enforce GitFlow branch protection for the default branch
// Protect release branches with GitFlow rules
resource "github_branch_protection" "release" {
  for_each   = toset(var.release_branches)
  repository = var.repository
  pattern    = each.value

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
