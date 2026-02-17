#!/bin/bash
# Quick setup script for initializing dev container configuration
# Run this script once after cloning the repository

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🚀 Initializing Dev Container Configuration"
echo "==========================================="

# Check if templates exist
if [ ! -f "$REPO_ROOT/.env.template" ]; then
    echo "❌ .env.template not found in repository root"
    exit 1
fi

# Create .env if it doesn't exist
if [ ! -f "$REPO_ROOT/.env" ]; then
    echo "📝 Creating .env from template..."
    cp "$REPO_ROOT/.env.template" "$REPO_ROOT/.env"
    echo "   Created: $REPO_ROOT/.env"
    echo ""
    echo "⚠️  Please edit .env with your actual values:"
    echo "   - GITHUB_TOKEN"
    echo "   - AWS configuration (optional)"
    echo "   - Terraform variables"
else
    echo "✓ .env already exists"
fi

# Check if custom devcontainer.json already exists
if [ -f "$SCRIPT_DIR/devcontainer.json" ] && [ -f "$SCRIPT_DIR/devcontainer.template.json" ]; then
    # Both exist - offer to skip
    echo ""
    echo "✓ devcontainer.json already configured"
    echo "  (To reset to defaults, delete and copy from devcontainer.template.json)"
elif [ ! -f "$SCRIPT_DIR/devcontainer.json" ] && [ -f "$SCRIPT_DIR/devcontainer.template.json" ]; then
    # Only template exists, copy it
    echo "📋 Creating devcontainer.json from template..."
    cp "$SCRIPT_DIR/devcontainer.template.json" "$SCRIPT_DIR/devcontainer.json"
    echo "   Created: $SCRIPT_DIR/devcontainer.json"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Edit .env with your configuration"
echo "2. Open the project in VS Code"
echo "3. Run: Dev Containers: Reopen in Container"
echo ""
echo "For detailed instructions, see:"
echo "  - .devcontainer/README.md (quick reference)"
echo "  - .devcontainer/DEVELOPMENT.md (detailed guide)"
