

module "repo" {
  source = "../../../"
  name   = var.name
  owners = var.owners
}


output "repository_name" {
  value = module.repo.repository_name
}


variable "name" {
  type = string
}

variable "owners" {
  type = list(string)
}


