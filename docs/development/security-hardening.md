# GitHub Actions Security Hardening Guide

This document outlines the comprehensive security hardening implemented for all GitHub Actions workflows in the terraform-github-repo module.

## Overview

GitHub Actions security hardening focuses on two critical areas:
1. **SHA Pinning**: Pinning actions to immutable SHA commits
2. **Least-Privilege Permissions**: Implementing minimal required permissions

## Security Improvements Implemented

### 1. SHA Pinning for Supply Chain Security

**Problem**: Using mutable tags like `@v4` or `@master` can lead to supply chain attacks where malicious code is injected into action updates.

**Solution**: Pin all actions to specific SHA commits that are immutable.

**Before:**
```yaml
- uses: actions/checkout@v4
- uses: hashicorp/setup-terraform@v3
- uses: aquasecurity/trivy-action@master
```

**After:**
```yaml
- uses: actions/checkout@692973e3d937129bcbf40652eb9f2f61becf3332 # v4.1.7
- uses: hashicorp/setup-terraform@651471c36a6092792c552e8b1bef71e592b462d8 # v3.1.1
- uses: aquasecurity/trivy-action@7c2007bcb556501da015201bcba5aa14069b74e2 # master
```

### 2. Least-Privilege Permissions

**Problem**: Default GitHub Actions permissions grant broad access that may not be necessary.

**Solution**: Implement explicit, minimal permissions at both workflow and job levels.

**Before (implicit permissions):**
```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      # Inherits all permissions
```

**After (explicit minimal permissions):**
```yaml
permissions:
  contents: read          # Only what's needed
  security-events: write  # For SARIF uploads

jobs:
  test:
    runs-on: ubuntu-latest
    permissions:
      contents: read        # Job-specific, even more restrictive
```

## Actions Security Matrix

| Action | Old Version | SHA Pin | Comments |
|--------|-------------|---------|----------|
| `actions/checkout` | `@v4` | `@692973e3d937129bcbf40652eb9f2f61becf3332` | Core checkout action |
| `actions/setup-go` | `@v5` | `@cdcb36043654635271a94b9a6d1392de5bb323a7` | Go environment setup |
| `actions/setup-node` | `@v4` | `@60edb5dd545a775178f52524783378180af0d1f8` | Node.js setup |
| `actions/setup-python` | `@v5` | `@82c7e631bb3cdc910f68e0081d67478d79c6982d` | Python setup |
| `hashicorp/setup-terraform` | `@v3` | `@651471c36a6092792c552e8b1bef71e592b462d8` | Terraform setup |
| `aquasecurity/trivy-action` | `@master` | `@7c2007bcb556501da015201bcba5aa14069b74e2` | Security scanning |
| `github/codeql-action/*` | `@v3` | `@eb055d739abdc2e8de2e5f4ba1a8b246daa31dc0` | CodeQL security analysis |
| `terraform-docs/gh-actions` | `@v1` | `@e47bfa196e79fa50987ef99aadc16d521c4bd8a2` | Documentation generation |
| `stefanzweifel/git-auto-commit-action` | `@v4` | `@8756aa072ef5b4a080af5dc8fef36c5d586e521d` | Auto-commit functionality |

## Permission Matrix by Workflow

### CI Workflow (`ci.yml`)
```yaml
permissions:
  contents: read          # Read repository contents
  security-events: write  # Upload SARIF security results
  pull-requests: write    # Comment on PRs and auto-commit
  actions: read          # Read workflow information
```

### CodeQL Workflow (`codeql.yml`)
```yaml
permissions:
  actions: read           # Read workflow information
  contents: read          # Read repository contents
  security-events: write  # Upload CodeQL results
```

### Release Workflow (`release.yml`)
```yaml
permissions:
  contents: write         # Create releases and push tags
  issues: write          # Create release tracking issues
  pull-requests: write   # Comment on PRs
  actions: write        # Trigger other workflows
  pages: write          # Deploy documentation
  id-token: write       # OIDC token for secure operations
```

### Documentation Workflow (`docs.yml`)
```yaml
permissions:
  contents: read          # Read repository contents
  pages: write           # Deploy to GitHub Pages
  id-token: write        # OIDC token for Pages deployment
```

### Dependabot Auto-Validation (`dependabot-auto-validation.yml`)
```yaml
permissions:
  contents: read          # Read repository contents
  security-events: write  # Upload security scan results
  pull-requests: write   # Auto-approve and merge PRs
  actions: write         # Trigger workflows
```

## Security Hardening Tools

### 1. Security Hardening Script

Use the `scripts/security-hardening.sh` script to manage security updates:

```bash
# Update all workflows with SHA pinning
./scripts/security-hardening.sh update-all

# Validate current security status
./scripts/security-hardening.sh validate

# Generate security report
./scripts/security-hardening.sh report

# Restore from backups if needed
./scripts/security-hardening.sh restore
```

### 2. Task Commands

Added to `Taskfile.yml`:

```bash
# Security hardening tasks
task security:harden      # Apply security hardening
task security:validate    # Validate security configuration
task security:report      # Generate security report
```

## Validation and Monitoring

### Pre-commit Validation

Add to `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: local
    hooks:
      - id: validate-actions-security
        name: Validate GitHub Actions Security
        entry: ./scripts/security-hardening.sh validate
        language: script
        pass_filenames: false
```

### Automated Monitoring

The workflows now include security monitoring:

1. **SHA Drift Detection**: Alerts if actions revert to tag-based references
2. **Permission Auditing**: Validates that permissions remain minimal
3. **Security Report Generation**: Automatic reports on security posture

## Maintenance Guidelines

### Monthly Security Review

1. **Check for Updates**: Review actions for security updates
2. **Update SHAs**: Pin to latest secure versions
3. **Audit Permissions**: Ensure permissions remain minimal
4. **Test Workflows**: Validate that hardened workflows function correctly

### SHA Update Process

```bash
# 1. Check for new versions
gh api repos/actions/checkout/releases/latest

# 2. Get the SHA for the new version
git ls-remote https://github.com/actions/checkout refs/tags/v4.1.8

# 3. Update the SHA in workflows
./scripts/security-hardening.sh update-all

# 4. Test the updated workflows
./scripts/security-hardening.sh validate
```

### Emergency Response

If a security vulnerability is discovered:

1. **Immediate Response**: Use script to restore from backups
2. **Assessment**: Evaluate impact of the vulnerability
3. **Update**: Pin to a secure SHA version
4. **Validation**: Test all affected workflows

## Security Benefits

### Supply Chain Protection

- **Immutable References**: SHA pins prevent malicious updates
- **Reproducible Builds**: Same SHA always produces same behavior
- **Audit Trail**: Clear history of action versions used

### Access Control

- **Minimal Permissions**: Reduced blast radius of potential breaches
- **Explicit Grants**: No hidden or implicit permissions
- **Job Isolation**: Different jobs have different permission levels

### Monitoring and Compliance

- **Security Reporting**: Automated security posture reports
- **Compliance Tracking**: Clear documentation of security measures
- **Change Management**: Controlled updates with validation

## Compliance Standards

This security hardening helps meet:

- **SOC 2 Type II**: Supply chain security controls
- **ISO 27001**: Information security management
- **NIST Cybersecurity Framework**: Supply chain risk management
- **GitHub Security Best Practices**: Platform-specific recommendations

## Troubleshooting

### Common Issues

1. **SHA Not Found**
   ```bash
   # Check if SHA exists
   git ls-remote https://github.com/actions/checkout <SHA>
   ```

2. **Permission Denied**
   ```yaml
   # Add required permission to workflow
   permissions:
     contents: read
     # Add missing permission here
   ```

3. **Workflow Failure**
   ```bash
   # Restore from backup
   ./scripts/security-hardening.sh restore
   ```

### Validation Commands

```bash
# Check for unpinned actions
grep -r "uses:.*@v[0-9]" .github/workflows/

# Check for missing permissions
grep -L "permissions:" .github/workflows/*.yml

# Validate YAML syntax
yamllint .github/workflows/
```

## Resources

- [GitHub Actions Security Hardening](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [OWASP Supply Chain Security](https://owasp.org/www-project-software-component-verification-standard/)
- [NIST Secure Software Development Framework](https://csrc.nist.gov/Projects/ssdf)
- [GitHub Security Lab](https://securitylab.github.com/)

## Continuous Improvement

This security hardening is an ongoing process:

1. **Regular Updates**: Monthly security reviews
2. **Monitoring**: Automated security posture tracking
3. **Education**: Team training on secure CI/CD practices
4. **Innovation**: Adopting new security features as they become available

The combination of SHA pinning and least-privilege permissions provides a robust security foundation for the CI/CD pipeline while maintaining functionality and ease of maintenance.
