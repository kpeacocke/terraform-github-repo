#!/bin/bash
# Fixes issues with mike aliases in MkDocs deployments
# Usage: ./scripts/fix-mike-aliases.sh

set -eu

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

# Store current branch or commit to return to it later
if git symbolic-ref -q HEAD >/dev/null; then
  CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
  DETACHED_HEAD=false
else
  CURRENT_BRANCH=$(git rev-parse HEAD)
  DETACHED_HEAD=true
fi
echo "Current branch or commit: $CURRENT_BRANCH"

# Check if gh-pages branch exists
if git ls-remote --exit-code origin gh-pages &>/dev/null; then
  echo "gh-pages branch exists, checking for existing aliases..."
  git fetch origin gh-pages
  # Stash any local changes to avoid checkout errors
  git stash --include-untracked || true
  git checkout gh-pages || {
    echo "Failed to checkout gh-pages, trying to create it"
    git checkout -b gh-pages origin/gh-pages || {
      echo "Cannot create gh-pages branch. This is normal for first deployment."
      # Restore previous state
      if [ "$DETACHED_HEAD" = true ]; then
        git checkout --detach $CURRENT_BRANCH || true
      else
        git checkout $CURRENT_BRANCH || true
      fi
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
        VERSIONS=$(jq '.versions | map(select(.version != "latest"))' .mike)
        jq --argjson vers "$VERSIONS" '{"versions": $vers}' .mike.bak > .mike.new
        mv .mike.new .mike
        HAS_CHANGES=true
      else
        echo "Using grep to rebuild .mike file..."
        grep -v '"latest":' .mike | grep -v '"version": "latest"' > .mike.tmp
        mv .mike.tmp .mike
        HAS_CHANGES=true
      fi
      # Commit changes if needed
      if [ "${HAS_CHANGES:-false}" = true ]; then
        git add .mike
        git commit -m "fix: resolved 'latest' alias/version conflict in mike configuration" || echo "No changes to commit."
        git push origin gh-pages || echo "Warning: git push failed (check permissions or CI token)."
        echo "✅ Fixed mike alias/version conflicts and pushed changes"
      fi
      sleep 2
      if [ -f ".mike" ]; then
        echo "Current .mike file content after fix:"
        cat .mike
      fi
    else
      echo "No alias/version collision found for 'latest'"
    fi
  else
    echo "No .mike file found, no conflicts to fix."
    # In CI, this may be an error if you expect .mike to exist
    if [ "${CI:-false}" = true ]; then
      echo "::error::No .mike file found on gh-pages branch."
      exit 1
    fi
  fi
  # Return to the original branch or commit
  if [ "$DETACHED_HEAD" = true ]; then
    git checkout --detach $CURRENT_BRANCH || true
  else
    git checkout $CURRENT_BRANCH || true
  fi
  git stash pop || true
else
  echo "gh-pages branch doesn't exist yet, no conflicts to fix."
  if [ "${CI:-false}" = true ]; then
    echo "::warning::gh-pages branch does not exist. No alias conflicts to fix."
  fi
fi

echo "Mike alias conflicts resolution complete!"
echo "If problems persist, manually edit the .mike file or delete the gh-pages branch and redeploy."
