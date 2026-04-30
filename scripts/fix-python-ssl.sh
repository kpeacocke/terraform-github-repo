#!/bin/bash
# This script fixes SSL issues in Python on GitHub Actions runners
# Usage: source ./scripts/fix-python-ssl.sh

# Display Python version and OpenSSL version
echo "Python version:"
python --version
echo "OpenSSL version:"
openssl version

# Check if we're running in GitHub Actions
if [ -n "$GITHUB_ACTIONS" ]; then
  echo "Running in GitHub Actions environment, applying SSL fixes..."
  
  # Set environment variables to work around SSL issues
  export PYTHONHTTPSVERIFY=0
  export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt
  export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
  
  # Verify system CA certificates
  echo "Verifying system CA certificates..."
  ls -la /etc/ssl/certs/ca-certificates.crt || echo "CA certificates not found at expected location"
  
  # Print certificate paths
  echo "SSL_CERT_FILE: $SSL_CERT_FILE"
  echo "REQUESTS_CA_BUNDLE: $REQUESTS_CA_BUNDLE"
  
  # Test SSL with Python
  echo "Testing SSL with Python..."
  python -c "import ssl; print('SSL Module available:', ssl.OPENSSL_VERSION)"
  python -c "import requests; print('Requests module working')" || echo "Requests not installed or error occurred"
  
  echo "SSL fixes applied!"
else
  echo "Not running in GitHub Actions, no fixes needed"
fi
