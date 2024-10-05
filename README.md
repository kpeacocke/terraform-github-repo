# terraform-github-repo

Terraform module for enforcing best practices on GitHub repositories.

## 📦 Features

- ☑️ GitFlow branch protection
- ☑️ Semantic PR title enforcement
- ☑️ Branch naming conventions
- ☑️ CodeQL security scanning
- ☑️ Test coverage enforcement
- ☑️ Issue and PR integration with Projects
- ☑️ Template bootstrapping (README, LICENSE, etc.)
- ☑️ Dependabot configuration
- ☑️ Requirements traceability enforcement
- ☑️ Auto-labeling and project board linking
- ☑️ Security features (secret scanning, push protection, Dependabot alerts)
- ☑️ **Auto-approve and auto-merge Dependabot PRs**

## 🚀 Usage

```hcl
module "github_repo" {
  source = "github.com/your-org/terraform-github-repo"

  name        = "my-repo"
  owners      = ["your-org"]
  visibility  = "private"
  license     = "MIT"
  languages   = ["go", "python"]

  enforce_gitflow           = true
  enforce_tests             = true
  enforce_security          = true
  enforce_docs              = true
  enforce_issue_integration = true
  enforce_project_board     = false
  traceability_enabled      = false
  enable_weekly_reporting   = false
  enable_codeql             = true
  enable_dependabot         = true
  enable_secret_scanning    = true
  enable_secret_scanning_push_protection = true
  enable_dependabot_alerts  = true
  enable_dependabot_security_updates = true
  require_codeql_workflow   = true
  allow_auto_merge          = true
  enable_dependabot_automerge_minor = true
  enable_dependabot_autoapprove = true
}
```

See [`variables.tf`](./variables.tf) for all available options.

## 🧪 Local Testing

Run Terratest from the root:

```bash
task test
```

> Requires valid `GITHUB_TOKEN` exported in your terminal or `.env`.

## 📜 License

[MIT](LICENSE)
