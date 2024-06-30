module "repo" {
  source = "git::https://github.com/your-org/github-repo-module.git//modules/github-repo?ref=v1.0.0"

  name                     = "example-repo"
  owner                    = "your-org"
  visibility               = "private"

  enforce_gitflow          = true
  enforce_tests            = true
  enforce_security         = true
  enforce_docs             = true
  bootstrap_with_templates = true
  enforce_issue_integration = true
  enforce_project_board     = false
  traceability_enabled      = false
  enable_weekly_reporting   = false
}