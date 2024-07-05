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

resource "github_repository_file" "traceability" {
  count = var.traceability_enabled ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/traceability.yml"
  content             = templatefile("${path.module}/templates/traceability.yml.tmpl", {})
  commit_message      = "chore: add traceability enforcement workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "security" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = "SECURITY.md"
  content             = templatefile("${path.module}/templates/SECURITY.md.tmpl", {})
  commit_message      = "chore: add SECURITY policy"
  overwrite_on_create = true
}

resource "github_repository_file" "license" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = "LICENSE"
  content             = templatefile("${path.module}/templates/LICENSE.${var.license}.tmpl", {})
  commit_message      = "chore: add LICENSE (${var.license})"
  overwrite_on_create = true
}

resource "github_repository_file" "readme" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = "README.md"
  content        = templatefile("${path.module}/templates/README.md.tmpl", {
    repo_name = var.name,
    owner     = var.owners[0], # or var.owner if you still support single
    license   = var.license
  })
  commit_message = "docs: add README"
  overwrite_on_create = true
}

resource "github_repository_file" "security" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = "SECURITY.md"
  content             = templatefile("${path.module}/templates/SECURITY.md.tmpl", {
    security_contact = var.security_contact,
    owner            = var.owners[0],
    repo_name        = var.name
  })
  commit_message      = "docs: add SECURITY policy"
  overwrite_on_create = true
}

variable "enable_ci" {
  description = "If true, adds build/test workflow for CI validation."
  type        = bool
  default     = true
}

variable "enable_release" {
  description = "If true, adds semantic-release GitHub workflow."
  type        = bool
  default     = true
}

resource "github_repository_file" "build" {
  count = var.enable_ci ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/build.yml"
  content             = templatefile("${path.module}/templates/build.yml.tmpl", {})
  commit_message      = "ci: add build workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "release" {
  count = var.enable_release ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/release.yml"
  content             = templatefile("${path.module}/templates/release.yml.tmpl", {})
  commit_message      = "ci: add release workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "editorconfig" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".editorconfig"
  content        = templatefile("${path.module}/templates/.editorconfig.tmpl", {})
  commit_message = "chore: add editor config"
  overwrite_on_create = true
}

resource "github_repository_file" "nvmrc" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".nvmrc"
  content        = templatefile("${path.module}/templates/.nvmrc.tmpl", {})
  commit_message = "chore: add Node.js version lock"
  overwrite_on_create = true
}

resource "github_repository_file" "contributing" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = "CONTRIBUTING.md"
  content        = templatefile("${path.module}/templates/CONTRIBUTING.md.tmpl", {})
  commit_message = "docs: add contributing guide"
  overwrite_on_create = true
}