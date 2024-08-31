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

## 📖 Documentation

For full usage documentation and module inputs/outputs, see:

📘 [`modules/github-repo/README.md`](modules/github-repo/README.md)

## 🧪 Local Testing

Run Terratest from the root:

```bash
task test
```

> Requires valid `GITHUB_TOKEN` exported in your terminal or `.env`.

## 🚀 Release Process

Semantic releases are automated via `semantic-release`. PRs must follow [Conventional Commits](https://www.conventionalcommits.org/) for automated changelog generation and version tagging.

## 📜 License

[MIT](LICENSE)
