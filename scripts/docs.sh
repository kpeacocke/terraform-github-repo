#!/bin/bash
# Documentation development helper script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is required but not installed."
    exit 1
fi

# Check if pip is installed
if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
    print_error "pip is required but not installed."
    exit 1
fi

# Function to install dependencies
install_deps() {
    print_status "Installing documentation dependencies..."
    pip install -r docs/requirements.txt
    print_status "Dependencies installed successfully!"
}

# Function to serve documentation locally
serve() {
    print_status "Starting local documentation server..."
    print_warning "Press Ctrl+C to stop the server"
    mkdocs serve --dev-addr 127.0.0.1:8000
}

# Function to build documentation
build() {
    print_status "Building documentation..."
    mkdocs build --clean --strict
    print_status "Documentation built successfully in site/ directory"
}

# Function to update API documentation
update_api_docs() {
    print_status "Updating API documentation with terraform-docs..."
    
    # Check if terraform-docs is installed
    if ! command -v terraform-docs &> /dev/null; then
        print_status "Installing terraform-docs..."
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.17.0/terraform-docs-v0.17.0-darwin-amd64.tar.gz
        else
            # Linux
            curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/v0.17.0/terraform-docs-v0.17.0-linux-amd64.tar.gz
        fi
        tar -xzf terraform-docs.tar.gz
        chmod +x terraform-docs
        sudo mv terraform-docs /usr/local/bin/
        rm terraform-docs.tar.gz
    fi
    
    # Create API docs directory
    mkdir -p docs/api
    
    # Generate API documentation
    echo "# Inputs" > docs/api/inputs.md
    echo "" >> docs/api/inputs.md
    echo "This page documents all available input variables for the module." >> docs/api/inputs.md
    echo "" >> docs/api/inputs.md
    terraform-docs markdown table --output-template '{{ .Inputs }}' . >> docs/api/inputs.md
    
    echo "# Outputs" > docs/api/outputs.md  
    echo "" >> docs/api/outputs.md
    echo "This page documents all outputs provided by the module." >> docs/api/outputs.md
    echo "" >> docs/api/outputs.md
    terraform-docs markdown table --output-template '{{ .Outputs }}' . >> docs/api/outputs.md
    
    echo "# Resources" > docs/api/resources.md
    echo "" >> docs/api/resources.md
    echo "This page documents all resources created by the module." >> docs/api/resources.md
    echo "" >> docs/api/resources.md
    terraform-docs markdown table --output-template '{{ .Resources }}' . >> docs/api/resources.md
    
    # Update README.md
    terraform-docs markdown table --output-file README.md --output-mode inject .
    
    print_status "API documentation updated successfully!"
}

# Function to deploy documentation
deploy() {
    print_status "Deploying documentation to GitHub Pages..."
    
    # Check if mike is installed
    if ! command -v mike &> /dev/null; then
        print_error "mike is required for deployment. Install with: pip install mike"
        exit 1
    fi
    
    # Deploy with mike
    mike deploy --push --update-aliases latest
    mike set-default --push latest
    
    print_status "Documentation deployed successfully!"
}

# Function to create a new version
version() {
    if [ -z "$1" ]; then
        print_error "Please provide a version number: ./docs.sh version 1.0.0"
        exit 1
    fi
    
    print_status "Creating documentation version $1..."
    mike deploy --push --update-aliases "$1" latest --title "$1"
    mike set-default --push latest
    print_status "Version $1 created and set as latest!"
}

# Main script logic
case "$1" in
    "install")
        install_deps
        ;;
    "serve")
        serve
        ;;
    "build")
        build
        ;;
    "update")
        update_api_docs
        ;;
    "deploy")
        deploy
        ;;
    "version")
        version "$2"
        ;;
    *)
        echo "Documentation Helper Script"
        echo ""
        echo "Usage: $0 {install|serve|build|update|deploy|version}"
        echo ""
        echo "Commands:"
        echo "  install  - Install documentation dependencies"
        echo "  serve    - Serve documentation locally at http://localhost:8000"
        echo "  build    - Build documentation to site/ directory"
        echo "  update   - Update API documentation with terraform-docs"
        echo "  deploy   - Deploy documentation to GitHub Pages"
        echo "  version  - Create a new documentation version (e.g., version 1.0.0)"
        echo ""
        echo "Examples:"
        echo "  $0 install          # Install dependencies"
        echo "  $0 serve            # Start local development server"
        echo "  $0 update           # Update API docs from Terraform files"
        echo "  $0 version 1.0.0    # Create version 1.0.0"
        exit 1
        ;;
esac
