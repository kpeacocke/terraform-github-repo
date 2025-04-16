terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "github" {
  # Configuration options (token, owner, etc.)
}
