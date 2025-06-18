#!/bin/bash

# Script to run mkdocs commands with environment variables from .env file
# Usage: ./scripts/mkdocs-with-env.sh [mkdocs command and arguments]

# Load environment variables from .env file
if [ -f .env ]; then
  echo "Loading environment variables from .env file..."
  set -a
  source .env
  set +a
  
  # Map GITHUB_TOKEN to GIT_COMMITTERS_TOKEN if needed
  if [ -n "$GITHUB_TOKEN" ] && [ -z "$GIT_COMMITTERS_TOKEN" ]; then
    echo "Mapping GITHUB_TOKEN to GIT_COMMITTERS_TOKEN for mkdocs..."
    export GIT_COMMITTERS_TOKEN="$GITHUB_TOKEN"
  fi
else
  echo "Warning: .env file not found"
fi

# Run mkdocs with the supplied arguments
echo "Running: mkdocs $@"
mkdocs "$@"
