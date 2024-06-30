resource "github_repository" "this" {
  name        = var.name
  description = "Managed by Terraform"
  visibility  = var.visibility
  auto_init   = true
  has_issues  = true
  has_projects = true
  has_wiki    = false
  # Other settings you may enforce...
}

# Optional file bootstrap (README, LICENSE, SECURITY.md, etc.)
module "bootstrap_files" {
  count  = var.bootstrap_with_templates ? 1 : 0
  source = "./bootstrap" # or wherever you're templating these from

  repository = github_repository.this.name
  branch     = "main"
}

# GitFlow enforcement logic (branch protection, etc.)
module "gitflow" {
  count  = var.enforce_gitflow ? 1 : 0
  source = "./gitflow"

  repository = github_repository.this.name
}

# CodeQL / Security
module "security" {
  count  = var.enforce_security ? 1 : 0
  source = "./security"

  repository = github_repository.this.name
}

# Issue integration, doc enforcement, test checks
module "ci_enforcement" {
  count  = (var.enforce_issue_integration || var.enforce_docs || var.enforce_tests) ? 1 : 0
  source = "./ci"

  repository = github_repository.this.name
  enforce_issue_integration = var.enforce_issue_integration
  enforce_docs              = var.enforce_docs
  enforce_tests             = var.enforce_tests
}

# Add stale.yml
resource "github_repository_file" "stale" {
  count = var.enable_weekly_reporting ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/stale.yml"
  content             = templatefile("${path.module}/templates/stale.yml.tmpl", {})
  commit_message      = "chore: add stale workflow"
  overwrite_on_create = true
}

# Add scorecard.yml
resource "github_repository_file" "scorecard" {
  count = var.enable_weekly_reporting ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/scorecard.yml"
  content             = templatefile("${path.module}/templates/scorecard.yml.tmpl", {})
  commit_message      = "chore: add scorecard workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "codeowners" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/CODEOWNERS"
  content             = templatefile("${path.module}/templates/CODEOWNERS.tmpl", {
    owners = var.owners
  })
  commit_message      = "chore: add CODEOWNERS"
  overwrite_on_create = true
}