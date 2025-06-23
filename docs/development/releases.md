# Release Automation Guide

This document explains the automated release process for the terraform-github-repo module, including semantic versioning,
Terraform Registry publishing, and documentation updates.

## Overview

The release system is fully automated using:

- **Semantic Release**: Automated versioning based on conventional commits
- **GitHub Actions**: CI/CD workflows for validation and publishing
- **Terraform Registry**: Automatic module publishing
- **Versioned Documentation**: Automated docs deployment with mike

## Release Workflows

### 1. Automatic Releases (`release.yml`)

Triggered on every push to `main` branch:

1. **Pre-release Validation**
   - Terraform format and validation
   - Go test suite execution
   - Example validation
   - Security scanning

2. **Semantic Release**
   - Analyzes commit messages
   - Determines version bump type
   - Generates changelog
   - Creates GitHub release

3. **Terraform Registry Publishing**
   - Validates registry requirements
   - Monitors registry publication
   - Notifies on completion

4. **Documentation Updates**
   - Deploys versioned docs with mike
   - Updates changelog in docs
   - Publishes to GitHub Pages

### 2. Manual Releases (`manual-release.yml`)

For controlled releases when needed:

- Triggered via GitHub Actions UI
- Supports patch/minor/major release types
- Optional test skipping (not recommended)
- Force release option for edge cases

## Semantic Versioning

### Commit Types and Release Impact

| Commit Type | Release Type | Example |
|-------------|--------------|---------|
| `feat:` | **Minor** (0.X.0) | `feat: add branch protection rules` |
| `fix:` | **Patch** (0.0.X) | `fix: resolve variable validation issue` |
| `perf:` | **Patch** (0.0.X) | `perf: optimize repository creation` |
| `refactor:` | **Patch** (0.0.X) | `refactor: improve code organization` |
| `BREAKING CHANGE:` | **Major** (X.0.0) | `feat!: remove deprecated variables` |

### Commit Message Format

```markdown
`type`[optional scope]: `description`

[optional body]

[optional footer(s)]
```

`type`[optional scope]: `description`

[optional body]

[optional footer(s)]

```markdown

**Examples:**

```bash
feat(security): add CodeQL scanning configuration
fix(validation): resolve terraform version constraint
docs: update README with new examples
chore: update dependencies
```

## Release Management Scripts

### Local Release Management

Use the `scripts/release.sh` script:

```bash
# Check if ready for release
./scripts/release.sh check

# Prepare repository for release
./scripts/release.sh prepare

# Preview next release version
./scripts/release.sh preview

# Create a release
./scripts/release.sh release

# Check release status
./scripts/release.sh status

# Check Terraform Registry
./scripts/release.sh registry

# Update documentation
./scripts/release.sh docs
```

### Task Commands

Use Task runner for release management:

```bash
# Check release readiness
task release:check

# Prepare for release
task release:prepare

# Preview release
task release:preview

# Create release
task release:create

# Check status
task release:status

# Check registry
task release:registry

# Full release workflow
task release:all
```

## Terraform Registry Publishing

### Automatic Publishing Process

1. **Release Detection**: Registry monitors GitHub releases
2. **Validation**: Registry validates module structure
3. **Publication**: Module becomes available in registry
4. **Notification**: Workflow confirms publication

### Registry Requirements

The module meets all Terraform Registry requirements:

- ✅ **Standard Structure**: `main.tf`, `variables.tf`, `outputs.tf`
- ✅ **Documentation**: Comprehensive `README.md`
- ✅ **Examples**: Complete usage examples in `examples/`
- ✅ **License**: Open source license file
- ✅ **Semantic Versioning**: Git tags following semver
- ✅ **Module Metadata**: `.terraform-module.yml` configuration

### Module Usage

Once published, users can reference the module:

```hcl
module "github_repo" {
  source = "kpeacocke/terraform-github-repo/github"
  version = "~> 1.0"
  
  # Your configuration here
  name = "my-awesome-repo"
  description = "My awesome repository"
}
```

## Manual Release Process

### Via GitHub Actions UI

1. Go to **Actions** → **Manual Release**
2. Click **Run workflow**
3. Select release type (patch/minor/major)
4. Configure options if needed
5. Click **Run workflow**

### Via GitHub CLI

```bash
# Trigger manual patch release
gh workflow run manual-release.yml --field release_type=patch

# Trigger manual minor release
gh workflow run manual-release.yml --field release_type=minor

# Force major release (skip tests)
gh workflow run manual-release.yml \
  --field release_type=major \
  --field skip_tests=true \
  --field force_release=true
```

## Release Validation

### Pre-release Checks

Every release undergoes comprehensive validation:

1. **Code Quality**
   - Terraform formatting (`terraform fmt`)
   - Terraform validation (`terraform validate`)
   - Go test suite with race detection
   - Example module validation

2. **Security**
   - Trivy security scanning
   - Dependency vulnerability checks
   - CodeQL analysis

3. **Documentation**
   - terraform-docs generation
   - MkDocs build validation
   - Changelog generation

4. **Registry Compliance**
   - Required file validation
   - Module structure verification
   - License compliance

## Versioned Documentation

### Automatic Deployment

Documentation is automatically versioned and deployed:

- **Latest Version**: Always points to the newest release
- **Version-Specific**: Each release gets its own docs version
- **GitHub Pages**: Hosted at `https://kpeacocke.github.io/terraform-github-repo/`

### Mike Configuration

The documentation uses [mike](https://github.com/jimporter/mike) for versioning:

```bash
# Deploy version locally
mike deploy v1.2.3 latest --update-aliases

# List versions
mike list

# Serve locally
mike serve
```

## Troubleshooting

### Common Issues

1. **Release Not Triggered**
   - Check commit message format
   - Ensure conventional commit types
   - Verify main branch push

2. **Tests Failing**
   - Run tests locally: `task test`
   - Check environment variables
   - Validate Terraform configuration

3. **Registry Not Updated**
   - Wait 10-15 minutes for registry sync
   - Check registry webhook logs
   - Verify tag format (v1.2.3)

4. **Documentation Not Deploying**
   - Check GitHub Pages settings
   - Verify mike configuration
   - Review workflow logs

### Debug Commands

```bash
# Check semantic-release in dry-run mode
npx semantic-release --dry-run --no-ci

# Validate Terraform Registry requirements
terraform fmt -check -recursive
terraform validate

# Test documentation build
mkdocs build --strict

# Check git tags
git tag --list --sort=-version:refname
```

## Best Practices

### Commit Message Guidelines

1. **Use Conventional Commits**: Follow the standard format
2. **Be Descriptive**: Clear, concise descriptions
3. **Include Context**: Add body text for complex changes
4. **Breaking Changes**: Use `!` or `BREAKING CHANGE:` footer

### Release Strategy

1. **Regular Releases**: Release frequently with small changes
2. **Feature Branches**: Use branches for large features
3. **Hotfixes**: Use patch releases for urgent fixes
4. **Documentation**: Keep docs up-to-date with releases

### Version Management

1. **Semantic Versioning**: Strictly follow semver principles
2. **Backward Compatibility**: Maintain compatibility in minor releases
3. **Migration Guides**: Provide guides for breaking changes
4. **Deprecation Notices**: Give advance warning before removal

## Monitoring and Alerts

### Release Monitoring

- **GitHub Actions**: Monitor workflow success/failure
- **Terraform Registry**: Check module availability
- **Documentation**: Verify docs deployment
- **Dependencies**: Monitor dependency updates

### Notification Channels

- **GitHub Issues**: Automated release tracking issues
- **GitHub Releases**: Release notes and changelogs
- **Registry Updates**: Module version notifications
- **Documentation**: Versioned docs updates

## Integration with CI/CD

The release system integrates with:

- **Dependabot**: Automated dependency updates
- **CodeQL**: Security analysis
- **Terraform Cloud**: Module validation
- **GitHub Pages**: Documentation hosting

This ensures that every release maintains security, compatibility, and documentation consistency  
across the entire project lifecycle.
