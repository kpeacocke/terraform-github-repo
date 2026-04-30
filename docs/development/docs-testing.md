# Documentation Testing Guide

This guide explains how to test the documentation deployment process locally and how to fix common issues.

## Testing Documentation Locally

You can test the documentation locally using the provided test script:

```bash
# Test the docs deployment process without publishing
./scripts/test-docs-deployment.sh

# Serve the documentation locally
mkdocs serve
```

## Common Issues and Solutions

### Python SSL Module Initialization Error

If you encounter SSL module initialization errors, the `fix-python-ssl.sh` script can help:

```bash
source ./scripts/fix-python-ssl.sh
```

This script:

- Sets appropriate SSL environment variables
- Verifies system CA certificates
- Tests SSL connectivity with Python

### MkDocs/Mike Alias Collision

Mike can sometimes have issues with alias collisions. The `fix-mike-aliases.sh` script can help:

```bash
./scripts/fix-mike-aliases.sh
```

This script:

- Checks for existing aliases in the gh-pages branch
- Removes conflicting aliases to avoid deployment errors

## Workflow Integration

Both fixes are integrated into the GitHub Actions workflows:

- `docs.yml` for normal documentation updates
- `release.yml` for versioned documentation during releases

## Manual Deployment

For manual deployment, use the following commands:

```bash
# Deploy a specific version
mike deploy v1.0.0 --push

# Add an alias to a version
mike alias v1.0.0 latest --push

# Set the default version
mike set-default latest --push
```

## Troubleshooting

If you still encounter issues:

1. Check Python and OpenSSL versions
2. Verify mkdocs.yml configuration
3. Clear the site/ directory and .mike state
4. Try manually deleting the gh-pages branch and rebuilding
