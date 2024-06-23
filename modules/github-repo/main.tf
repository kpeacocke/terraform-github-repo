
resource "github_repository" "this" {
  name         = var.name
  visibility   = var.visibility
  description  = "Managed by Terraform."
  auto_init    = true
  has_issues   = true
  has_wiki     = true
  has_projects = true
}

resource "github_repository_file" "bootstrap_docs" {
  for_each = var.bootstrap_with_templates ? {
    "README.md"         = "# ${var.name}\n\nProject initialized via Terraform."
    "LICENSE"           = "MIT License"
    "SECURITY.md"       = "# Security Policy\n\nPlease report vulnerabilities..."
    "CONTRIBUTING.md"   = "# Contributing\n\nHow to contribute to this project."
    "CODE_OF_CONDUCT.md" = "# Code of Conduct\n\nBe excellent to each other."
  } : {}

  repository          = github_repository.this.name
  file                = each.key
  content             = each.value
  overwrite_on_create = true
  commit_message      = "Add ${each.key} via Terraform bootstrap"
}

resource "github_repository_file" "gitignore_file" {
  count      = var.bootstrap_with_templates ? 1 : 0
  repository = github_repository.this.name
  file       = ".gitignore"
  content    = <<-EOT
    # === Terraform ===
    *.tfstate
    *.tfstate.*
    .terraform/
    .terraform.lock.hcl
    crash.log
    *.backup

    # === Terratest / Test Artifacts ===
    *.out
    *.test
    *.log
    test/__pycache__/
    test/tmp/
    test/fixtures/.terraform/

    # === VSCode / IDEs ===
    .vscode/
    .idea/
    *.swp

    # === OS Artifacts ===
    .DS_Store
    Thumbs.db

    # === Go ===
    vendor/
    *.exe
    *.exe~
    *.dll
    *.so
    *.dylib
    *.test
    *.tmp
    *.coverprofile
    *.log
    *.mod
    *.sum

    # === Node (if used for scripts) ===
    node_modules/
    npm-debug.log*
    yarn-debug.log*
    yarn-error.log*

    # === GitHub Actions artifacts ===
    .github/workflows/.DS_Store

    # === Local credentials or environment ===
    .env
    .env.*
    *.env.local
    .envrc

    # === Test binary ===
    test/bin/
  EOT
  overwrite_on_create = true
  commit_message      = "Add .gitignore for Terraform + testing"
}

resource "github_branch_protection" "main" {
  count = var.enforce_gitflow ? 1 : 0

  repository_id = github_repository.this.node_id
  pattern       = "main"

  required_status_checks {
    strict   = true
    contexts = []
  }

  enforce_admins = true

  required_pull_request_reviews {
    dismiss_stale_reviews           = true
    required_approving_review_count = 1
  }


  require_signed_commits = true
  allows_deletions       = false
  allows_force_pushes    = false
}

resource "github_repository_file" "branch_naming_action" {
  count      = var.enforce_gitflow ? 1 : 0
  repository = github_repository.this.name
  file       = ".github/workflows/enforce-branch-naming.yml"
  content    = <<-EOT
    name: Enforce Branch Naming

    on:
      pull_request:
        types: [opened, edited, reopened]

    jobs:
      check-branch-name:
        runs-on: ubuntu-latest
        steps:
          - name: Validate branch name
            run: |
              BRANCH_NAME="$${{ github.head_ref }}"
              if [[ ! $BRANCH_NAME =~ ^(feature|bugfix|hotfix|release)/.*$ ]]; then
                echo "Branch name '$BRANCH_NAME' does not follow GitFlow naming conventions."
                exit 1
              fi
  EOT
  overwrite_on_create = true
  commit_message      = "Add GitFlow branch naming enforcement"
}

resource "github_repository_file" "test_enforcement_action" {
  count      = var.enforce_tests ? 1 : 0
  repository = github_repository.this.name
  file       = ".github/workflows/enforce-tests.yml"
  content    = <<-EOT
    name: Enforce Test Presence

    on:
      pull_request:
        types: [opened, synchronize, reopened]

    jobs:
      check-tests:
        runs-on: ubuntu-latest
        steps:
          - name: Checkout code
            uses: actions/checkout@v3

          - name: Check for test changes
            run: |
              git fetch origin main
              git diff --name-only origin/main...HEAD | grep -E 'test|spec' || {
                echo "No test files added or changed. PR must include test coverage." >&2
                exit 1
              }
  EOT
  overwrite_on_create = true
  commit_message      = "Add test enforcement workflow"
}

resource "github_repository_file" "codeql_action" {
  count      = var.enforce_security ? 1 : 0
  repository = github_repository.this.name
  file       = ".github/workflows/codeql-analysis.yml"
  content    = <<-EOT
    name: CodeQL

    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]
      schedule:
        - cron: '0 0 * * 0'

    jobs:
      analyze:
        name: Analyze
        runs-on: ubuntu-latest

        permissions:
          actions: read
          contents: read
          security-events: write

        strategy:
          fail-fast: false
          matrix:
            language: [ 'javascript', 'python' ]

        steps:
          - name: Checkout repository
            uses: actions/checkout@v3

          - name: Initialize CodeQL
            uses: github/codeql-action/init@v2
            with:
              languages: $${{ matrix.language }}

          - name: Autobuild
            uses: github/codeql-action/autobuild@v2

          - name: Perform CodeQL Analysis
            uses: github/codeql-action/analyze@v2
  EOT
  overwrite_on_create = true
  commit_message      = "Add CodeQL analysis workflow"
}


resource "github_repository_file" "issue_reference_enforcement" {
  count      = var.enforce_issue_integration ? 1 : 0
  repository = github_repository.this.name
  file       = ".github/workflows/require-issue-reference.yml"
  content    = <<-EOT
    name: Require Issue Reference

    on:
      pull_request:
        types: [opened, edited, reopened, synchronize]

    jobs:
      check-issue-reference:
        runs-on: ubuntu-latest
        steps:
          - name: Ensure PR has linked issue
            run: |
              TITLE="$${{ github.event.pull_request.title }}"
              BODY="$${{ github.event.pull_request.body }}"
              if [[ "$TITLE" != *#* ]] && [[ "$BODY" != *#* ]]; then
                echo "PR must reference an issue using #<number>." >&2
                exit 1
              fi
  EOT
  overwrite_on_create = true
  commit_message      = "Add PR issue reference enforcement workflow"
}
