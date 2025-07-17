
# terraform-github-repo

**Comprehensive Terraform module for enforcing GitHub repository best practices and security standards.**

[![Terraform Registry](https://img.shields.io/badge/registry-terraform--registry-623CE4?logo=terraform&logoColor=white)](https://registry.terraform.io/modules/kpeacocke/terraform-github-repo/latest)
[![Module Version](https://img.shields.io/github/v/release/kpeacocke/terraform-github-repo?label=version&logo=terraform&color=623CE4)](https://github.com/kpeacocke/terraform-github-repo/releases)
[![Downloads](https://img.shields.io/static/v1?label=downloads&message=1k%2B&color=623CE4&logo=terraform&logoColor=white)](https://registry.terraform.io/modules/kpeacocke/terraform-github-repo/latest)
[![CI](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/ci.yml/badge.svg)](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/ci.yml)
[![CodeQL](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/codeql.yml/badge.svg)](https://github.com/kpeacocke/terraform-github-repo/actions/workflows/codeql.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub Stars](https://img.shields.io/github/stars/kpeacocke/terraform-github-repo?style=social)](https://github.com/kpeacocke/terraform-github-repo)

---

## Quick Links

- 📖 [Terraform Registry](https://registry.terraform.io/modules/kpeacocke/terraform-github-repo/latest)  
  Official module page with usage examples
- 🚀 [Getting Started Guide](#-usage)  
  Jump to basic usage examples
- 📋 [Examples](./examples)  
  Complete real-world usage scenarios
- 🔐 [Security Features](#%EF%B8%8F-compliance-guardrails--policy-enforcement)  
  Security scanning and compliance
- 🧪 [Testing Guide](#-local-testing)  
  How to test the module locally
- 📝 [Contributing](./CONTRIBUTING.md)  
  How to contribute to this project
- 🐛 [Issues](https://github.com/kpeacocke/terraform-github-repo/issues)  
  Report bugs or request features
- 💬 [Discussions](https://github.com/kpeacocke/terraform-github-repo/discussions)  
  Community support and Q&A
- 📝 [Contributing](./CONTRIBUTING.md)  
  How to contribute to this project
- 🐛 [Issues](https://github.com/kpeacocke/terraform-github-repo/issues)  
  Report bugs or request features
- 💬 [Discussions](https://github.com/kpeacocke/terraform-github-repo/discussions)  
  Community support and Q&A

---

## 🎯 Overview

This Terraform module provides a **production-ready**, **security-first** approach to managing GitHub repositories
with comprehensive governance, compliance, and DevSecOps automation.

**Perfect for:** Organizations requiring standardized repository governance, security compliance (SOC2, ISO27001),  
and automated DevOps workflows.

### 🏷️ Keywords

`terraform` • `github` • `devops` • `security` • `compliance` • `governance` • `devsecops`  
`repository-management` • `gitops` • `automation` • `best-practices` • `branch-protection`  
`codeql` • `dependabot`

### Module Features

This module provides comprehensive GitHub repository configuration with focus on security and best practices.

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

## 👨‍💻 Development

This repository includes a comprehensive set of guidance for developers:

- 🔑 [**Security Credentials Guide**](./docs/development/security-credentials.md)  
  Important guidance on handling credentials securely
- 📗 [**Contributing Guide**](./CONTRIBUTING.md) - How to contribute to this project
- 🧪 [**Testing Guide**](./docs/development/testing.md) - How to run tests locally

## 🔧 Requirements

| Name      | Version |
|-----------|---------|
| terraform | >= 1.5.0 |
| github provider | >= 6.0 |

## 🛠 Providers

| Name   | Source                | Version |
|--------|-----------------------|---------|
| github | integrations/github   | ~> 6.0  |

## ⚠️ Default: GitHub Actions Disabled Until Provisioning

By default, this module disables GitHub Actions workflows for new repositories until provisioning is complete.
This prevents excessive notification emails and failed workflow runs during initial setup.

To enable Actions after provisioning, set the variable  
`disable_actions_until_provisioning = false`  
in your environment or Terraform configuration:

```hcl
module "github_repo" {
  source = "..."
  # ... other variables ...
  disable_actions_until_provisioning = false
}
```

If you are bootstrapping a new environment, keep Actions disabled until all resources are provisioned.
Then re-apply with Actions enabled.

## 🚀 Usage

### Backend Configuration

Recommend using a local backend in your root Terraform configuration:

```hcl
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
```

### Module Call

```hcl
module "github_repo" {
  source = "github.com/kpeacocke/terraform-github-repo"

  name        = "my-repo"
  owners      = ["kpeacocke"]
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

## 📝 Examples

See the [examples](./examples) directory for complete usage scenarios.

<!-- markdownlint-disable MD033 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 6.6 |
| <a name="requirement_null"></a> [null](#requirement\_null) | ~> 3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 6.6 |
| <a name="provider_null"></a> [null](#provider\_null) | ~> 3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_actions_repository_permissions.repo_perms](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/actions_repository_permissions) | resource |
| [github_branch_protection.release](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [github_repository_file.auto_approve_dependabot](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.build](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.changelog](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.ci_enforcement_workflow](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.codeowners](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.codeql_workflow](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.contributing](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.dependabot](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.editorconfig](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.gitignore](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.issue_template_bug](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.issue_template_feature](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.license](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.nvmrc](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.pull_request_template](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.readme](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.release](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.release_config](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.scorecard](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.security](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.stale](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.traceability](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [null_resource.files_created](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.mute_notifications](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.wait_for_github_repo](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_auto_merge"></a> [allow\_auto\_merge](#input\_allow\_auto\_merge) | Allow auto-merge for pull requests (including Dependabot). | `bool` | `true` | no |
| <a name="input_bootstrap_with_templates"></a> [bootstrap\_with\_templates](#input\_bootstrap\_with\_templates) | If true, initialize the repo with standard files like README.md, LICENSE, SECURITY.md. | `bool` | `true` | no |
| <a name="input_branch"></a> [branch](#input\_branch) | The branch to commit files to. | `string` | `"main"` | no |
| <a name="input_coverage_threshold"></a> [coverage\_threshold](#input\_coverage\_threshold) | Minimum coverage threshold to enforce (as percentage) | `number` | `80` | no |
| <a name="input_disable_actions_until_provisioning"></a> [disable\_actions\_until\_provisioning](#input\_disable\_actions\_until\_provisioning) | Disable GitHub Actions workflows until provisioning is complete to avoid failure notifications and excess emails. Default: true. Set to false to enable Actions after provisioning. | `bool` | `true` | no |
| <a name="input_enable_auto_labeling"></a> [enable\_auto\_labeling](#input\_enable\_auto\_labeling) | If true, automatically labels PRs and issues based on file paths or content. | `bool` | `false` | no |
| <a name="input_enable_ci"></a> [enable\_ci](#input\_enable\_ci) | If true, adds build/test workflow for CI validation. | `bool` | `true` | no |
| <a name="input_enable_codeql"></a> [enable\_codeql](#input\_enable\_codeql) | Enable CodeQL analysis workflow. | `bool` | `true` | no |
| <a name="input_enable_coverage"></a> [enable\_coverage](#input\_enable\_coverage) | Enable test coverage reporting | `bool` | `false` | no |
| <a name="input_enable_dependabot"></a> [enable\_dependabot](#input\_enable\_dependabot) | Enable Dependabot configuration and workflows. | `bool` | `true` | no |
| <a name="input_enable_dependabot_alerts"></a> [enable\_dependabot\_alerts](#input\_enable\_dependabot\_alerts) | Enable Dependabot alerts for the repository via workflow. | `bool` | `true` | no |
| <a name="input_enable_dependabot_autoapprove"></a> [enable\_dependabot\_autoapprove](#input\_enable\_dependabot\_autoapprove) | Enable workflow to auto-approve and auto-merge Dependabot PRs. | `bool` | `true` | no |
| <a name="input_enable_dependabot_automerge_minor"></a> [enable\_dependabot\_automerge\_minor](#input\_enable\_dependabot\_automerge\_minor) | Enable Dependabot auto-merge for minor upgrades. | `bool` | `true` | no |
| <a name="input_enable_dependabot_security_updates"></a> [enable\_dependabot\_security\_updates](#input\_enable\_dependabot\_security\_updates) | Enable Dependabot security updates for the repository via workflow. | `bool` | `true` | no |
| <a name="input_enable_matrix"></a> [enable\_matrix](#input\_enable\_matrix) | If true, use a version matrix for test workflows | `bool` | `false` | no |
| <a name="input_enable_release"></a> [enable\_release](#input\_enable\_release) | If true, adds semantic-release GitHub workflow. | `bool` | `true` | no |
| <a name="input_enable_secret_scanning"></a> [enable\_secret\_scanning](#input\_enable\_secret\_scanning) | Enable secret scanning for the repository via workflow. | `bool` | `true` | no |
| <a name="input_enable_secret_scanning_push_protection"></a> [enable\_secret\_scanning\_push\_protection](#input\_enable\_secret\_scanning\_push\_protection) | Enable secret scanning push protection for the repository via workflow. | `bool` | `true` | no |
| <a name="input_enable_weekly_reporting"></a> [enable\_weekly\_reporting](#input\_enable\_weekly\_reporting) | If true, adds stale issue management and OpenSSF Scorecard workflows. | `bool` | `false` | no |
| <a name="input_enforce_branch_naming"></a> [enforce\_branch\_naming](#input\_enforce\_branch\_naming) | If true, enables branch naming convention enforcement (e.g. feature/*) | `bool` | `false` | no |
| <a name="input_enforce_docs"></a> [enforce\_docs](#input\_enforce\_docs) | If true, enforce documentation updates in PRs. | `bool` | `false` | no |
| <a name="input_enforce_gitflow"></a> [enforce\_gitflow](#input\_enforce\_gitflow) | Whether to enforce GitFlow naming and branch protection rules. | `bool` | `true` | no |
| <a name="input_enforce_issue_integration"></a> [enforce\_issue\_integration](#input\_enforce\_issue\_integration) | If true, enforce that PRs are linked to issues. | `bool` | `false` | no |
| <a name="input_enforce_project_board"></a> [enforce\_project\_board](#input\_enforce\_project\_board) | If true, link issues and PRs to a GitHub project board. | `bool` | `false` | no |
| <a name="input_enforce_security"></a> [enforce\_security](#input\_enforce\_security) | Enable security tools such as CodeQL scanning and Dependabot alerts. | `bool` | `false` | no |
| <a name="input_enforce_semantic_pr_title"></a> [enforce\_semantic\_pr\_title](#input\_enforce\_semantic\_pr\_title) | If true, enforces semantic PR titles via GitHub Actions | `bool` | `false` | no |
| <a name="input_enforce_tests"></a> [enforce\_tests](#input\_enforce\_tests) | If true, enforce test updates in PRs. | `bool` | `false` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | GitHub owner (user or org) for API access (used in provisioning wait step) | `string` | n/a | yes |
| <a name="input_github_project_url"></a> [github\_project\_url](#input\_github\_project\_url) | The full URL of the GitHub project to attach issues/PRs to. | `string` | `""` | no |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token for API access (used in provisioning wait step) | `string` | n/a | yes |
| <a name="input_language_default_versions"></a> [language\_default\_versions](#input\_language\_default\_versions) | Map of default single-version values for each language | `map(string)` | <pre>{<br/>  "go": "1.21",<br/>  "javascript": "20",<br/>  "python": "3.11",<br/>  "typescript": "20"<br/>}</pre> | no |
| <a name="input_language_matrix_versions"></a> [language\_matrix\_versions](#input\_language\_matrix\_versions) | Map of version lists for matrix testing per language | `map(list(string))` | <pre>{<br/>  "go": [<br/>    "1.20",<br/>    "1.21",<br/>    "1.22"<br/>  ],<br/>  "javascript": [<br/>    "16",<br/>    "18",<br/>    "20"<br/>  ],<br/>  "python": [<br/>    "3.9",<br/>    "3.10",<br/>    "3.11"<br/>  ],<br/>  "typescript": [<br/>    "4.5",<br/>    "4.6",<br/>    "4.7"<br/>  ]<br/>}</pre> | no |
| <a name="input_languages"></a> [languages](#input\_languages) | List of languages for CodeQL analysis and templates. | `list(string)` | `[]` | no |
| <a name="input_license"></a> [license](#input\_license) | The open source license to apply (MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0). | `string` | `"MIT"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the GitHub repository to create. | `string` | n/a | yes |
| <a name="input_owners"></a> [owners](#input\_owners) | List of GitHub users or teams who should be set as CODEOWNERS. | `list(string)` | n/a | yes |
| <a name="input_release_branches"></a> [release\_branches](#input\_release\_branches) | List of branch patterns to apply branch protection rules (e.g. ["main", "release/*"]). | `list(string)` | <pre>[<br/>  "main"<br/>]</pre> | no |
| <a name="input_require_codeql_workflow"></a> [require\_codeql\_workflow](#input\_require\_codeql\_workflow) | Require that the CodeQL workflow exists in the repository. | `bool` | `true` | no |
| <a name="input_security_contact"></a> [security\_contact](#input\_security\_contact) | Email or contact address to report security issues. | `string` | `"security@kpeacocke.com"` | no |
| <a name="input_status_check_contexts"></a> [status\_check\_contexts](#input\_status\_check\_contexts) | List of status check contexts required for branch protection. | `list(string)` | `[]` | no |
| <a name="input_traceability_enabled"></a> [traceability\_enabled](#input\_traceability\_enabled) | Enable traceability enforcement such as issue states, assignments, or labels. | `bool` | `false` | no |
| <a name="input_visibility"></a> [visibility](#input\_visibility) | Whether the repository should be 'private' or 'public'. | `string` | `"private"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_branch_protection_enforcement"></a> [branch\_protection\_enforcement](#output\_branch\_protection\_enforcement) | Map of branch patterns to admin enforcement status. |
| <a name="output_branch_protection_patterns"></a> [branch\_protection\_patterns](#output\_branch\_protection\_patterns) | List of protected branch patterns and their status. |
| <a name="output_branch_protection_rule_ids"></a> [branch\_protection\_rule\_ids](#output\_branch\_protection\_rule\_ids) | List of branch protection rule resource IDs for each release branch. |
| <a name="output_repository_full_name"></a> [repository\_full\_name](#output\_repository\_full\_name) | The full name (e.g., owner/repo) of the GitHub repository. |
| <a name="output_repository_http_clone_url"></a> [repository\_http\_clone\_url](#output\_repository\_http\_clone\_url) | The HTTP(S) clone URL of the GitHub repository. |
| <a name="output_repository_id"></a> [repository\_id](#output\_repository\_id) | The GitHub repository ID. |
| <a name="output_repository_name"></a> [repository\_name](#output\_repository\_name) | The name of the created GitHub repository. |
| <a name="output_repository_node_id"></a> [repository\_node\_id](#output\_repository\_node\_id) | The GraphQL node ID of the GitHub repository. |
| <a name="output_repository_ssh_clone_url"></a> [repository\_ssh\_clone\_url](#output\_repository\_ssh\_clone\_url) | The SSH URL of the GitHub repository. |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The HTTPS URL of the GitHub repository. |
| <a name="output_workflow_file_shas"></a> [workflow\_file\_shas](#output\_workflow\_file\_shas) | Map of workflow file paths to commit SHAs. |
<!-- END_TF_DOCS -->
<!-- markdownlint-enable MD033 -->

## 🧪 Local Testing

Run Terratest from the root:

```bash
task test
```

> Requires valid `GITHUB_TOKEN` exported in your terminal or `.env`.

## ⚙️ Integration Testing

We use kitchen-terraform with Terragrunt and InSpec to run `terraform plan` in isolation against the root module  
and verify its JSON output.

Prerequisites:

- Ruby (2.7+)
- Bundler (`gem install bundler`)

Install dependencies:

```bash
bundle install
```

Run tests:

```bash
bundle exec kitchen test
```

Or, to run kitchen directly without Bundler:

```bash
gem install kitchen-terraform inspec
kitchen test
```

## 📜 License

[MIT](LICENSE)

## 🛡️ Compliance Guardrails & Policy Enforcement

This module enforces best-practice compliance guardrails using static analysis and policy-as-code in CI:

- **Trivy** and **tflint**: Run automatically in CI for static security and lint checks.
- **OPA (Open Policy Agent) with conftest**: Custom Rego policies in `policy/` directory enforce organization
  guardrails on every PR.

### Guardrails Enforced

- S3 buckets and RDS instances must be encrypted, versioned, and tagged (Owner, Environment)
- No public S3 buckets or open security groups (0.0.0.0/0)
- No IAM users or inline IAM policies
- RDS must have backup retention and monitoring
- All providers must be version-pinned (no wildcards)
- No hardcoded secrets in code
- Resource names must include environment (prod/dev/staging)
- All variables must have descriptions
- No deprecated resources (e.g., discourage direct aws_instance)
- Logging required for S3, monitoring for RDS
- Cost estimation enforced (fail if Infracost > $1000)
- No public IPs on EC2
- MFA required for IAM users
- IAM policies must not allow Action: *or Resource:*
- Only approved AWS regions allowed (configurable in `policy/extra-guardrails.rego`)
- All endpoints must use HTTPS

### How it works

- On every PR, CI runs `terraform plan -json`, then runs `conftest` with all policies in `policy/`.
- Any violation fails the build and prints a clear message.

### Local Policy Testing

You can test policies locally before pushing:

```sh
# Install conftest if needed
wget https://github.com/open-policy-agent/conftest/releases/download/v0.51.0/conftest_0.51.0_$(uname -s)_x86_64.tar.gz
 tar xzf conftest_0.51.0_$(uname -s)_x86_64.tar.gz
 sudo mv conftest /usr/local/bin/

# Generate a Terraform plan in JSON
terraform plan -out=tfplan.binary
terraform show -json tfplan.binary > plan.json

# Run all OPA policies
conftest test --policy policy/ plan.json
```

Edit `policy/extra-guardrails.rego` to configure allowed AWS regions or add more rules.

### Custom Policies

- Add new `.rego` files to the `policy/` directory to enforce additional org-specific rules.
- See [Open Policy Agent docs](https://www.openpolicyagent.org/docs/latest/) for more examples.

## 📊 Module Statistics

![GitHub commit activity](https://img.shields.io/github/commit-activity/m/kpeacocke/terraform-github-repo)
![GitHub last commit](https://img.shields.io/github/last-commit/kpeacocke/terraform-github-repo)
![GitHub repo size](https://img.shields.io/github/repo-size/kpeacocke/terraform-github-repo)
![Lines of code](https://img.shields.io/tokei/lines/github/kpeacocke/terraform-github-repo)

## 🤝 Support & Community

- 💡 **Have questions?** Start a [Discussion](https://github.com/kpeacocke/terraform-github-repo/discussions)
- 🐛 **Found a bug?** Create an [Issue](https://github.com/kpeacocke/terraform-github-repo/issues)
- 🚀 **Want to contribute?** See our [Contributing Guide](./CONTRIBUTING.md)
- 📚 **Need examples?** Check our [Examples Directory](./examples)

## 🎖️ Acknowledgments

This module is inspired by and follows best practices from:

- [HashiCorp Terraform Module Standards](https://www.terraform.io/docs/registry/modules/publish.html)
- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [Open Source Security Foundation (OpenSSF)](https://openssf.org/)
- [Cloud Security Alliance](https://cloudsecurityalliance.org/)

---
