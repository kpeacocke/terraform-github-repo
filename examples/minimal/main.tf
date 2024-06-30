module "repo" {
  source = "git::https://github.com/your-org/github-repo-module.git//modules/github-repo?ref=v1.0.0"

  name                     = var.name
  owner                    = var.owner
  visibility               = var.visibility

  enforce_gitflow          = var.enforce_gitflow
  enforce_tests            = var.enforce_tests
  enforce_security         = var.enforce_security
  enforce_docs             = var.enforce_docs
  bootstrap_with_templates = var.bootstrap_with_templates
  enforce_issue_integration = var.enforce_issue_integration
  enforce_project_board     = var.enforce_project_board
  traceability_enabled      = var.traceability_enabled
  enable_weekly_reporting   = var.enable_weekly_reporting
}