#!/bin/bash
set -euo pipefail

# Dependabot Management Script
# This script helps manage and validate dependency updates locally

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Usage function
usage() {
    cat << EOF
Dependabot Management Script

Usage: $0 [COMMAND]

Commands:
    check-updates     Check for available dependency updates
    validate-deps     Validate current dependencies
    test-deps         Run tests with current dependencies
    security-scan     Run security scans on dependencies
    update-terraform  Update Terraform providers manually
    update-go         Update Go dependencies
    update-actions    Update GitHub Actions
    simulate-pr       Simulate Dependabot PR validation
    help             Show this help message

Examples:
    $0 check-updates
    $0 validate-deps
    $0 simulate-pr
EOF
}

# Check for available updates
check_updates() {
    log_info "Checking for available dependency updates..."
    
    # Check Terraform providers
    log_info "Checking Terraform provider updates..."
    cd "$PROJECT_ROOT"
    terraform init -upgrade=false > /dev/null 2>&1
    terraform providers lock -platform=linux_amd64 -platform=darwin_amd64 -platform=windows_amd64
    
    # Check Go modules
    log_info "Checking Go module updates..."
    if [ -f go.mod ]; then
        go list -u -m all | grep -E '\[.*\]$' || log_info "No Go module updates available"
    fi
    
    # Check GitHub Actions
    log_info "Checking GitHub Actions updates..."
    find .github/workflows -name "*.yml" -o -name "*.yaml" | \
        xargs grep -h "uses:" | \
        sed 's/.*uses: *//;s/ *#.*//' | \
        sort -u | \
        while read -r action; do
            echo "Action: $action"
        done
    
    log_success "Update check completed"
}

# Validate dependencies
validate_deps() {
    log_info "Validating current dependencies..."
    
    cd "$PROJECT_ROOT"
    
    # Validate Terraform
    log_info "Validating Terraform configuration..."
    terraform fmt -check -recursive
    terraform init
    terraform validate
    
    # Validate examples
    log_info "Validating examples..."
    for example in examples/*/; do
        if [ -d "$example" ]; then
            log_info "Validating example: $example"
            cd "$example"
            terraform init
            terraform validate
            cd "$PROJECT_ROOT"
        fi
    done
    
    # Validate Go modules
    if [ -f go.mod ]; then
        log_info "Validating Go modules..."
        go mod verify
        go mod tidy
    fi
    
    log_success "Dependency validation completed"
}

# Run tests with current dependencies
test_deps() {
    log_info "Running tests with current dependencies..."
    
    cd "$PROJECT_ROOT"
    
    # Run Go tests if available
    if [ -f go.mod ]; then
        log_info "Running Go tests..."
        go test -v -timeout 10m ./test/... || {
            log_error "Go tests failed"
            return 1
        }
    fi
    
    # Run Terraform validation tests
    log_info "Running Terraform validation tests..."
    terraform fmt -check -recursive || {
        log_error "Terraform format check failed"
        return 1
    }
    
    log_success "All tests passed"
}

# Run security scans
security_scan() {
    log_info "Running security scans on dependencies..."
    
    cd "$PROJECT_ROOT"
    
    # Run Trivy scan if available
    if command -v trivy &> /dev/null; then
        log_info "Running Trivy filesystem scan..."
        trivy fs . --format table
    else
        log_warning "Trivy not installed, skipping security scan"
        log_info "Install with: brew install trivy"
    fi
    
    # Check Go vulnerabilities if available
    if [ -f go.mod ] && command -v govulncheck &> /dev/null; then
        log_info "Running Go vulnerability check..."
        govulncheck ./...
    elif [ -f go.mod ]; then
        log_warning "govulncheck not installed, skipping Go vulnerability scan"
        log_info "Install with: go install golang.org/x/vuln/cmd/govulncheck@latest"
    fi
    
    log_success "Security scan completed"
}

# Update Terraform providers manually
update_terraform() {
    log_info "Updating Terraform providers..."
    
    cd "$PROJECT_ROOT"
    terraform init -upgrade
    terraform providers lock -platform=linux_amd64 -platform=darwin_amd64 -platform=windows_amd64
    
    log_success "Terraform providers updated"
}

# Update Go dependencies
update_go() {
    log_info "Updating Go dependencies..."
    
    cd "$PROJECT_ROOT"
    if [ -f go.mod ]; then
        go get -u ./...
        go mod tidy
        log_success "Go dependencies updated"
    else
        log_warning "No go.mod file found"
    fi
}

# Update GitHub Actions
update_actions() {
    log_info "GitHub Actions should be updated via Dependabot PRs"
    log_info "Check .github/dependabot.yml configuration"
    
    # List current actions
    log_info "Current GitHub Actions in use:"
    find .github/workflows -name "*.yml" -o -name "*.yaml" | \
        xargs grep -h "uses:" | \
        sed 's/.*uses: *//;s/ *#.*//' | \
        sort -u
}

# Simulate Dependabot PR validation
simulate_pr() {
    log_info "Simulating Dependabot PR validation..."
    
    # Run all validation steps
    validate_deps || return 1
    test_deps || return 1
    security_scan || return 1
    
    log_success "All Dependabot PR validation checks passed!"
}

# Main script logic
main() {
    case "${1:-help}" in
        check-updates)
            check_updates
            ;;
        validate-deps)
            validate_deps
            ;;
        test-deps)
            test_deps
            ;;
        security-scan)
            security_scan
            ;;
        update-terraform)
            update_terraform
            ;;
        update-go)
            update_go
            ;;
        update-actions)
            update_actions
            ;;
        simulate-pr)
            simulate_pr
            ;;
        help|*)
            usage
            ;;
    esac
}

# Run main function
main "$@"
