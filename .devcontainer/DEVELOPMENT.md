# Using the Development Container

## Getting Started

### 1. Install Prerequisites

**Windows:**
- [Docker Desktop for Windows](https://docs.docker.com/desktop/install/windows-install/) with WSL 2
- [VS Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

**macOS:**
- [Docker Desktop for Mac](https://docs.docker.com/desktop/install/mac-install/)
- [VS Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

**Linux:**
- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [VS Code](https://code.visualstudio.com/)
- [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

### 2. Open Project in Container

1. Clone or open the repository in VS Code
2. Press `Ctrl/Cmd+Shift+P` to open the command palette
3. Search for and select "Dev Containers: Reopen in Container"
4. Wait for the container to build and start

The first build may take 5-10 minutes depending on your internet speed and machine.

## Choosing Your Configuration

### Standard Configuration (Default)
Use this for complete development with all tools:
```bash
# Automatically selected when opening in container
# Uses: Dockerfile (full-featured)
```

**Includes:**
- All languages and tools
- OPA, AWS CLI, Docker CLI
- Full VS Code integration
- All documentation tools

### Minimal Configuration
For lightweight development focused on essentials:
```bash
# Manually select Dockerfile.minimal in devcontainer.json
```

Edit `.devcontainer/devcontainer.json`:
```json
{
  "dockerfile": "Dockerfile.minimal"
}
```

Then rebuild the container.

### Docker Compose Configuration
For advanced setups or CI/CD testing:
```bash
cd .devcontainer
docker-compose up -d
docker-compose exec dev bash
```

## Common Workflows

### Running Tests

```bash
# Run all Go tests with coverage
task "Go Test Coverage"

# Run OPA policy validation
task "OPA Check"

# Run integration tests
task "Kitchen Verify - Integration Tests"
```

Or use keyboard shortcut: `Ctrl+Shift+P` → "Tasks: Run Task"

### Working with Terraform

```bash
# Initialize Terraform
terraform init

# Plan changes
terraform plan

# View outputs
terraform output

# Format code
terraform fmt -recursive
```

### Python Development

```bash
# Install/update documentation dependencies
pip install -r docs/requirements.txt -U

# Build and serve documentation locally
mkdocs serve
# Visit http://localhost:8000
```

### Go Development

```bash
# Run specific test
go test ./test/minimal_test.go -v

# Get code coverage
go test -cover ./test/...

# Build binary
go build -o myapp ./cmd/main.go
```

### Ruby/Kitchen Testing

```bash
# List test instances
bundle exec kitchen list

# Run specific test
bundle exec kitchen verify

# Destroy test infrastructure
bundle exec kitchen destroy
```

## Environment Variables

Create a `.env` file in the workspace root:

```bash
# GitHub
GITHUB_TOKEN=ghp_your_token

# AWS
AWS_PROFILE=default
AWS_REGION=us-east-1

# Terraform
TF_VAR_org_name=my-organization
TF_VAR_repo_name=my-repo

# Testing
TEST_TIMEOUT=300
```

The `post-start.sh` script automatically loads these variables when the container starts.

## Extensions Available

The following VS Code extensions are automatically installed:

- **hashicorp.terraform** - Terraform language support
- **ms-vscode.go** - Go support
- **rebornix.ruby** - Ruby support
- **ms-python.python** - Python support
- **charliermarsh.ruff** - Python linter
- **ms-vscode.makefile-tools** - Makefile support
- **ms-azuretools.vscode-docker** - Docker integration
- **eamodio.gitlens** - Git enhanced features
- **redhat.vscode-yaml** - YAML language support
- **GitHub.copilot** - AI assistant

To add more extensions, edit `devcontainer.json`:
```json
"extensions": [
  "publisher.extension-id",
  ...
]
```

Then rebuild the container.

## Debugging

### Enable Go Debugging

```bash
# In VS Code, create .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Connect to Delve",
      "type": "go",
      "mode": "remote",
      "request": "attach",
      "port": 2345,
      "host": "127.0.0.1",
      "showLog": true
    }
  ]
}

# Start test with debugger
dlv test ./test/minimal_test.go
```

### Debug Python Scripts

The Python extension provides debugging out of the box. Set breakpoints and use `F5` to start debugging.

### View Container Logs

```bash
# See what's happening in the container
docker logs -f terraform-github-repo-dev

# Inspect container
docker exec -it terraform-github-repo-dev bash
```

## Managing the Container

### Clean Up

```bash
# Remove container but keep image
Dev Containers: Close and Reopen Locally

# Remove image completely
docker rmi terraform-github-repo-dev
```

### Rebuild Container

When you update Dockerfile or dependencies:

```bash
# Option 1: VS Code Command Palette
Ctrl+Shift+P → Dev Containers: Rebuild Container

# Option 2: Terminal
docker-compose build --no-cache
```

### Container Resources

The container uses Docker's default resource limits. To modify:

**Edit docker-compose.yml:**
```yaml
services:
  dev:
    deploy:
      resources:
        limits:
          cpus: '4'
          memory: 4G
        reservations:
          cpus: '2'
          memory: 2G
```

## Performance Optimization

### 1. Enable Docker BuildKit
```bash
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
```

### 2. Use .dockerignore
Already configured - prevents large files from bulking image.

### 3. Volume Caching
The devcontainer uses `cached` mode for workspace to improve Mac/Windows performance.

### 4. Go Module Caching
Go download cache is persisted in a Docker volume for faster rebuilds.

## Troubleshooting

### Container fails to start

**Check Docker daemon:**
```bash
docker ps
docker info
```

**Check disk space:**
```bash
docker system df
docker system prune -a
```

**Rebuild from scratch:**
```bash
# Remove everything, rebuild
docker-compose down -v
docker-compose build --no-cache
```

### Permission denied on Docker socket

**Linux only:**
```bash
# Inside container as vscode user
docker ps  # Should work

# If not, restart docker daemon
sudo systemctl restart docker
```

### Go modules not downloading

```bash
# Inside container
go clean -modcache
go mod download
go mod verify
```

### Bundle install hangs

```bash
# Clear bundle cache
rm Gemfile.lock
bundle install --verbose
```

### Python dependencies conflict

```bash
# Create fresh virtual environment
python3 -m venv venv
source venv/bin/activate  # or venv\Scripts\activate on Windows
pip install -r docs/requirements.txt
```

## Advanced Usage

### Custom Build Arguments

Edit `devcontainer.json`:
```json
"build": {
  "args": {
    "UBUNTU_VERSION": "focal",
    "GO_VERSION": "1.26.0",
    "TERRAFORM_VERSION": "1.6.0"
  }
}
```

### Mount Additional Volumes

```json
"mounts": [
  "source=${localEnv:HOME}/.aws,target=/home/vscode/.aws,readonly",
  "source=/var/run/docker.sock,target=/var/run/docker.sock",
  "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,readonly"
]
```

### Port Forwarding

Already configured for:
- 8000 (MkDocs)
- 8080 (dev server)
- 3000 (Node.js)

Add more in `devcontainer.json`:
```json
"forwardPorts": [8000, 8080, 3000, 9000]
```

### Environment Secrets

Avoid hardcoding secrets. Use:
1. `.env` file (git-ignored)
2. Docker secrets (for swarm mode)
3. VS Code settings sync (encrypted)

## Resources

- [Dev Container Specification](https://containers.dev/)
- [VS Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker Documentation](https://docs.docker.com/)
- [This Project's Contributing Guide](../docs/development/contributing.md)

## Questions or Issues?

See [CONTRIBUTING.md](../docs/development/contributing.md) for how to report issues or suggest improvements.
