# Migration from tfsec to Trivy

This document outlines the migration from tfsec to Trivy for security scanning in the terraform-github-repo module.

## Why Migrate?

As announced by Aqua Security, **tfsec is joining the Trivy family**. The tfsec project is being consolidated into Trivy to provide a unified security scanning experience.

> **Official Statement**: "tfsec will continue to remain available for the time being, although our engineering attention will be directed at Trivy going forward."
> 
> Read more: https://github.com/aquasecurity/tfsec/discussions/1994

## Benefits of Trivy

Trivy provides enhanced security scanning capabilities compared to tfsec:

### 🔍 **Multi-Scanner Approach**
- **Vulnerability Scanning**: CVE detection in dependencies
- **Secret Detection**: Hardcoded secrets and API keys
- **Configuration Scanning**: Infrastructure as Code security issues
- **License Scanning**: License compliance checks

### 🎯 **Broader Coverage**
- **Terraform**: All tfsec checks plus additional rules
- **Kubernetes**: YAML manifest security
- **Docker**: Container image vulnerabilities
- **Cloud**: AWS, Azure, GCP misconfigurations

### 📊 **Better Integration**
- **SARIF Output**: Native GitHub Security tab integration
- **Multiple Formats**: JSON, Table, GitHub format support
- **CI/CD Friendly**: Better error handling and reporting

## What Changed

### Configuration Files

| Old (tfsec) | New (Trivy) |
|-------------|-------------|
| `.tfsec.yml` | `.trivy.yaml` |
| `tfsec-report.json` | `trivy-report.json` |
| N/A | `trivy-results.sarif` |

### Task Commands

| Old Command | New Command |
|-------------|-------------|
| `task tfsec` | `task trivy` |
| N/A | `task trivy:terraform` |
| N/A | `task trivy:secrets` |
| N/A | `task trivy:vuln` |
| N/A | `task trivy:all` |

### CI/CD Integration

**Before (tfsec):**
```yaml
- name: Run tfsec
  run: tfsec --format github
```

**After (Trivy):**
```yaml
- name: Run Trivy security scan
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: 'fs'
    scan-ref: '.'
    format: 'sarif'
    output: 'trivy-results.sarif'

- name: Upload Trivy scan results
  uses: github/codeql-action/upload-sarif@v3
  with:
    sarif_file: 'trivy-results.sarif'
```

## Installation

### Local Installation

**macOS:**
```bash
brew install trivy
```

**Linux:**
```bash
# Using package manager
sudo apt-get update && sudo apt-get install trivy

# Or download binary
curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin
```

**Windows:**
```powershell
# Using Chocolatey
choco install trivy

# Using Scoop
scoop install trivy
```

### GitHub Actions

Trivy is available as a GitHub Action:
```yaml
- name: Run Trivy scanner
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: 'fs'
    scan-ref: '.'
```

## Usage Examples

### Basic Security Scan
```bash
# Scan current directory
trivy fs .

# Terraform-specific scan
trivy config .

# Secret scanning only
trivy fs --scanners secret .

# Vulnerability scanning only
trivy fs --scanners vuln .
```

### Output Formats
```bash
# Table format (human-readable)
trivy fs --format table .

# JSON format (for parsing)
trivy fs --format json --output trivy-report.json .

# SARIF format (for GitHub Security)
trivy fs --format sarif --output trivy-results.sarif .

# GitHub format (for CI/CD)
trivy fs --format github .
```

### Using Task Commands
```bash
# Run basic security scan
task trivy

# Terraform-specific scan
task trivy:terraform

# Secret detection
task trivy:secrets

# Comprehensive scan with all outputs
task trivy:all

# Generate SARIF for GitHub
task trivy:sarif
```

## Configuration

### `.trivy.yaml` Configuration

```yaml
# Scanner types
scanner:
  - vuln      # Vulnerability scanning
  - secret    # Secret detection
  - config    # Configuration scanning

# Terraform configuration
terraform:
  enabled: true
  checks:
    - terraform
    - kubernetes
    - docker

# Severity levels
severity:
  - CRITICAL
  - HIGH
  - MEDIUM
  - LOW

# Skip directories
skip-dirs:
  - .git
  - .terraform
  - node_modules

# Skip files
skip-files:
  - "*.tfstate"
  - "*.tfstate.backup"
```

## Migration Checklist

- [x] ✅ **Updated Taskfile.yml** - Replaced tfsec tasks with Trivy
- [x] ✅ **Updated CI/CD workflows** - Enhanced GitHub Actions with Trivy
- [x] ✅ **Created .trivy.yaml** - Configuration file for Trivy
- [x] ✅ **Updated .gitignore** - Changed ignore patterns for Trivy outputs
- [x] ✅ **Updated documentation** - README and guides reflect Trivy usage
- [x] ✅ **Enhanced security scanning** - Added multiple scan types
- [x] ✅ **SARIF integration** - GitHub Security tab integration

## Backward Compatibility

The migration maintains backward compatibility:

- **Same security coverage**: All tfsec rules are included in Trivy
- **Enhanced detection**: Additional security checks beyond tfsec
- **Familiar workflow**: Similar command patterns and outputs
- **Gradual migration**: Can run both tools during transition if needed

## Troubleshooting

### Common Issues

1. **Trivy not found**
   ```bash
   # Install Trivy
   brew install trivy  # macOS
   # or follow installation guide above
   ```

2. **Configuration not loaded**
   ```bash
   # Verify config file location
   trivy fs --config .trivy.yaml .
   ```

3. **Too many false positives**
   ```yaml
   # Add to .trivy.yaml
   ignore-unfixed: true
   skip-files:
     - "test/**/*"
     - "examples/**/*"
   ```

4. **SARIF upload fails**
   ```yaml
   # Ensure proper permissions in GitHub Actions
   permissions:
     security-events: write
   ```

### Performance Optimization

```yaml
# .trivy.yaml - Optimize for speed
scanner:
  - config  # Focus on configuration only for faster scans

skip-dirs:
  - .git
  - .terraform
  - node_modules
  - docs
  - test  # Skip test directories for faster CI

cache:
  backend: "fs"
  ttl: "24h"
```

## Resources

- **Trivy Documentation**: https://aquasecurity.github.io/trivy/
- **tfsec Migration Guide**: https://github.com/aquasecurity/tfsec/discussions/1994
- **Trivy Rules**: https://avd.aquasec.com/
- **GitHub Security Integration**: https://docs.github.com/en/code-security/code-scanning

## Support

If you encounter issues during migration:

1. **Check Trivy Documentation**: https://aquasecurity.github.io/trivy/
2. **Review Configuration**: Ensure `.trivy.yaml` is properly configured
3. **Test Locally**: Run `task trivy:all` to validate setup
4. **GitHub Issues**: Report issues in the repository

The migration to Trivy provides enhanced security scanning capabilities while maintaining the same level of protection and improving integration with modern CI/CD pipelines.
