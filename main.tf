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


# GitFlow enforcement logic (branch protection, etc.)
module "gitflow" {
  count  = var.enforce_gitflow ? 1 : 0
  source = "./gitflow"

  repository       = github_repository.this.name
  release_branches        = var.release_branches
  status_check_contexts   = var.status_check_contexts
}

# CodeQL / Security
module "security" {
  count  = var.enforce_security ? 1 : 0
  source = "./security"

  repository        = github_repository.this.name
  enable_codeql     = var.enable_codeql
  enable_dependabot = var.enable_dependabot
  languages         = var.languages
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

# CI enforcement workflow
resource "github_repository_file" "ci_enforcement_workflow" {
  count = var.enforce_issue_integration || var.enforce_docs || var.enforce_tests ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/ci-enforcement.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/ci-enforcement.yml.tmpl", {
      enforce_issue_integration = var.enforce_issue_integration,
      enforce_docs              = var.enforce_docs,
      enforce_tests             = var.enforce_tests
    }
  )
  commit_message      = "ci: add CI enforcement workflow"
  overwrite_on_create = true
}

# Add stale.yml
resource "github_repository_file" "stale" {
  count = var.enable_weekly_reporting ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/stale.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/stale.yml.tmpl", {})
  commit_message      = "chore: add stale workflow"
  overwrite_on_create = true
}

# Add scorecard.yml
resource "github_repository_file" "scorecard" {
  count = var.enable_weekly_reporting ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/scorecard.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/scorecard.yml.tmpl", {})
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
  content             = templatefile("${path.module}/templates/.github/workflows/traceability.yml.tmpl", {})
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
  content = templatefile("${path.module}/templates/README.md.tmpl", {
    repo_name                 = var.name,
    owner                     = var.owners[0],
    license                   = var.license,
    enable_ci                 = var.enable_ci,
    enable_release            = var.enable_release,
    enable_weekly_reporting   = var.enable_weekly_reporting,
    enable_coverage           = var.enable_coverage,
    enforce_gitflow           = var.enforce_gitflow,
    enforce_issue_integration = var.enforce_issue_integration,
    enforce_tests             = var.enforce_tests,
    enforce_semantic_pr_title = var.enforce_semantic_pr_title,
    enforce_branch_naming     = var.enforce_branch_naming,
    enforce_project_board     = var.enforce_project_board,
    traceability_enabled      = var.traceability_enabled,
    bootstrap_with_templates  = var.bootstrap_with_templates,
    enable_dependabot         = var.enable_dependabot,
    languages                 = var.languages
  })
  commit_message = "docs: add README"
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
  content             = templatefile("${path.module}/templates/.github/workflows/build.yml.tmpl", {})
  commit_message      = "ci: add build workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "release" {
  count = var.enable_release ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/release.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/release.yml.tmpl", {})
  commit_message      = "ci: add release workflow"
  overwrite_on_create = true
}

// Add CHANGELOG and semantic-release config
resource "github_repository_file" "changelog" {
  count = var.enable_release ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = "CHANGELOG.md"
  content             = templatefile(
    "${path.module}/templates/CHANGELOG.md.tmpl", {}
  )
  commit_message      = "docs: add CHANGELOG"
  overwrite_on_create = true
}

resource "github_repository_file" "release_config" {
  count = var.enable_release ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = "release.config.js"
  content             = file("${path.module}/release.config.js")
  commit_message      = "chore: add semantic-release config"
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

resource "github_repository_file" "pull_request_template" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".github/PULL_REQUEST_TEMPLATE.md"
  content        = file("${path.module}/templates/.github/PULL_REQUEST_TEMPLATE.md")
  commit_message = "docs: add PR template"
  overwrite_on_create = true
}

resource "github_repository_file" "issue_template_bug" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".github/ISSUE_TEMPLATE/bug_report.yml"
  content        = file("${path.module}/templates/.github/ISSUE_TEMPLATE_bug_report.yml")
  commit_message = "docs: add bug report issue template"
  overwrite_on_create = true
}
// Add feature request issue template
resource "github_repository_file" "issue_template_feature" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".github/ISSUE_TEMPLATE/feature_request.yml"
  content        = templatefile(
    "${path.module}/templates/.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE_feature_request.yml.tmpl",
    {}
  )
  commit_message = "docs: add feature request issue template"
  overwrite_on_create = true
}

resource "github_repository_file" "pr_labeler_workflow" {
  count = var.enable_auto_labeling ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/labeler.yml"
  content             = file("${path.module}/templates/.github/workflows/labeler.yml.tmpl")
  commit_message      = "ci: add PR labeler workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "issue_labeler_workflow" {
  count = var.enable_auto_labeling ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/autolabel-issues.yml"
  content             = file("${path.module}/templates/.github/workflows/autolabel-issues.yml.tmpl")
  commit_message      = "ci: add issue auto-labeling workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "labeler_config" {
  count = var.enable_auto_labeling ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/labeler.yml"
  content             = file("${path.module}/templates/.github/labeler.yml.tmpl")
  commit_message      = "ci: add labeler config"
  overwrite_on_create = true
}

resource "github_repository_file" "auto_project_link" {
  count = var.enforce_project_board ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".github/workflows/project-board.yml"
  content        = templatefile("${path.module}/templates/.github/workflows/project-board.yml.tmpl", {
    project_url = var.github_project_url
  })
  commit_message = "ci: add project board auto-linking"
  overwrite_on_create = true
}

resource "github_repository_file" "branch_naming_check" {
  count = var.enforce_branch_naming ? 1 : 0

  repository     = github_repository.this.name
  branch         = "main"
  file           = ".github/workflows/branch-naming.yml"
  content        = file("${path.module}/templates/.github/workflows/branch-naming.yml.tmpl")
  commit_message = "ci: add branch naming enforcement"
  overwrite_on_create = true
}

resource "github_repository_file" "semantic_pr_title" {
  count = var.enforce_semantic_pr_title ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/semantic-pr-title.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/semantic-pr-title.yml.tmpl", {})
  commit_message      = "ci: add semantic PR title check"
  overwrite_on_create = true
}

resource "github_repository_file" "dependabot" {
  count               = var.enable_dependabot ? 1 : 0
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = templatefile("${path.module}/templates/.github/dependabot.yml.tmpl", {})
  commit_message      = "chore: add Dependabot config"
  overwrite_on_create = true
}

// Add pre-commit hooks configuration
resource "github_repository_file" "pre_commit_config" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".pre-commit-config.yaml"
  content             = templatefile(
    "${path.module}/templates/.pre-commit-config.yaml.tmpl", {}
  )
  commit_message      = "chore: add pre-commit hooks config"
  overwrite_on_create = true
}
resource "github_repository_file" "gitignore" {
  count = var.bootstrap_with_templates ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".gitignore"
  content             = templatefile("${path.module}/templates/gitignore.tmpl", {
    languages = var.languages
  })
  commit_message      = "chore: add .gitignore"
  overwrite_on_create = true
}

resource "github_repository_file" "codeql_workflow" {
  count = var.enable_codeql && length(var.languages) > 0 ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/codeql.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/codeql.yml.tmpl", {
    languages = [for lang in var.languages : lower(trimspace(lang))]
  })
  commit_message      = "chore: add CodeQL workflow"
  overwrite_on_create = true
}

// Test workflows: single-version or matrix per language
resource "github_repository_file" "test_go_single" {
  count = var.enable_coverage && !var.enable_matrix && contains(var.languages, "go") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-go.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-go-single.yml.tmpl", {
      default_version = lookup(var.language_default_versions, "go", "")
    }
  )
  commit_message      = "ci: add Go test workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_go_matrix" {
  count = var.enable_coverage && var.enable_matrix && contains(var.languages, "go") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-go-matrix.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-go-matrix.yml.tmpl", {
      matrix_versions = var.language_matrix_versions["go"]
    }
  )
  commit_message      = "ci: add Go test matrix workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_python_single" {
  count = var.enable_coverage && !var.enable_matrix && contains(var.languages, "python") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-python.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-python-single.yml.tmpl", {
      default_version = lookup(var.language_default_versions, "python", "")
    }
  )
  commit_message      = "ci: add Python test workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_python_matrix" {
  count = var.enable_coverage && var.enable_matrix && contains(var.languages, "python") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-python-matrix.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-python-matrix.yml.tmpl", {
      matrix_versions = var.language_matrix_versions["python"]
    }
  )
  commit_message      = "ci: add Python test matrix workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_javascript_single" {
  count = var.enable_coverage && !var.enable_matrix && contains(var.languages, "javascript") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-javascript.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-javascript-single.yml.tmpl", {
      default_version = lookup(var.language_default_versions, "javascript", "")
    }
  )
  commit_message      = "ci: add JS test workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_javascript_matrix" {
  count = var.enable_coverage && var.enable_matrix && contains(var.languages, "javascript") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-javascript-matrix.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-javascript-matrix.yml.tmpl", {
      matrix_versions = var.language_matrix_versions["javascript"]
    }
  )
  commit_message      = "ci: add JS test matrix workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_typescript_single" {
  count = var.enable_coverage && !var.enable_matrix && contains(var.languages, "typescript") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-typescript.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-typescript-single.yml.tmpl", {
      default_version = lookup(var.language_default_versions, "typescript", "")
    }
  )
  commit_message      = "ci: add TS test workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "test_typescript_matrix" {
  count = var.enable_coverage && var.enable_matrix && contains(var.languages, "typescript") ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/test-typescript-matrix.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/test-typescript-matrix.yml.tmpl", {
      matrix_versions = var.language_matrix_versions["typescript"]
    }
  )
  commit_message      = "ci: add TS test matrix workflow"
  overwrite_on_create = true
}

// Manage Terraform docs regeneration workflow
resource "github_repository_file" "docs_workflow" {
  count = var.enforce_docs ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/docs.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/docs.yml.tmpl", {}
  )
  commit_message      = "ci: add docs regeneration workflow"
  overwrite_on_create = true
}

// Manage coverage-to-wiki workflow
resource "github_repository_file" "coverage_to_wiki" {
  count = var.enable_coverage ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/coverage-to-wiki.yml"
  content             = templatefile(
    "${path.module}/templates/.github/workflows/coverage-to-wiki.yml.tmpl", {}
  )
  commit_message      = "ci: add coverage-to-wiki workflow"
  overwrite_on_create = true
}