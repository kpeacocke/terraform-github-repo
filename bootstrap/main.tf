// Bootstrap module: placeholder for repo initialization tasks

variable "repository" {
  description = "The GitHub repository name"
  type        = string
}

variable "branch" {
  description = "The default branch name"
  type        = string
}

resource "null_resource" "bootstrap" {
  triggers = {
    repository = var.repository
    branch     = var.branch
  }
}

// Initialize standard repository files
resource "github_repository_file" "editorconfig" {
  repository          = var.repository
  branch              = var.branch
  file                = ".editorconfig"
  content             = templatefile(
    "${path.module}/../templates/.editorconfig.tmpl", {}
  )
  commit_message      = "chore: add editorconfig"
  overwrite_on_create = true
}

resource "github_repository_file" "nvmrc" {
  repository          = var.repository
  branch              = var.branch
  file                = ".nvmrc"
  content             = templatefile(
    "${path.module}/../templates/.nvmrc.tmpl", {}
  )
  commit_message      = "chore: add Node.js version lock"
  overwrite_on_create = true
}

resource "github_repository_file" "gitignore" {
  repository          = var.repository
  branch              = var.branch
  file                = ".gitignore"
  content             = templatefile(
    "${path.module}/../templates/gitignore.tmpl", {
      languages = var.languages
    }
  )
  commit_message      = "chore: add .gitignore"
  overwrite_on_create = true
}

resource "github_repository_file" "contributing" {
  repository          = var.repository
  branch              = var.branch
  file                = "CONTRIBUTING.md"
  content             = templatefile(
    "${path.module}/../templates/CONTRIBUTING.md.tmpl", {}
  )
  commit_message      = "docs: add contributing guide"
  overwrite_on_create = true
}

resource "github_repository_file" "pull_request_template" {
  repository          = var.repository
  branch              = var.branch
  file                = ".github/PULL_REQUEST_TEMPLATE.md"
  content             = templatefile(
    "${path.module}/../templates/.github/PULL_REQUEST_TEMPLATE.md.tmpl", {}
  )
  commit_message      = "docs: add PR template"
  overwrite_on_create = true
}

// Issue templates
resource "github_repository_file" "issue_template_bug" {
  repository          = var.repository
  branch              = var.branch
  file                = ".github/ISSUE_TEMPLATE/bug_report.yml"
  content             = templatefile(
    "${path.module}/../templates/.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE_bug_report.yml.tmpl", {}
  )
  commit_message      = "docs: add bug report issue template"
  overwrite_on_create = true
}

resource "github_repository_file" "issue_template_feature" {
  repository          = var.repository
  branch              = var.branch
  file                = ".github/ISSUE_TEMPLATE/feature_request.yml"
  content             = templatefile(
    "${path.module}/../templates/.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE_feature_request.yml.tmpl", {}
  )
  commit_message      = "docs: add feature request issue template"
  overwrite_on_create = true
}

resource "github_repository_file" "codeowners" {
  repository          = var.repository
  branch              = var.branch
  file                = ".github/CODEOWNERS"
  content             = templatefile(
    "${path.module}/../templates/CODEOWNERS.tmpl", { owners = var.owners }
  )
  commit_message      = "chore: add CODEOWNERS"
  overwrite_on_create = true
}

resource "github_repository_file" "license" {
  repository          = var.repository
  branch              = var.branch
  file                = "LICENSE"
  content             = templatefile(
    "${path.module}/../templates/LICENSE.${var.license}.tmpl", {}
  )
  commit_message      = "chore: add LICENSE (${var.license})"
  overwrite_on_create = true
}

resource "github_repository_file" "readme" {
  repository          = var.repository
  branch              = var.branch
  file                = "README.md"
  content             = templatefile(
    "${path.module}/../templates/README.md.tmpl", {
      repo_name               = var.repository,
      owner                   = var.owners[0],
      license                 = var.license,
      enable_ci               = false,
      enable_release          = false,
      enable_weekly_reporting = false,
      enable_coverage         = false,
      enforce_gitflow         = false,
      enforce_issue_integration = false,
      enforce_tests             = false,
      enforce_semantic_pr_title = false,
      enforce_branch_naming     = false,
      enforce_project_board     = false,
      traceability_enabled      = false,
      bootstrap_with_templates  = true,
      enable_dependabot         = false,
      languages                 = var.languages
    }
  )
  commit_message      = "docs: add README"
  overwrite_on_create = true
}

resource "github_repository_file" "security" {
  repository          = var.repository
  branch              = var.branch
  file                = "SECURITY.md"
  content             = templatefile(
    "${path.module}/../templates/SECURITY.md.tmpl", {
      security_contact = var.security_contact,
      owner            = var.owners[0],
      repo_name        = var.repository
    }
  )
  commit_message      = "docs: add SECURITY policy"
  overwrite_on_create = true
}
