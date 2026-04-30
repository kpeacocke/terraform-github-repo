#!/bin/bash
# This script runs every time the dev container starts

WORKSPACE_DIR="${WORKSPACE_FOLDER:-/workspaces/terraform-github-repo}"
if [ ! -d "$WORKSPACE_DIR" ]; then
    WORKSPACE_DIR="$(pwd)"
fi

# Load environment variables if .env file exists
if [ -f "$WORKSPACE_DIR/.env" ]; then
    set -a
    source "$WORKSPACE_DIR/.env" 2>/dev/null || true
    set +a
    echo "✓ Loaded environment variables from .env"
fi

# Verify critical tools are available
TOOLS=("terraform" "go" "python" "ruby")
MISSING=()

for tool in "${TOOLS[@]}"; do
    if ! command -v "$tool" &>/dev/null; then
        MISSING+=("$tool")
    fi
done

if [ ${#MISSING[@]} -gt 0 ]; then
    echo "⚠️  Missing required tools: ${MISSING[*]}"
fi

# Verify Go modules if present
if [ -f "$WORKSPACE_DIR/go.mod" ]; then
    cd "$WORKSPACE_DIR"
    go mod verify 2>/dev/null || echo "⚠️  Go modules verification failed"
fi

terraform_version="not installed"
if command -v terraform &>/dev/null; then
    if command -v jq &>/dev/null; then
        terraform_version="$(terraform version -json 2>/dev/null | jq -r .terraform_version)"
    else
        terraform_version="$(terraform version 2>/dev/null | head -1)"
    fi
fi

echo "✓ Development container ready!"
echo "  Workspace: $WORKSPACE_DIR"
echo "  Go: $(go version | cut -d' ' -f3)"
echo "  Terraform: $terraform_version"
echo "  Python: $(python --version | cut -d' ' -f2)"

