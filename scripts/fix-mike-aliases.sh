#!/bin/bash
# Fixes issues with mike aliases in MkDocs deployments
# Usage: ./scripts/fix-mike-aliases.sh

set -e

echo "==== Mike Alias Conflict Resolution Tool ===="

# Check if jq is available
if ! command -v jq &> /dev/null; then
    echo "Warning: jq is not installed. Will use grep/sed fallbacks."
    JQ_AVAILABLE=false
else
    JQ_AVAILABLE=true
fi

# Get the latest version tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.1.0")
echo "Latest version: $LATEST_TAG"

# Store current branch to return to it later
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "Current branch: $CURRENT_BRANCH"

# Check if gh-pages branch exists
if git ls-remote --exit-code origin gh-pages &>/dev/null; then
  echo "gh-pages branch exists, checking for existing aliases..."
  
  # Check out gh-pages branch temporarily
  git fetch origin gh-pages
  git checkout gh-pages || {
    echo "Failed to checkout gh-pages, trying to create it"
    git checkout -b gh-pages origin/gh-pages || {
      echo "Cannot create gh-pages branch. This is normal for first deployment."
      git checkout $CURRENT_BRANCH
      echo "No conflicts to fix yet."
      exit 0
    }
  }
  
  if [ -f ".mike" ]; then
    echo "Found .mike file, checking for aliases..."
    cat .mike
    
    # Check if 'latest' is both an alias and a version
    if grep -q '"latest":' .mike && grep -q '"version": "latest"' .mike; then
      echo "CONFLICT DETECTED: 'latest' is used as both a version name and an alias."
      
      # Completely rebuild the .mike file to avoid issues
      echo "Creating backup of .mike file..."
      cp .mike .mike.bak
      
      if [ "$JQ_AVAILABLE" = true ]; then
        echo "Using jq to rebuild .mike file..."
        # Extract all versions except 'latest'
        VERSIONS=$(jq '.versions | map(select(.version != "latest"))' .mike)
        
        # Create new .mike file with only versions (no aliases)
        jq --argjson vers "$VERSIONS" '{"versions": $vers}' .mike.bak > .mike.new
        mv .mike.new .mike
        HAS_CHANGES=true
      else
        # Fallback to grep if jq is not available
        echo "Using grep to rebuild .mike file..."
        grep -v '"latest":' .mike | grep -v '"version": "latest"' > .mike.tmp
        mv .mike.tmp .mike
        HAS_CHANGES=true
      fi
      # Commit changes if needed
      if [ "$HAS_CHANGES" = true ]; then
        git add .mike
        git commit -m "fix: resolved 'latest' alias/version conflict in mike configuration"
        git push origin gh-pages
        echo "✅ Fixed mike alias/version conflicts and pushed changes"
      fi
      
      # Wait a moment for file system sync
      sleep 2
      
      # Verify fix
      if [ -f ".mike" ]; then
        echo "Current .mike file content after fix:"
        cat .mike
      fi
    else
      echo "No alias/version collision found for 'latest'"
    fi
  else
    echo "No .mike file found, no conflicts to fix."
  fi
  
  # Return to the original branch
  git checkout $CURRENT_BRANCH
else
  echo "gh-pages branch doesn't exist yet, no conflicts to fix."
fi

echo "Mike alias conflicts resolution complete!"
echo "If problems persist, manually edit the .mike file or delete the gh-pages branch and redeploy."
