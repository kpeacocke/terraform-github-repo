# Testing

This guide explains how to test the Terraform GitHub Repository module.

## Types of Tests

The module includes several types of tests:

1. **Unit tests**: Verify individual functions and components
2. **Integration tests**: Test interactions with the GitHub API
3. **End-to-end tests**: Validate complete workflows using real repositories

## Prerequisites

To run the tests, you need:

- [Go](https://golang.org/doc/install) (v1.18+)
- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- GitHub personal access token with appropriate permissions

## Environment Setup

Set the required environment variables:

```bash
export GITHUB_TOKEN=your_github_token
export GITHUB_OWNER=your_github_username_or_organization
```

## Running Unit Tests

```bash
go test -v ./test
```

## Running Integration Tests

Integration tests require a GitHub token and will create temporary repositories:

```bash
go test -v -tags=integration ./test
```

## Running End-to-end Tests

End-to-end tests use Kitchen-Terraform and InSpec:

```bash
bundle install
bundle exec kitchen test
```

## Test Coverage

To generate a test coverage report:

```bash
go test -v -coverprofile=coverage.out ./test
go tool cover -html=coverage.out
```

## Continuous Integration

All tests are run in GitHub Actions for every PR and push to main. The CI workflow includes:

1. Code formatting and linting checks
2. Unit tests
3. Integration tests with a GitHub token provided by the CI environment
4. End-to-end tests for complete validation

## Writing New Tests

When adding new features, please include appropriate tests:

1. **Unit tests** for new functions
2. **Integration tests** for GitHub API interactions
3. **End-to-end tests** for complete workflows

### Test File Organization

- `test/` - Contains all test files
  - `test_helpers.go` - Helper functions for tests
  - `*_test.go` - Unit and integration tests
  - `fixtures/` - Test fixtures and template files
  - `integration/` - Integration test profiles for InSpec

### Test Best Practices

1. Use test fixtures rather than hardcoded values
2. Clean up resources after tests complete
3. Use descriptive test names
4. Keep tests isolated and independent
5. Mock external dependencies when appropriate
