module "github_repo" {
  source = "../.."

  name         = var.name
  owners       = [var.owner]
  visibility   = var.visibility
  license      = "MIT"
  languages    = ["go", "python"]
  github_owner = var.github_owner
  github_token = var.github_token

  enforce_gitflow                        = var.enforce_gitflow
  enforce_tests                          = var.enforce_tests
  enforce_security                       = var.enforce_security
  enforce_docs                           = var.enforce_docs
  enforce_issue_integration              = var.enforce_issue_integration
  enforce_project_board                  = var.enforce_project_board
  traceability_enabled                   = var.traceability_enabled
  enable_weekly_reporting                = var.enable_weekly_reporting
  enable_codeql                          = true
  enable_dependabot                      = true
  enable_secret_scanning                 = true
  enable_secret_scanning_push_protection = true
  enable_dependabot_alerts               = true
  enable_dependabot_security_updates     = true
  require_codeql_workflow                = true
}