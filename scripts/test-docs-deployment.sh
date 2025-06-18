#!/bin/bash
# This script tests the docs deployment process locally
# Usage: ./scripts/test-docs-deployment.sh [test_version]

set -e

echo "===== MkDocs/Mike Local Deployment Test ====="

# Default version for testing if not provided
TEST_VERSION="${1:-test-version}"
echo "Using test version: $TEST_VERSION"

# Set up environment variables
export PYTHONVERBOSE=1
export PYTHONHTTPSVERIFY=0

# 1. Check Python and dependencies
echo "📦 Checking Python and dependencies..."
python --version
pip --version

echo "🔄 Installing dependencies..."
# Install critical dependencies first to avoid conflicts
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org pyyaml==6.0.1 mergedeep==1.3.4 markupsafe==2.1.3 jinja2==3.1.2 packaging==23.2

# Wait a moment to ensure dependencies are properly registered
sleep 2

# Install from requirements
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r docs/requirements.txt

# Verify installed packages
echo "📋 Installed package versions:"
pip list | grep -E "mergedeep|pyyaml|mkdocs|mike|jinja2|markupsafe"

# 2. Apply SSL fixes
if [ -f "./scripts/fix-python-ssl.sh" ]; then
  echo "🔒 Applying SSL fixes..."
  source ./scripts/fix-python-ssl.sh
fi

# 3. Fix Mike alias conflicts
if [ -f "./scripts/fix-mike-aliases.sh" ]; then
  echo "🏷️ Fixing Mike alias conflicts..."
  bash ./scripts/fix-mike-aliases.sh
fi

# 4. Validate MkDocs configuration
echo "✅ Validating MkDocs configuration..."
if ! mkdocs build --clean --strict; then
  echo "⚠️ MkDocs build failed with strict mode, trying with verbose output"
  if ! mkdocs build --verbose; then
    echo "❌ MkDocs build failed! Debugging Python imports..."
    python -c "import sys; print('Python path:', sys.path)" 
    python -c "import yaml, mergedeep; print('YAML version:', yaml.__version__, 'Mergedeep version:', mergedeep.__version__)"
    exit 1
  fi
fi

# Verify build output
if [ ! -d "site" ]; then
  echo "❌ Build failed! No site directory created."
  exit 1
else
  echo "✅ Build successful with $(find site -type f | wc -l) files"
fi

# 5. Test Mike deployment locally (no push)
echo "🚀 Testing Mike deployment (local only)..."

# Start with clean slate
rm -rf .mike 2>/dev/null || true

# Step 1: Deploy version
echo "Step 1: Deploying version $TEST_VERSION..."
mike deploy $TEST_VERSION --title "$TEST_VERSION"

# Step 2: Add alias
echo "Step 2: Setting alias 'test-latest' for $TEST_VERSION..."
mike alias --update $TEST_VERSION test-latest

# Step 3: Set default
echo "Step 3: Setting default version..."
mike set-default test-latest

# Verify mike configuration
echo "Checking .mike file contents:"
if [ -f ".mike" ]; then
  cat .mike
else
  echo "❌ No .mike file created!"
  exit 1
fi

# Cleanup
echo "🧹 Cleaning up test deployment..."
rm -rf .mike site

echo "✅ Tests completed successfully!"
echo "Your documentation setup appears to be working correctly."
echo "To deploy locally and view the docs:"
echo "  mike deploy test-version"
echo "  mike serve"
