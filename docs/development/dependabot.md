# Dependabot Configuration Guide

This document explains the automated dependency management setup using GitHub Dependabot for the Terraform module.

## Overview

Dependabot is configured to automatically:

- Update Terraform providers and modules
- Update Go dependencies (for Terratest)
- Update GitHub Actions
- Update Python dependencies (for documentation)
- Update Ruby dependencies (for Kitchen-Terraform)
- Update NPM dependencies (if any)

## Configuration Files

### `.github/dependabot.yml`

The main Dependabot configuration file that defines update schedules and settings for different package ecosystems:

- **Terraform**: Weekly updates on Tuesdays for the main module and examples
- **Go modules**: Weekly updates on Wednesdays for test dependencies
- **GitHub Actions**: Weekly updates on Mondays for CI/CD workflows
- **Python (pip)**: Weekly updates on Fridays for documentation dependencies
- **Ruby (bundler)**: Weekly updates on Thursdays for Kitchen-Terraform
- **NPM**: Weekly updates on Fridays for any Node.js dependencies

### `.github/workflows/dependabot-auto-validation.yml`

Automated workflow that runs when Dependabot opens PRs to:

1. Validate Terraform configurations across multiple versions
2. Run Go tests (including race detection)
3. Perform security scanning with Trivy
4. Validate documentation builds
5. Auto-approve and merge if all checks pass
6. Notify on failures

## Local Development

### Dependabot Management Script

Use the `scripts/dependabot.sh` script for local dependency management:

```bash
# Check for available updates
./scripts/dependabot.sh check-updates

# Validate current dependencies
./scripts/dependabot.sh validate-deps

# Run tests with current dependencies
./scripts/dependabot.sh test-deps

# Run security scans
./scripts/dependabot.sh security-scan

# Update Terraform providers manually
./scripts/dependabot.sh update-terraform

# Update Go dependencies
./scripts/dependabot.sh update-go

# Simulate Dependabot PR validation
./scripts/dependabot.sh simulate-pr
```

### Task Commands

Use the Task runner for dependency management:

```bash
# Check for updates
task deps:check

# Validate dependencies
task deps:validate

# Test dependencies
task deps:test

# Security scan
task deps:security

# Update Terraform providers
task deps:update:terraform

# Update Go dependencies
task deps:update:go

# Simulate PR validation
task deps:simulate-pr

# Run all dependency tasks
task deps:all
```

## Dependabot PR Process

### Automatic Process

1. **Dependabot Detection**: Dependabot scans for outdated dependencies weekly
2. **PR Creation**: Opens PRs with dependency updates
3. **Auto-Validation**: GitHub Actions workflow automatically runs:
   - Terraform validation across multiple versions
   - Go tests with race detection
   - Security scanning
   - Documentation validation
4. **Auto-Approval**: If all checks pass, PR is auto-approved and merged
5. **Failure Notification**: If checks fail, team is notified via PR comment

### Manual Review Process

For PRs that require manual review (major version updates, security advisories):

1. Review the PR description and changelog
2. Run local validation: `task deps:simulate-pr`
3. Test specific functionality affected by the update
4. Approve and merge manually

## Security Considerations

### Update Policies

- **Minor/Patch Updates**: Auto-merged after validation
- **Major Updates**: Require manual review (configured to ignore by default)
- **Security Updates**: Prioritized and can override normal schedules

### Validation Checks

All dependency updates undergo:

- Multi-version Terraform compatibility testing
- Comprehensive Go test suite
- Security vulnerability scanning
- Documentation build validation

## Customization

### Modify Update Schedule

Edit `.github/dependabot.yml` to change:

- Update frequency (`daily`, `weekly`, `monthly`)
- Specific days and times
- Timezone settings

### Add New Ecosystems

To track additional dependency types:

1. Add new package ecosystem entry to `dependabot.yml`
2. Update validation workflow if needed
3. Add corresponding tasks to `Taskfile.yml`

### Change Auto-merge Behavior

Modify `.github/workflows/dependabot-auto-validation.yml`:

- Remove auto-merge steps for manual review only
- Add additional validation steps
- Change approval requirements

## Monitoring

### GitHub Insights

Monitor Dependabot activity:

- Go to repository → Insights → Dependency graph → Dependabot
- View update history and current status
- Check for failed update attempts

### Notifications

Configure notifications for:

- Failed Dependabot runs
- Security advisories
- Major version updates requiring review

## Troubleshooting

### Common Issues

1. **Failed Updates**: Check the Dependabot log in PR comments
2. **Merge Conflicts**: Dependabot will rebase automatically
3. **Test Failures**: Review the GitHub Actions logs
4. **Security Alerts**: Address high/critical vulnerabilities promptly

### Manual Intervention

If Dependabot fails:

1. Check the error in PR comments
2. Run local validation: `./scripts/dependabot.sh simulate-pr`
3. Fix issues manually and push updates
4. Re-trigger Dependabot if needed

## Best Practices

1. **Regular Monitoring**: Review Dependabot PRs weekly
2. **Security First**: Prioritize security updates
3. **Test Locally**: Use local scripts before major updates
4. **Version Pinning**: Pin critical dependencies to avoid breaking changes
5. **Changelog Review**: Always review dependency changelogs for breaking changes

## Integration with CI/CD

The Dependabot configuration integrates with:

- **CodeQL**: Security analysis on updated dependencies
- **Terraform Cloud**: Validation in cloud environments
- **GitHub Actions**: Automated testing and deployment
- **Documentation**: Automatic docs updates with new versions

This ensures that dependency updates maintain security, compatibility, and documentation consistency  
across the entire project lifecycle.
