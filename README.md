# terraform-github-repo

[![Terraform Registry](https://img.shields.io/badge/Terraform%20Registry-Published-blue?logo=terraform)](https://registry.terraform.io/modules/kpeacocke/github-repo/github)
[![CI](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/test.yml/badge.svg)](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/test.yml)
[![Release](https://img.shields.io/badge/release-automated-blue.svg?logo=semantic-release)](https://github.com/kpeacocke/terraform-github-repo/releases)
[![Test Coverage](https://github.com/kpeacocke/terraform-github-repo/wiki/coverage.svg)](https://raw.githack.com/wiki/kpeacocke/terraform-github-repo/coverage.html)

A reusable module for enforcing GitHub repository best practices via Terraform.

## Usage

```hcl
module "repo" {
  source  = "your-org/github-repo/github"
  version = "1.0.0"

  name                      = "my-repo"
  owners                    = ["my-org/team"]
  enforce_gitflow           = true
  enforce_security          = true
  enforce_tests             = true
  enforce_docs              = true
  enforce_issue_integration = true
  enforce_branch_naming     = true
  bootstrap_with_templates  = true
  enforce_traceability      = true
}
```

---

## 📚 Features

- ✅ GitFlow branch naming and protection
- ✅ CodeQL & Dependabot security automation
- ✅ PR-to-Issue linking enforcement
- ✅ Test presence enforcement on PRs
- ✅ Modular toggles for enforcement rules
- ✅ Bootstrap standard docs (README, LICENSE, SECURITY.md)
- ✅ Automated releases & changelogs
- ✅ Branch naming pattern enforcement
- ✅ Requirements traceability enforcement

---

## 🔐 CodeQL Configuration

CodeQL is automatically configured when `enforce_security = true`. Supported languages include:

- JavaScript/TypeScript
- Python
- Go
- Java
- Ruby
- C#
- C/C++
- Kotlin
- PHP
- Swift
- Rust
- Perl
- R
- HCL (Terraform)

Only languages listed in the `languages` variable are scanned. This ensures minimal setup and performance impact.

To enable scanning:

```hcl
languages = ["python", "go"]
```

The generated GitHub Action will dynamically configure `codeql.yml` based on these settings.

---

## 📦 Alternative Install (non-registry)

```hcl
module "repo" {
  source = "git::https://github.com/your-org/github-repo-module.git//modules/github-repo?ref=v1.0.0"

  name                     = "my-repo"
  owner                    = "your-org"
  visibility               = "private"

  enforce_gitflow          = true
  enforce_tests            = true
  enforce_security         = true
  enforce_docs             = true
  bootstrap_with_templates = true
}
```

---

## 🔧 Inputs

<!-- BEGIN_TF_DOCS:inputs -->
<!-- END_TF_DOCS:inputs -->

---

## 📤 Outputs

<!-- BEGIN_TF_DOCS:outputs -->
<!-- END_TF_DOCS:outputs -->

---

## 🧪 Testing

### Run Terratest locally

```bash
task test
```

Tests live in `test/` and use fixtures from `test/fixtures/`.

> Requires `GITHUB_TOKEN` to be set in your `.env` or terminal.

---

## 💡 Contributing

### 1. Setup

```bash
npm install        # Installs Husky + commitlint
task husky         # (optional) sets up hooks manually
```

### 2. Commit Convention

Commits must follow [Conventional Commits](https://www.conventionalcommits.org/):

Examples:

```bash
git commit -m "feat: add issue reference enforcement"
git commit -m "fix: correct visibility output name"
```

Husky will block non-conforming messages.

---

## 🚀 Automated Releases

Merges into `main` trigger:

- Changelog updates (`CHANGELOG.md`)
- Git tag bumps (e.g. `v1.2.0`)
- GitHub Releases

Powered by [semantic-release](https://github.com/semantic-release/semantic-release).

---

## 🗂️ GitHub Project Board Integration

If `enforce_project_board` is enabled, your repository must define the following:

| Requirement           | Description                                                                 |
|-----------------------|-----------------------------------------------------------------------------|
| `github_project_url`  | Must be set via Terraform to the full URL of the GitHub Project board.     |

> Example value:
> `https://github.com/orgs/YOUR_ORG/projects/1/views/2`

Terraform will inject this value into the GitHub Actions workflow when enabled.

## 📎 Requirements Traceability

If `enforce_traceability` is enabled, this module includes a GitHub Actions workflow that ensures all pull requests are traceable to documented requirements.

The traceability is enforced through:

- Presence of requirement IDs in PR titles or descriptions
- Required `requirements.yml` or similar structured documentation
- Automated checks via `traceability.yml` workflow

## 📜 License

[MIT](LICENSE)
