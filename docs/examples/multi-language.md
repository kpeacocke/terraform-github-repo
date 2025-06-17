# Multi-Language Projects Example

This example demonstrates how to configure a GitHub repository for projects using multiple programming languages.

## Usage

```hcl
module "multi_language_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "multi-language-app"
  description = "Application using multiple programming languages"
  visibility  = "public"
  
  topics = [
    "multi-language",
    "web-app",
    "typescript",
    "golang",
    "python"
  ]
  
  branch_protection = {
    main = {
      required_reviews = 1
      required_checks  = ["frontend-tests", "backend-tests", "integration-tests"]
    }
  }
  
  files = {
    ".github/workflows/frontend.yml" = {
      content = file("${path.module}/templates/workflows/frontend.yml")
    },
    ".github/workflows/backend.yml" = {
      content = file("${path.module}/templates/workflows/backend.yml")
    },
    ".github/workflows/integration.yml" = {
      content = file("${path.module}/templates/workflows/integration.yml")
    },
    "CODEOWNERS" = {
      content = <<-EOT
      # Frontend code
      /frontend/        @org/frontend-team
      *.ts              @org/frontend-team
      *.tsx             @org/frontend-team
      
      # Backend code
      /backend/         @org/backend-team
      *.go              @org/backend-team
      
      # Data processing
      /data-processing/ @org/data-team
      *.py              @org/data-team
      
      # CI/CD
      /.github/         @org/platform-team
      EOT
    }
  }
  
  gitignore_template = "Node"
}
```

## Features Demonstrated

- Repository for multi-language project
- Language-specific workflows
- Code ownership by language/directory
- Required checks for different language components
- Language-appropriate gitignore template

## How to Apply

1. Copy the example code to your Terraform configuration
2. Replace `x.y.z` with the latest module version
3. Create the necessary workflow template files
4. Set up the required teams in your GitHub organization
5. Run `terraform init` and `terraform apply`

## Additional Configuration

For a multi-language project, you might want to add:

- Language-specific linters
- Multiple test workflows
- Dependency management for different languages
