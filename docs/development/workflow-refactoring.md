# GitHub Actions Workflow Refactoring

This document summarizes the refactoring performed on the GitHub Actions workflows in this repository to improve
maintainability, security, and standardization.

## Reusable Workflows

Three reusable workflows have been created to standardize common operations across all CI/CD processes:

### 1. Terraform Validation (`.github/workflows/reusable-terraform-validation.yml`)

A reusable workflow for validating Terraform code with consistent settings:

- Configurable Terraform version
- Format checking
- Initialization with or without backend
- Validation
- TFLint integration
- Summary reporting

### 2. Security Scanning (`.github/workflows/reusable-security-scan.yml`)

A reusable workflow for security scanning using Trivy:

- Configurable scan target (filesystem, repository, images)
- Output format selection (SARIF, JSON, table)
- Configurable severity filtering
- Optional upload to GitHub Security tab
- Artifact storage of scan results

### 3. Terraform Documentation (`.github/workflows/reusable-terraform-docs.yml`)

A reusable workflow for generating Terraform documentation:

- Configurable working directory
- Output file selection
- Optional Git commit and push
- Summary reporting

## Refactored Workflows

The following workflows have been refactored to use the reusable components:

### CI Workflow (`.github/workflows/ci.yml`)

- Split Terraform validation into multiple jobs using the reusable workflow
- Added a dedicated terraform-additional-checks job for OPA policy validation
- Used the reusable security scanning workflow
- Used the reusable Terraform docs workflow
- Added a workflow summary

### Dependabot Auto-Validation (`.github/workflows/dependabot-auto-validation.yml`)

- Split Terraform validation into multiple version-specific jobs using the reusable workflow
- Used the reusable security scanning workflow
- Improved job dependencies and status checking

### Build Workflow (`.github/workflows/build.yml`)

- Added Terraform validation using the reusable workflow
- Added security scanning using the reusable workflow
- Maintained SonarCloud integration
- Added a workflow summary

### Docs Workflow (`.github/workflows/docs.yml`)

- Used the reusable Terraform docs workflow for PR-based documentation updates
- Maintained specialized GitHub Pages deployment logic

## Documentation Deployment Fixes

The documentation deployment process (specifically the `docs-update` job in the release workflow) was improved  
to address two critical issues:

### 1. Python SSL Module Initialization Error

- Added explicit installation of OpenSSL dependencies in workflows:

  ```yaml
  - name: Install OpenSSL dependencies
    run: |
      sudo apt-get update
      sudo apt-get install -y libssl-dev openssl ca-certificates
  ```
  
- Created a dedicated script (`scripts/fix-python-ssl.sh`) to properly configure SSL environment variables:

  ```bash
  export PYTHONHTTPSVERIFY=0
  export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
  export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  ```
  
- Added trusted hosts for pip package installation to bypass verification issues:

  ```bash
  pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org ...
  ```

### 2. MkDocs 'latest' Alias Collision

- Created `scripts/fix-mike-aliases.sh` to detect and remove conflicting aliases:

  ```bash
  # Check if 'latest' alias exists and remove it
  if grep -q "latest" .mike; then
    grep -v "latest" .mike.bak > .mike
    git commit -m "fix: removed latest alias to avoid collision"
  fi
  ```
  
- Modified mike deployment commands to avoid parallel alias updates by separating version deployment from alias setting:

  ```bash
  # First deploy the version
  mike deploy --push $VERSION
  # Then set the alias separately
  mike alias --push $VERSION latest
  # Finally set the default
  mike set-default --push latest
  ```

### 3. Testing and Documentation Improvements

- Added `scripts/test-docs-deployment.sh` script for local testing of the full documentation pipeline
- Created comprehensive troubleshooting documentation in `docs/development/docs-testing.md`
- Enhanced error handling with better verbosity and fallback options
- Streamlined branch management and git operations
- Improved environment variable handling and debug output

These improvements ensure the documentation deployment process is more resilient and easier to debug, and
less prone to SSL-related failures or alias conflicts.

## Benefits

1. **Consistency**: Standardized validation, security scanning, and documentation generation
2. **Maintainability**: Central configuration for common operations
3. **DRY principle**: Avoid duplicate code across workflows
4. **Security**: Consistent permissions and security best practices
5. **Visibility**: Added workflow summaries for better reporting

## Future Work

- Further consolidate similar jobs in release workflows
- Improve test coverage of workflow runs
- Consider additional reusable components for Go testing
