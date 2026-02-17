#!/bin/bash

# Script to run mkdocs commands with environment variables from .env file
# Usage: ./scripts/mkdocs-with-env.sh [mkdocs command and arguments]

# Load environment variables from .env file
if [ -f .env ]; then
  echo "Loading environment variables from .env file..."
  set -a
  source .env
  set +a
  
  # Map GITHUB_TOKEN to MKDOCS_GIT_COMMITTERS_APIKEY if needed
  if [ -n "$GITHUB_TOKEN" ] && [ -z "$MKDOCS_GIT_COMMITTERS_APIKEY" ]; then
    echo "Mapping GITHUB_TOKEN to MKDOCS_GIT_COMMITTERS_APIKEY for mkdocs..."
    export MKDOCS_GIT_COMMITTERS_APIKEY="$GITHUB_TOKEN"
  fi
else
  echo "Warning: .env file not found"
fi

# Run mkdocs with the supplied arguments
echo "Running: mkdocs $@"
mkdocs "$@"
