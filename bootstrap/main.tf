// Bootstrap module: placeholder for repo initialization tasks

variable "repository" {
  description = "The GitHub repository name"
  type        = string
}

variable "branch" {
  description = "The default branch name"
  type        = string
}

resource "null_resource" "bootstrap" {
  triggers = {
    repository = var.repository
    branch     = var.branch
  }
}
