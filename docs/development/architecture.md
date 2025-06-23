# Architecture

This document outlines the architecture of the Terraform GitHub Repository module, explaining its design principles,
components, and implementation details.

## Overall Architecture

The Terraform GitHub Repository module follows a modular design with clear separation of concerns:

```text
terraform-github-repo/
├── main.tf           # Main repository resource and core functionality
├── variables.tf      # Input variables definitions
├── outputs.tf        # Output values
├── versions.tf       # Provider and Terraform version constraints
├── branch.tf         # Branch and branch protection resources
├── security.tf       # Security features (vulnerability alerts, etc.)
├── webhooks.tf       # Webhook configuration
├── files.tf          # File creation and management
├── access.tf         # Collaborator and team access management
└── labels.tf         # Issue label management
```

## Core Components

### 1. Repository Creation

The base repository resource is defined in `main.tf`, which handles:

- Creating the repository
- Configuring basic settings (visibility, description, etc.)
- Setting up repository features (issues, wiki, etc.)

### 2. Branch Management

Branch-related resources are managed in `branch.tf`, including:

- Creating additional branches
- Setting the default branch
- Configuring branch protection rules

### 3. Security Features

Security features are implemented in `security.tf`:

- Vulnerability alerts
- Secret scanning
- Advanced security features (CodeQL, etc.)

### 4. Access Control

Access control is managed in `access.tf`:

- Collaborator management
- Team access and permissions

### 5. Content Management

Repository content is handled in `files.tf`:

- Creating files from templates or string content
- Managing standard files (README, LICENSE, etc.)
- Creating .gitignore and other configuration files

## Design Principles

1. **Modularity**: Each component is isolated for easier maintenance
2. **Extensibility**: Features can be enabled/disabled independently
3. **Sensible defaults**: Secure defaults with optional overrides
4. **Idempotence**: Safe to apply multiple times without side effects
5. **Clean API**: Well-documented variables with clear purposes

## Implementation Details

### Resource Dependencies

The module carefully manages resource dependencies to ensure proper creation order. For example:

- Repository must exist before branches can be created
- Branches must exist before protection rules can be applied

### Conditional Creation

Most resources are conditionally created based on input variables:

- Branch protection is only applied if branch_protection variable is provided
- Files are only created if specified in the files variable

### Error Handling

The module includes logic to handle:

- Repository initialization (auto_init vs template vs empty)
- API limitations and retries
- Proper resource deletion and cleanup

## Extension Points

The module can be extended through:

1. Template repositories
2. Custom file content
3. Webhook integrations
4. Team and collaborator access patterns

## Future Architecture Enhancements

Planned architectural improvements include:

1. Submodules for specialized use cases
2. Enhanced templating capabilities
3. Better integration with GitHub Apps
4. Support for GitHub Enterprise Server
