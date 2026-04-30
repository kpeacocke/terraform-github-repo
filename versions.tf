terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.6"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
  required_version = ">= 1.5.0"
}

