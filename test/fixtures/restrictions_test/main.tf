
module "repo" {
  source = "../../../modules/github-repo"

  name  = var.name
  owner = var.owner

  # These restriction vars are for testing; the block is commented out in the module
  branch_protection_users = var.branch_protection_users
  branch_protection_teams = var.branch_protection_teams
  branch_protection_apps  = var.branch_protection_apps
}

output "repository_name" {
  value = module.repo.repository_name
}

variable "name" {
  type = string
}

variable "owner" {
  type = string
}

variable "branch_protection_users" {
  type    = list(string)
  default = []
}

variable "branch_protection_teams" {
  type    = list(string)
  default = []
}

variable "branch_protection_apps" {
  type    = list(string)
  default = []
}
