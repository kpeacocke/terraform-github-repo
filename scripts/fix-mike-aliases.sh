#!/bin/bash
# Fixes issues with mike aliases in MkDocs deployments
# Usage: ./scripts/fix-mike-aliases.sh

# Get the latest version tag
LATEST_TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.1.0")
echo "Latest version: $LATEST_TAG"

# Check if gh-pages branch exists
if git ls-remote --exit-code origin gh-pages &>/dev/null; then
  echo "gh-pages branch exists, checking for existing aliases..."
  
  # Check out gh-pages branch temporarily
  git fetch origin gh-pages
  git checkout gh-pages
  
  if [ -f ".mike" ]; then
    echo "Found .mike file, checking for aliases..."
    cat .mike
    
    # Manually fix alias conflicts if needed
    LATEST_ALIAS_EXISTS=$(grep -c "latest" .mike || echo "0")
    if [ "$LATEST_ALIAS_EXISTS" -gt 0 ]; then
      echo "Latest alias exists, fixing it..."
      # Backup .mike file
      cp .mike .mike.bak
      # Remove the latest alias line
      grep -v "latest" .mike.bak > .mike
      # Commit the changes
      git add .mike
      git commit -m "fix: removed latest alias to avoid collision"
      git push origin gh-pages
    fi
  else
    echo "No .mike file found, no conflicts to fix."
  fi
  
  # Return to the original branch
  git checkout -
else
  echo "gh-pages branch doesn't exist yet, no conflicts to fix."
fi

echo "Mike alias conflicts resolved!"
