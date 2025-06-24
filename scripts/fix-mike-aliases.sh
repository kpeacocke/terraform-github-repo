#!/bin/bash
# Safely fixes issues with mike aliases in MkDocs deployments without branch switching
# Usage: ./scripts/fix-mike-aliases.sh

set -e

echo "==== Mike Alias Conflict Resolution Tool (Safe Version) ===="

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

# Check if gh-pages branch exists remotely
if ! git ls-remote --exit-code --heads origin gh-pages &>/dev/null; then
  echo "gh-pages branch doesn't exist yet, no conflicts to fix."
  exit 0
fi

# Instead of checking out gh-pages, use a temporary directory
echo "Creating temporary directory to check gh-pages without switching branches..."
TEMP_DIR=$(mktemp -d)
pushd $TEMP_DIR > /dev/null

# Clone only gh-pages branch
if ! git clone --branch gh-pages --single-branch --depth 1 https://${GITHUB_TOKEN:-git}@github.com/${GITHUB_REPOSITORY:-$(git config --get remote.origin.url | sed 's/.*github.com[\/:]//g' | sed 's/\.git$//g')}.git gh-pages-check; then
  echo "Failed to clone gh-pages branch. This could be due to permissions or the branch doesn't exist."
  popd > /dev/null
  rm -rf $TEMP_DIR
  exit 0
fi

cd gh-pages-check

# Check if .mike file exists
if [ ! -f ".mike" ]; then
  echo "No .mike file found, no conflicts to fix."
  popd > /dev/null
  rm -rf $TEMP_DIR
  exit 0
fi

echo "Found .mike file, checking for aliases..."
cat .mike

# Check if 'latest' is both an alias and a version
if grep -q '"latest":' .mike && grep -q '"version": "latest"' .mike; then
  echo "CONFLICT DETECTED: 'latest' is used as both a version name and an alias."
  
  # Create backup
  cp .mike .mike.bak
  HAS_CHANGES=false
  
  if [ "$JQ_AVAILABLE" = true ]; then
    echo "Using jq to rebuild .mike file..."
    # Keep only the versions that are not "latest"
    VERSIONS=$(jq '.versions | map(select(.version != "latest"))' .mike)
    # Keep the most recent version's title for the "latest" alias
    LATEST_TITLE=$(jq -r '.versions[0].title // "Latest"' .mike)
    
    # Create a new .mike file with corrected data
    jq --argjson vers "$VERSIONS" --arg title "$LATEST_TITLE" \
      '{"versions": $vers, "aliases": {"latest": {"version": $vers[0].version, "title": $title}}}' .mike.bak > .mike.new
    
    if [ -s .mike.new ]; then
      mv .mike.new .mike
      HAS_CHANGES=true
    else
      echo "Warning: jq operation failed, falling back to simple removal"
      grep -v '"latest":' .mike | grep -v '"version": "latest"' > .mike.tmp
      mv .mike.tmp .mike
      HAS_CHANGES=true
    fi
  else
    echo "Using grep to rebuild .mike file..."
    grep -v '"latest":' .mike | grep -v '"version": "latest"' > .mike.tmp
    mv .mike.tmp .mike
    HAS_CHANGES=true
  fi
  
  # Commit and push changes if needed
  if [ "$HAS_CHANGES" = true ]; then
    git config user.name "${GIT_AUTHOR_NAME:-github-actions[bot]}"
    git config user.email "${GIT_AUTHOR_EMAIL:-41898282+github-actions[bot]@users.noreply.github.com}"
    
    git add .mike
    git commit -m "fix: resolved 'latest' alias/version conflict in mike configuration [skip ci]" || echo "No changes to commit."
    git push || echo "Warning: git push failed (check permissions or CI token)."
    echo "✅ Fixed mike alias/version conflicts and pushed changes"
  
    echo "Current .mike file content after fix:"
    cat .mike
  fi
else
  echo "No alias/version collision found for 'latest'"
fi

# Clean up
popd > /dev/null
rm -rf $TEMP_DIR
echo "Mike alias conflicts resolution complete!"
echo "If problems persist, manually edit the .mike file or delete the gh-pages branch and redeploy."
