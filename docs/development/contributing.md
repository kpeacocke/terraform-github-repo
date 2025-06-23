# Contributing

Thank you for your interest in contributing to the Terraform GitHub Repository module!  
This guide will help you understand how to contribute to this project.

## Getting Started

1. Fork the repository
2. Clone your fork:

   ```bash
   git clone https://github.com/your-username/terraform-github-repo.git
   cd terraform-github-repo
   ```

## Development Requirements

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- [Go](https://golang.org/doc/install) (v1.18+) for tests
- [pre-commit](https://pre-commit.com/) for linting and formatting

## Setting Up the Development Environment

1. Install pre-commit hooks:

   ```bash
   pre-commit install
   ```

2. Install Go dependencies:

   ```bash
   go mod download
   ```

## Testing

### Unit Tests

Run the unit tests:

```bash
go test -v ./test
```

### Integration Tests

To run integration tests, set up the required environment variables:

```bash
export GITHUB_TOKEN=your_github_token
export GITHUB_OWNER=your_github_username_or_organization
go test -v -tags=integration ./test
```

## Pull Request Process

1. Create a new branch for your feature or bugfix:

   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and commit them using conventional commits:

   ```bash
   git commit -m "feat: add new feature"
   ```

3. Push your branch:

   ```bash
   git push origin feature/your-feature-name
   ```

4. Create a pull request to the `main` branch of the original repository

## Conventional Commits

This project uses [Conventional Commits](https://www.conventionalcommits.org/) for commit messages. Please follow this format:

- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation updates
- `test:` for test additions or updates
- `refactor:` for code refactoring
- `chore:` for routine tasks and maintenance
- `ci:` for CI/CD changes
- `style:` for formatting changes
- `perf:` for performance improvements

## Release Process

Releases are automated using semantic-release.
When your PR is merged to main, a new release will be created based on your commit messages.

## Code of Conduct

Please follow our [Code of Conduct](CODE_OF_CONDUCT.md) in all your interactions with the project.

## Questions?

If you have any questions or need help, please open an issue or reach out to the maintainers.
