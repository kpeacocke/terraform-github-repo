#!/bin/bash
set -euo pipefail

# Release Management Script
# Automates the release process for the terraform-github-repo module

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_release() { echo -e "${PURPLE}[RELEASE]${NC} $1"; }

# Usage function
usage() {
    cat << EOF
Release Management Script for terraform-github-repo

Usage: $0 [COMMAND] [OPTIONS]

Commands:
    check           Check if ready for release
    prepare         Prepare for release (validate, test, lint)
    preview         Preview the next release version
    release         Create a release (triggers CI/CD)
    status          Check release status
    rollback        Rollback to previous version
    registry        Check Terraform Registry status
    docs            Update documentation
    help            Show this help message

Options:
    --dry-run       Show what would be done without making changes
    --force         Force release even with warnings
    --type TYPE     Release type (patch|minor|major)
    --version VER   Specific version to release

Examples:
    $0 check                    # Check release readiness
    $0 prepare                  # Run pre-release validation
    $0 preview                  # Preview next version
    $0 release --type minor     # Create minor release
    $0 status                   # Check current release status
    $0 registry                 # Check Terraform Registry
EOF
}

# Check if repository is ready for release
check_release_readiness() {
    log_info "Checking release readiness..."
    
    local issues=0
    
    # Check if we're on main branch
    current_branch=$(git rev-parse --abbrev-ref HEAD)
    if [ "$current_branch" != "main" ]; then
        log_error "Not on main branch (currently on: $current_branch)"
        ((issues++))
    fi
    
    # Check for uncommitted changes
    if ! git diff-index --quiet HEAD --; then
        log_error "Uncommitted changes detected"
        ((issues++))
    fi
    
    # Check if remote is up to date
    git fetch origin main --quiet
    local_commit=$(git rev-parse HEAD)
    remote_commit=$(git rev-parse origin/main)
    if [ "$local_commit" != "$remote_commit" ]; then
        log_error "Local branch is not up to date with origin/main"
        ((issues++))
    fi
    
    # Check required files
    required_files=("main.tf" "variables.tf" "outputs.tf" "README.md" "LICENSE" "CHANGELOG.md")
    for file in "${required_files[@]}"; do
        if [ ! -f "$PROJECT_ROOT/$file" ]; then
            log_error "Missing required file: $file"
            ((issues++))
        fi
    done
    
    # Check examples directory
    if [ ! -d "$PROJECT_ROOT/examples" ]; then
        log_error "Missing examples directory"
        ((issues++))
    fi
    
    # Check if tests pass
    log_info "Running tests..."
    cd "$PROJECT_ROOT"
    if ! go test ./test/... -timeout 5m > /dev/null 2>&1; then
        log_error "Tests are failing"
        ((issues++))
    fi
    
    # Check Terraform validation
    log_info "Validating Terraform..."
    if ! terraform fmt -check -recursive > /dev/null 2>&1; then
        log_error "Terraform formatting issues detected"
        ((issues++))
    fi
    
    if ! terraform validate > /dev/null 2>&1; then
        log_error "Terraform validation failed"
        ((issues++))
    fi
    
    # Summary
    if [ $issues -eq 0 ]; then
        log_success "✅ Repository is ready for release!"
        return 0
    else
        log_error "❌ Found $issues issues. Fix them before releasing."
        return 1
    fi
}

# Prepare repository for release
prepare_release() {
    log_info "Preparing repository for release..."
    
    cd "$PROJECT_ROOT"
    
    # Update terraform-docs
    log_info "Updating terraform-docs..."
    if command -v terraform-docs &> /dev/null; then
        terraform-docs markdown table --output-file README.md --output-mode inject .
    else
        log_warning "terraform-docs not installed, skipping documentation update"
    fi
    
    # Format Terraform
    log_info "Formatting Terraform code..."
    terraform fmt -recursive
    
    # Update Go modules
    log_info "Updating Go modules..."
    go mod tidy
    
    # Run tests
    log_info "Running tests..."
    go test ./test/... -timeout 10m
    
    # Validate Terraform
    log_info "Validating Terraform..."
    terraform init > /dev/null
    terraform validate
    
    # Validate examples
    log_info "Validating examples..."
    for example in examples/*/; do
        if [ -d "$example" ]; then
            log_info "Validating example: $example"
            cd "$example"
            terraform init > /dev/null
            terraform validate
            cd "$PROJECT_ROOT"
        fi
    done
    
    log_success "Repository prepared for release!"
}

# Preview next release version
preview_release() {
    log_info "Previewing next release version..."
    
    cd "$PROJECT_ROOT"
    
    # Install semantic-release if not available
    if ! command -v semantic-release &> /dev/null; then
        log_info "Installing semantic-release..."
        npm install -g semantic-release @semantic-release/changelog @semantic-release/git @semantic-release/github @semantic-release/exec conventional-changelog-conventionalcommits
    fi
    
    # Run semantic-release in dry-run mode
    log_info "Running semantic-release preview..."
    npx semantic-release --dry-run --no-ci || {
        log_warning "Unable to preview release. This might be normal if no release is needed."
        return 0
    }
}

# Create a release
create_release() {
    local release_type="${1:-}"
    local force_release="${2:-false}"
    
    log_release "Creating release..."
    
    # Check readiness unless forced
    if [ "$force_release" != "true" ]; then
        if ! check_release_readiness; then
            log_error "Repository not ready for release. Use --force to override."
            return 1
        fi
    fi
    
    cd "$PROJECT_ROOT"
    
    # Prepare repository
    prepare_release
    
    # Commit any changes from preparation
    if ! git diff-index --quiet HEAD --; then
        log_info "Committing preparation changes..."
        git add .
        git commit -m "chore: prepare for release" || true
        git push origin main
    fi
    
    # Trigger release via GitHub Actions
    log_release "Triggering release workflow..."
    
    if [ -n "$release_type" ]; then
        log_info "Triggering manual release with type: $release_type"
        gh workflow run release.yml --field release_type="$release_type" || {
            log_error "Failed to trigger release workflow. Make sure 'gh' CLI is installed and authenticated."
            return 1
        }
    else
        log_info "Triggering automatic release..."
        # Push to main will trigger the release
        git push origin main
    fi
    
    log_success "Release workflow triggered! Monitor at: https://github.com/kpeacocke/terraform-github-repo/actions"
}

# Check release status
check_release_status() {
    log_info "Checking release status..."
    
    # Get latest release
    latest_release=$(git describe --tags --abbrev=0 2>/dev/null || echo "No releases found")
    log_info "Latest release: $latest_release"
    
    # Check workflow status
    if command -v gh &> /dev/null; then
        log_info "Recent workflow runs:"
        gh run list --workflow=release.yml --limit=5
    else
        log_warning "GitHub CLI not installed. Install 'gh' for detailed status."
    fi
    
    # Check Terraform Registry
    log_info "Checking Terraform Registry..."
    check_terraform_registry
}

# Check Terraform Registry status
check_terraform_registry() {
    log_info "Checking Terraform Registry status..."
    
    # Check if module exists in registry
    local registry_url="https://registry.terraform.io/modules/kpeacocke/terraform-github-repo"
    
    if command -v curl &> /dev/null; then
        if curl -s --head "$registry_url" | head -n 1 | grep -q "200 OK"; then
            log_success "✅ Module found in Terraform Registry"
            log_info "Registry URL: $registry_url"
            
            # Get latest version from registry
            local api_url="https://registry.terraform.io/v1/modules/kpeacocke/terraform-github-repo"
            if command -v jq &> /dev/null; then
                local registry_version=$(curl -s "$api_url" | jq -r '.version // "unknown"')
                log_info "Registry version: $registry_version"
            fi
        else
            log_warning "⚠️ Module not found in Terraform Registry"
            log_info "It may take a few minutes for new releases to appear in the registry"
        fi
    else
        log_warning "curl not available, cannot check registry status"
    fi
}

# Rollback to previous version
rollback_release() {
    log_warning "Rolling back to previous release..."
    
    cd "$PROJECT_ROOT"
    
    # Get previous release
    local current_tag=$(git describe --tags --abbrev=0)
    local previous_tag=$(git describe --tags --abbrev=0 "$current_tag"^)
    
    if [ -z "$previous_tag" ]; then
        log_error "No previous release found"
        return 1
    fi
    
    log_info "Current release: $current_tag"
    log_info "Previous release: $previous_tag"
    
    read -p "Are you sure you want to rollback to $previous_tag? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        log_warning "Creating rollback commit..."
        git revert --no-edit "$current_tag"
        git push origin main
        log_success "Rollback commit created. This will trigger a new release."
    else
        log_info "Rollback cancelled"
    fi
}

# Update documentation
update_documentation() {
    log_info "Updating documentation..."
    
    cd "$PROJECT_ROOT"
    
    # Update terraform-docs
    if command -v terraform-docs &> /dev/null; then
        terraform-docs markdown table --output-file README.md --output-mode inject .
        log_success "README.md updated"
    fi
    
    # Update changelog in docs
    if [ -f "CHANGELOG.md" ] && [ -d "docs" ]; then
        cp CHANGELOG.md docs/changelog.md
        log_success "Documentation changelog updated"
    fi
    
    # Build docs if MkDocs is available
    if [ -f "mkdocs.yml" ] && command -v mkdocs &> /dev/null; then
        mkdocs build
        log_success "Documentation built"
    fi
}

# Main script logic
main() {
    local command="${1:-help}"
    local dry_run=false
    local force=false
    local release_type=""
    local version=""
    
    # Parse options
    shift || true
    while [[ $# -gt 0 ]]; do
        case $1 in
            --dry-run)
                dry_run=true
                shift
                ;;
            --force)
                force=true
                shift
                ;;
            --type)
                release_type="$2"
                shift 2
                ;;
            --version)
                version="$2"
                shift 2
                ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
    done
    
    case "$command" in
        check)
            check_release_readiness
            ;;
        prepare)
            prepare_release
            ;;
        preview)
            preview_release
            ;;
        release)
            create_release "$release_type" "$force"
            ;;
        status)
            check_release_status
            ;;
        rollback)
            rollback_release
            ;;
        registry)
            check_terraform_registry
            ;;
        docs)
            update_documentation
            ;;
        help|*)
            usage
            ;;
    esac
}

# Run main function
main "$@"
