# Wait for GitHub repo to be available before setting Actions permissions
resource "null_resource" "wait_for_github_repo" {
  provisioner "local-exec" {
    command     = <<EOT
      for i in {1..60}; do
        # Poll the Actions permissions endpoint directly
        status=$(curl -s -o /dev/null -w "%%{http_code}" \
          -H "Authorization: token ${var.github_token}" \
          "https://api.github.com/repos/${var.github_owner}/${github_repository.this.name}/actions/permissions")
        if [ "$status" = "200" ]; then
          echo "Actions permissions endpoint is available."
          exit 0
        fi
        echo "Waiting for Actions permissions endpoint... ($i/30, status: $status)"
        sleep 5
      done
      echo "Actions permissions endpoint not available after waiting."
      exit 1
    EOT
    interpreter = ["/bin/bash", "-c"]
    environment = {
      github_token = var.github_token
      github_owner = var.github_owner
    }
  }
  triggers = {
    repo_name = github_repository.this.name
  }
  depends_on = [github_repository.this]
}
locals {
  _validate_owners = length(var.owners) > 0 ? true : throw("Missing required variable 'owners'")
}
# Auto-approve and auto-merge Dependabot PRs workflow
resource "github_repository_file" "auto_approve_dependabot" {
  count               = var.disable_actions_until_provisioning ? 0 : (var.enable_dependabot && var.enable_dependabot_autoapprove ? 1 : 0)
  repository          = github_repository.this.name
  branch              = var.branch
  file                = ".github/workflows/auto-approve-dependabot.yml"
  content             = file("${path.module}/templates/.github/workflows/auto-approve-dependabot.yml.tmpl")
  commit_message      = "ci: add auto-approve and auto-merge for Dependabot PRs"
  overwrite_on_create = true
}
resource "github_repository" "this" {
  name = var.name
  # owner argument removed; repository will use provider's configured owner
  description      = "Managed by Terraform"
  visibility       = var.visibility
  auto_init        = true
  has_issues       = true
  has_projects     = true
  has_wiki         = false
  allow_auto_merge = var.allow_auto_merge
}

resource "github_actions_repository_permissions" "repo_perms" {
  count      = var.disable_actions_until_provisioning ? 0 : 1
  repository = github_repository.this.name
  # disable external Actions runs until provisioning is complete (allow only local actions when disabled)
  # Toggle Actions runs: local_only to disable external actions, all to enable
  allowed_actions = var.disable_actions_until_provisioning ? "local_only" : "all"
  depends_on      = [github_repository.this, null_resource.wait_for_github_repo]
}

# --- CI Enforcement: Placeholder for validating issues, docs, tests ---
# (null_resource removed, logic now handled by workflows and branch protection)

# --- Security: CodeQL and Dependabot ---
resource "github_repository_file" "codeql_workflow" {
  count      = var.disable_actions_until_provisioning ? 0 : (var.enable_codeql && length(var.languages) > 0 ? 1 : 0)
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/workflows/codeql.yml"
  content = templatefile(
    "${path.module}/templates/.github/workflows/codeql.yml.tmpl", {
      languages = [for lang in var.languages : lower(trimspace(lang))]
    }
  )
  commit_message      = "ci: add CodeQL workflow"
  overwrite_on_create = true
}

resource "github_repository_file" "dependabot" {
  count      = var.disable_actions_until_provisioning ? 0 : (var.enable_dependabot ? 1 : 0)
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/dependabot.yml"
  content = templatefile(
    "${path.module}/templates/.github/workflows/dependabot.yml.tmpl", {
      enable_automerge_minor = var.enable_dependabot_automerge_minor
    }
  )
  commit_message      = "chore: add Dependabot config"
  overwrite_on_create = true
}


# Issue integration, doc enforcement, test checks


# CI enforcement workflow
resource "github_repository_file" "ci_enforcement_workflow" {
  # Always include CI enforcement workflow when CI is enabled
  count = var.enable_ci ? 1 : 0

  repository = github_repository.this.name
  branch     = "main"
  file       = ".github/workflows/ci-enforcement.yml"
  content = templatefile(
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


resource "github_repository_file" "traceability" {
  count = var.traceability_enabled ? 1 : 0

  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/traceability.yml"
  content             = templatefile("${path.module}/templates/.github/workflows/traceability.yml.tmpl", {})
  commit_message      = "chore: add traceability enforcement workflow"
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


// --- Bootstrap: Standard repository files ---
resource "github_repository_file" "editorconfig" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".editorconfig"
  content = templatefile(
    "${path.module}/templates/.editorconfig.tmpl", {}
  )
  commit_message      = "chore: add editorconfig"
  overwrite_on_create = true
}

resource "github_repository_file" "nvmrc" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".nvmrc"
  content = templatefile(
    "${path.module}/templates/.nvmrc.tmpl", {}
  )
  commit_message      = "chore: add Node.js version lock"
  overwrite_on_create = true
}

resource "github_repository_file" "gitignore" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".gitignore"
  content = templatefile(
    "${path.module}/templates/gitignore.tmpl", {
      languages = var.languages
    }
  )
  commit_message      = "chore: add .gitignore"
  overwrite_on_create = true
}

resource "github_repository_file" "contributing" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = "CONTRIBUTING.md"
  content = templatefile(
    "${path.module}/templates/CONTRIBUTING.md.tmpl", {}
  )
  commit_message      = "docs: add contributing guide"
  overwrite_on_create = true
}

resource "github_repository_file" "pull_request_template" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/PULL_REQUEST_TEMPLATE.md"
  content = templatefile(
    "${path.module}/templates/.github/PULL_REQUEST_TEMPLATE.md.tmpl", {}
  )
  commit_message      = "docs: add PR template"
  overwrite_on_create = true
}

resource "github_repository_file" "issue_template_bug" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/ISSUE_TEMPLATE/bug_report.yml"
  content = templatefile(
    "${path.module}/templates/.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE_bug_report.yml.tmpl", {}
  )
  commit_message      = "docs: add bug report issue template"
  overwrite_on_create = true
}

resource "github_repository_file" "issue_template_feature" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/ISSUE_TEMPLATE/feature_request.yml"
  content = templatefile(
    "${path.module}/templates/.github/ISSUE_TEMPLATE/ISSUE_TEMPLATE_feature_request.yml.tmpl", {}
  )
  commit_message      = "docs: add feature request issue template"
  overwrite_on_create = true
}

resource "github_repository_file" "codeowners" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = ".github/CODEOWNERS"
  # Render CODEOWNERS from template and append explicit owners line for visibility
  content = format(
    "%s\n%s",
    templatefile("${path.module}/templates/CODEOWNERS.tmpl", { owners = var.owners }),
    join("\n", var.owners)
  )
  commit_message      = "chore: add CODEOWNERS"
  overwrite_on_create = true
}

resource "github_repository_file" "license" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = "LICENSE"
  content = templatefile(
    "${path.module}/templates/LICENSE.${var.license}.tmpl", {}
  )
  commit_message      = "chore: add LICENSE (${var.license})"
  overwrite_on_create = true
}

resource "github_repository_file" "readme" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = "README.md"
  content = templatefile(
    "${path.module}/templates/README.md.tmpl", {
      repo_name                 = github_repository.this.name,
      owner                     = var.owners[0],
      license                   = var.license,
      enable_ci                 = false,
      enable_release            = false,
      enable_weekly_reporting   = false,
      enable_coverage           = false,
      enforce_gitflow           = false,
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
  repository = github_repository.this.name
  branch     = var.branch
  file       = "SECURITY.md"
  content = templatefile(
    "${path.module}/templates/SECURITY.md.tmpl", {
      security_contact = var.security_contact,
      owner            = var.owners[0],
      repo_name        = github_repository.this.name
    }
  )
  commit_message      = "docs: add SECURITY policy"
  overwrite_on_create = true
}

resource "github_repository_file" "changelog" {
  repository = github_repository.this.name
  branch     = var.branch
  file       = "CHANGELOG.md"
  content = templatefile(
    "${path.module}/templates/CHANGELOG.md.tmpl", {}
  )
  commit_message      = "docs: add CHANGELOG"
  overwrite_on_create = true
}

resource "github_repository_file" "release_config" {
  repository          = github_repository.this.name
  branch              = var.branch
  file                = "release.config.js"
  content             = file("${path.module}/release.config.js")
  commit_message      = "chore: add semantic-release config"
  overwrite_on_create = true
}

// Barrier to wait for all initial files
resource "null_resource" "files_created" {
  depends_on = [
    github_repository_file.auto_approve_dependabot,
    github_repository_file.codeql_workflow,
    github_repository_file.dependabot,
    github_repository_file.ci_enforcement_workflow,
    github_repository_file.stale,
    github_repository_file.scorecard,
    github_repository_file.traceability,
    github_repository_file.build,
    github_repository_file.release,
    github_repository_file.editorconfig,
    github_repository_file.nvmrc,
    github_repository_file.gitignore,
    github_repository_file.contributing,
    github_repository_file.pull_request_template,
    github_repository_file.issue_template_bug,
    github_repository_file.issue_template_feature,
    github_repository_file.codeowners,
    github_repository_file.license,
    github_repository_file.readme,
    github_repository_file.security,
    github_repository_file.changelog,
    github_repository_file.release_config
  ]
}

resource "github_branch_protection" "release" {
  # ensure files are all created first
  depends_on     = [null_resource.files_created]
  count          = var.enforce_gitflow ? length(var.release_branches) : 0
  repository_id  = github_repository.this.node_id
  pattern        = var.release_branches[count.index]
  enforce_admins = true
  required_status_checks {
    strict   = true
    contexts = var.status_check_contexts
  }
  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    require_code_owner_reviews      = true
    required_approving_review_count = 1
  }
}