# 📦 GitHub Repository Terraform Module

Terraform module to provision GitHub repositories with enforced best practices, automation policies, and security controls.

[![CI](https://github.com/your-org/github-repo-module/actions/workflows/test.yml/badge.svg)](https://github.com/your-org/github-repo-module/actions/workflows/test.yml)
[![Release](https://img.shields.io/badge/release-automated-blue.svg?logo=semantic-release)](https://github.com/semantic-release/semantic-release)

---

## 📚 Features

- ✅ GitFlow branch naming and protection
- ✅ CodeQL & Dependabot security automation
- ✅ PR-to-Issue linking enforcement
- ✅ Test presence enforcement on PRs
- ✅ Modular toggles for enforcement rules
- ✅ Bootstrap standard docs (README, LICENSE, SECURITY.md)
- ✅ Automated releases & changelogs

---

## 🚀 Usage

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

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `name` | Repository name | `string` | — |
| `owner` | GitHub user/org | `string` | — |
| `visibility` | `private` or `public` | `string` | `"private"` |
| `enforce_gitflow` | Enforce branch naming + protection | `bool` | `false` |
| `enforce_tests` | Require test changes in PRs | `bool` | `false` |
| `enforce_security` | Enable CodeQL + Dependabot | `bool` | `false` |
| `enforce_docs` | Require docs updates | `bool` | `false` |
| `bootstrap_with_templates` | Add default files | `bool` | `true` |
| `enforce_issue_integration` | Require PRs to reference issues | `bool` | `false` |
| `enforce_project_board` | Enable project linking | `bool` | `false` |
| `traceability_enabled` | Enforce requirements traceability | `bool` | `false` |
| `enable_weekly_reporting` | Adds scorecard, stale bot, etc. | `bool` | `false` |

---

## 📤 Outputs

| Name | Description |
|------|-------------|
| `repository_name` | The name of the created repository |
| `repository_full_name` | Full name including org/user |
| `repository_url` | Repository HTTPS URL |

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

## 📜 License

[MIT](LICENSE)
