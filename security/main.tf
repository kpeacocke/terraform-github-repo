// Security module: placeholder for CodeQL and other security enforcement
variable "repository" {
  description = "The GitHub repository name"
  type        = string
}

variable "enable_codeql" {
  description = "Enable CodeQL static analysis"
  type        = bool
  default     = false
}

variable "enable_dependabot" {
  description = "Enable Dependabot configuration"
  type        = bool
  default     = false
}

variable "languages" {
  description = "List of languages for CodeQL scanning"
  type        = list(string)
  default     = []
}

// Placeholder resource, actual security workflows generated below
resource "null_resource" "security_placeholder" {
  triggers = { repo = var.repository }
}

// CodeQL analysis workflow
resource "github_repository_file" "codeql_workflow" {
  count = var.enable_codeql && length(var.languages) > 0 ? 1 : 0

  repository          = var.repository
  branch              = "main"
  file                = ".github/workflows/codeql.yml"
  content             = templatefile(
    "${path.module}/../templates/.github/workflows/codeql.yml.tmpl", {
      languages = [for lang in var.languages : lower(trimspace(lang))]
    }
  )
  commit_message      = "ci: add CodeQL workflow"
  overwrite_on_create = true
}

// Dependabot configuration
resource "github_repository_file" "dependabot" {
  count = var.enable_dependabot ? 1 : 0

  repository          = var.repository
  branch              = "main"
  file                = ".github/dependabot.yml"
  content             = templatefile(
    "${path.module}/../templates/.github/workflows/dependabot.yml.tmpl", {}
  )
  commit_message      = "chore: add Dependabot config"
  overwrite_on_create = true
}

// CodeQL workflow
