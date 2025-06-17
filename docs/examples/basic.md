# Basic Repository Example

This example demonstrates how to create a basic GitHub repository using this module.

## Usage

```hcl
module "basic_github_repo" {
  source  = "kpeacocke/terraform-github-repo/github"
  version = "x.y.z"

  name        = "basic-example"
  description = "A basic GitHub repository created with Terraform"
  visibility  = "public"
  
  auto_init = true
  
  topics = [
    "terraform",
    "example",
    "github"
  ]
}
```

## Features Demonstrated

- Basic repository creation
- Repository initialization with README
- Topic assignment

## How to Apply

1. Copy the example code to your Terraform configuration
2. Replace `x.y.z` with the latest module version
3. Run `terraform init` and `terraform apply`

## Expected Outcome

This example will create a public GitHub repository with:

- A name of "basic-example"
- A description
- An initial README file
- Three topics (terraform, example, github)
