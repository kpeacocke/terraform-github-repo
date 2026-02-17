# Development Container Setup

This directory contains the development container configuration for the Terraform GitHub Repo project.

## Quick Start

### Prerequisites
- Docker Desktop (Windows/Mac) or Docker Engine (Linux)
- VS Code with the "Dev Containers" extension (ms-vscode-remote.remote-containers)

### Opening the Project in a Dev Container

1. Open the project in VS Code
2. Press `F1` and search for "Dev Containers: Reopen in Container"
3. Wait for the container to build and start (first time may take 5-10 minutes)
4. Once started, the environment will automatically:
   - Install all Go, Python, Ruby, and Terraform dependencies
   - Verify all installations
   - Load environment variables from `.env` (if present)

## Features

The dev container includes:

### Languages & Runtimes
- **Go** 1.25.0 - For testing with Terratest
- **Python** 3.x - For documentation and automation scripts
- **Ruby** - For Kitchen-Terraform and InSpec testing
- **Node.js** - For additional tooling
- **Terraform** 1.5.7 - Infrastructure as Code

### Tools & Utilities
- **OPA (Open Policy Agent)** - For policy validation
- **AWS CLI v2** - For AWS interactions
- **Docker CLI** - For running containerized tests
- **Git** - Version control
- **GitHub CLI** - GitHub interactions
- **jq** - JSON processing

### VS Code Extensions
- Terraform (HashiCorp)
- Go (Microsoft)
- Python (Microsoft)
- Ruby (Rebornix)
- Docker (Microsoft)
- Git Lens
- GitHub Copilot
- And more...

### Pre-configured Settings
- Go formatting and linting
- Python formatting (Black)
- Terraform formatting
- Ruby linting (Rubocop)
- Test coverage visualization
- Docker integration

## File Structure

```
.devcontainer/
├── Dockerfile              # Multi-platform Docker image definition
├── Dockerfile.minimal      # Lightweight alternative image
├── devcontainer.json       # Main VS Code dev container configuration
├── devcontainer.template.json  # Customizable configuration template
├── post-create.sh          # Script runs once after container creation
├── post-start.sh           # Script runs every time container starts
├── README.md               # This file
└── DEVELOPMENT.md          # Detailed development workflows

(workspace root)
└── .env.template           # Environment variables template
```

## Customization

### Using the Configuration Template

The `devcontainer.template.json` file provides a starting point for custom configurations. To create a custom setup:

1. Copy `devcontainer.template.json` to `devcontainer.json`
2. Modify the settings as needed
3. Rebuild the container: `Dev Containers: Rebuild Container`

### Environment Variables Template

Copy the template and customize:

```bash
cp .env.template .env
```

Edit `.env` with your specific values. The file is git-ignored and automatically loaded.

## Available Tasks

Once in the container, you can run tasks via VS Code:

- **Go Test Coverage**: Runs Go tests with coverage report
- **Go Test with Long Timeout**: Runs all Go tests
- **OPA Format**: Formats OPA policy files
- **OPA Check**: Validates OPA policies
- **Kitchen Test - Plan**: Runs Kitchen-Terraform plan tests
- **Kitchen Verify - Integration Tests**: Runs InSpec integration tests
- **Kitchen Destroy**: Cleans up test infrastructure

Run tasks with `Ctrl+Shift+P` → "Tasks: Run Task"

## Environment Variables

Create a `.env` file in the workspace root for environment-specific settings. Use the provided template:

```bash
cp ../.env.template ../.env
# Then edit ../.env with your values
```

Example `.env`:
```bash
# GitHub Token (optional)
GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx

# AWS Credentials (optional)
AWS_PROFILE=default
AWS_REGION=us-east-1

# Terraform Variables
TF_VAR_org_name=my-org
TF_VAR_repo_name=my-repo
```

See [`../.env.template`](../.env.template) for all available configuration options.

## Network & Ports

The following ports are forwarded to your local machine:

- `8000` - MkDocs documentation
- `8080` - Development server
- `3000` - Node.js server

## Platform Support

This dev container is designed for multi-platform support:

- **Linux**: amd64, arm64 (including Apple Silicon via Rosetta)
- **Windows**: Docker Desktop with WSL 2
- **macOS**: Docker Desktop (Intel and Apple Silicon via buildx)

## Troubleshooting

### Container won't start
- Ensure Docker daemon is running
- Check Docker disk space: `docker system df`
- Rebuild container: Dev Containers: Rebuild Container

### Permission denied errors
- Container runs as non-root user `vscode` with sudo access
- For sensitive operations, use `sudo` command

### Go mod download fails
- Check internet connectivity
- Try: `go clean -modcache` then `go mod download`

### Ruby bundle install fails
- Ensure Gemfile.lock is in version control
- Try: `bundle install --local` first, then without `--local`

### Docker socket not accessible
- Linux: Add vscode user to docker group: `sudo usermod -aG docker vscode`
- Docker Desktop: Ensure "Expose daemon on tcp://localhost:2375 without TLS" is disabled

## Customization

### Adding VS Code Extensions
Edit `devcontainer.json` and add extension IDs to the `customizations.vscode.extensions` array.

### Changing Base Image
Edit `Dockerfile` and modify the `UBUNTU_VERSION` arg (currently `jammy` for Ubuntu 22.04).

### Adding More Ports
Edit `devcontainer.json` and add port numbers to `forwardPorts` array.

### Modifying Dependencies
- **Python**: Update `docs/requirements.txt`
- **Go**: Update `go.mod` and `go.sum`
- **Ruby**: Update `Gemfile`
- **System packages**: Modify `RUN apt-get install` in `Dockerfile`

## Performance Tips

1. **Enable BuildKit**: `export DOCKER_BUILDKIT=1` before building
2. **Use Docker volumes for Go cache**: Pre-configured in devcontainer.json
3. **Mount AWS credentials as read-only**: More secure and faster
4. **Don't commit Docker state**: Only .devcontainer files should be in git

## Architecture

The setup uses:
- Ubuntu 22.04 (Jammy) as base image for broader compatibility
- Multi-architecture builds via docker buildx (supports amd64 and arm64)
- Non-root user for security
- Docker-in-Docker support for containerized testing

## References

- [VS Code Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Development Container Specification](https://containers.dev/)
- [Docker Desktop Installation](https://www.docker.com/products/docker-desktop)

## Support

For issues or improvements, please refer to the project's contribution guidelines in `docs/development/contributing.md`.
