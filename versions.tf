terraform {
  required_providers {
    github = {
      source  = "hashicorp/github"
      version = ">= 6.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "github" {
  # Configuration options (token, owner, etc.)
}
