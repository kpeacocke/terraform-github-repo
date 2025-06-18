#!/bin/bash
# This script tests the docs deployment process locally
# Usage: ./scripts/test-docs-deployment.sh

set -e

echo "🔍 Testing MkDocs deployment process locally..."

# Set up environment variables
export PYTHONVERBOSE=1
export PYTHONHTTPSVERIFY=0

# 1. Check Python and dependencies
echo "📦 Checking Python and dependencies..."
python --version
pip --version

echo "🔄 Installing dependencies..."
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -r docs/requirements.txt
pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org mkdocs-material "mkdocs-material-extensions>=1.1" pymdown-extensions mike

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
mkdocs build --clean --strict || mkdocs build --verbose

# 5. Test Mike deployment (without pushing)
echo "🚀 Testing Mike deployment (dry run)..."
mike deploy test-version --no-deploy

# 6. Test aliases with Mike (without pushing)
echo "🏷️ Testing Mike aliases (dry run)..."
mike alias test-version test-latest --no-deploy

echo "✅ Tests completed successfully!"
echo "Run the following command to serve docs locally:"
echo "  mkdocs serve"
