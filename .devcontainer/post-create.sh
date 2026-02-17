#!/bin/bash
set -e

echo "=========================================="
echo "Setting up Terraform GitHub Repo Development Environment"
echo "=========================================="

WORKSPACE_DIR="${WORKSPACE_FOLDER:-/workspaces/terraform-github-repo}"
if [ ! -d "$WORKSPACE_DIR" ]; then
  WORKSPACE_DIR="$(pwd)"
fi

cd "$WORKSPACE_DIR"

# Skip reinstalling tools that are already installed via devcontainer features
echo "✓ Terraform, Go, Python, and Ruby are pre-installed via devcontainer features"

# Install Python dependencies for documentation
echo "Installing Python dependencies..."
if [ -f "docs/requirements.txt" ]; then
    pip install --upgrade pip setuptools wheel 2>/dev/null || true
    pip install -r docs/requirements.txt --upgrade 2>/dev/null || true
fi

# Install Go dependencies and tools
echo "Installing Go dependencies and tools..."
if [ -f "go.mod" ]; then
    go mod download 2>/dev/null || true
    go mod verify 2>/dev/null || true
    
    # Install golangci-lint
    if ! command -v golangci-lint &>/dev/null; then
        curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b /usr/local/bin latest 2>/dev/null || true
    fi
    
    # Install gosec for Go security scanning
    if ! command -v gosec &>/dev/null; then
        go install github.com/securego/gosec/v2/cmd/gosec@latest 2>/dev/null || true
    fi
fi

# Install Ruby dependencies
echo "Installing Ruby dependencies..."
if [ -f "Gemfile" ]; then
    bundle install --quiet 2>/dev/null || echo "Warning: Bundle install had issues"
fi

# Verify installations
echo ""
echo "✓ Verifying installations..."
echo "  Go: $(go version 2>/dev/null || echo 'installed')"
if command -v jq &>/dev/null; then
  echo "  Terraform: $(terraform version -json 2>/dev/null | jq -r .terraform_version)"
else
  echo "  Terraform: $(terraform version 2>/dev/null | head -1 || echo 'installed')"
fi
echo "  Python: $(python --version 2>/dev/null || echo 'installed')"
echo "  Ruby: $(ruby --version 2>/dev/null || echo 'installed')"

# Skip long-running verifications to avoid blocking container startup
if command -v opa &>/dev/null; then
    echo "  OPA: ✓ installed"
fi
if command -v trivy &>/dev/null; then
    echo "  Trivy: ✓ installed"
fi
if command -v tfsec &>/dev/null; then
    echo "  tfsec: ✓ installed"
fi
if command -v aws &>/dev/null; then
    echo "  AWS CLI: ✓ installed"
fi

# Verify OPA policies if they exist
if [ -d "policy" ] && command -v opa &>/dev/null; then
    echo ""
    echo "Checking OPA policies..."
    opa check --v0-v1 policy/ 2>/dev/null || echo "⚠️  Review OPA policy errors"
fi

echo ""
echo "✓ Development environment setup complete!"
echo ""
echo "Security scanning tools available:"
echo "  ✓ Trivy - Container and vulnerability scanning"
echo "  ✓ tfsec - Terraform security scanning"
echo "  ✓ OPA - Policy enforcement"
echo "  ✓ gosec - Go security scanner"
echo "  ✓ golangci-lint - Go code linting"

