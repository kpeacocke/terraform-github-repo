variable "enable_dependabot_autoapprove" {
  description = "Enable workflow to auto-approve and auto-merge Dependabot PRs."
  type        = bool
  default     = true
}
variable "allow_auto_merge" {
  description = "Allow auto-merge for pull requests (including Dependabot)."
  type        = bool
  default     = true
}

variable "enable_dependabot_automerge_minor" {
  description = "Enable Dependabot auto-merge for minor upgrades."
  type        = bool
  default     = true
}
## --- FLATTENED MODULE VARIABLES ---
## These variables were merged from all submodules for single-module publishing.

variable "branch" {
  description = "The branch to commit files to."
  type        = string
  default     = "main"
}

## --- Variables from bootstrap ---
## (repository, owners, license, security_contact, languages already present)

## --- Variables from ci ---

## --- Variables from gitflow ---

## --- Variables from security ---
variable "enable_secret_scanning" {
  description = "Enable secret scanning for the repository via workflow."
  type        = bool
  default     = true
}

variable "enable_secret_scanning_push_protection" {
  description = "Enable secret scanning push protection for the repository via workflow."
  type        = bool
  default     = true
}

variable "enable_dependabot_alerts" {
  description = "Enable Dependabot alerts for the repository via workflow."
  type        = bool
  default     = true
}

variable "enable_dependabot_security_updates" {
  description = "Enable Dependabot security updates for the repository via workflow."
  type        = bool
  default     = true
}

variable "require_codeql_workflow" {
  description = "Require that the CodeQL workflow exists in the repository."
  type        = bool
  default     = true
}
variable "name" {
  description = "The name of the GitHub repository to create."
  type        = string
}

variable "owners" {
  description = "List of GitHub users or teams who should be set as CODEOWNERS."
  type        = list(string)

  validation {
    condition     = length(var.owners) > 0
    error_message = "You must provide at least one CODEOWNER."
  }
}

variable "visibility" {
  description = "Whether the repository should be 'private' or 'public'."
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public"], var.visibility)
    error_message = "Visibility must be either 'private' or 'public'."
  }
}

variable "enforce_gitflow" {
  description = "Whether to enforce GitFlow naming and branch protection rules."
  type        = bool
  default     = false
}


variable "enforce_security" {
  description = "Enable security tools such as CodeQL scanning and Dependabot alerts."
  type        = bool
  default     = false
}


variable "bootstrap_with_templates" {
  description = "If true, initialize the repo with standard files like README.md, LICENSE, SECURITY.md."
  type        = bool
  default     = true
}


variable "enforce_project_board" {
  description = "If true, link issues and PRs to a GitHub project board."
  type        = bool
  default     = false
}


variable "traceability_enabled" {
  description = "Enable traceability enforcement such as issue states, assignments, or labels."
  type        = bool
  default     = false
}

variable "enable_weekly_reporting" {
  description = "If true, adds stale issue management and OpenSSF Scorecard workflows."
  type        = bool
  default     = false
}

variable "license" {
  description = "The open source license to apply (MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0)."
  type        = string
  default     = "MIT"

  validation {
    condition = contains(
      ["MIT", "Apache-2.0", "GPL-3.0", "BSD-3-Clause", "MPL-2.0"],
      var.license
    )
    error_message = "License must be one of: MIT, Apache-2.0, GPL-3.0, BSD-3-Clause, MPL-2.0"
  }
}

variable "security_contact" {
  description = "Email or contact address to report security issues."
  type        = string
  default     = "security@your-org.com"
}

variable "enable_auto_labeling" {
  description = "If true, automatically labels PRs and issues based on file paths or content."
  type        = bool
  default     = false
}


variable "github_project_url" {
  description = "The full URL of the GitHub project to attach issues/PRs to."
  type        = string
  default     = ""
}

variable "enforce_branch_naming" {
  description = "If true, enables branch naming convention enforcement (e.g. feature/*)"
  type        = bool
  default     = false
}

variable "enforce_semantic_pr_title" {
  description = "If true, enforces semantic PR titles via GitHub Actions"
  type        = bool
  default     = false
}


variable "languages" {
  description = "List of programming languages in use (for CodeQL, Dependabot, .gitignore)"
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for lang in var.languages : contains([
        "javascript", "typescript", "python", "go", "java", "ruby", "csharp",
        "cpp", "kotlin", "php", "rust", "swift", "perl", "hcl", "r"
      ], lower(trimspace(lang)))
    ])
    error_message = "Each language must be one of: javascript, typescript, python, go, java, ruby, csharp, cpp, kotlin, php, rust, swift, perl, hcl, r"
  }
}


variable "enable_coverage" {
  description = "Enable test coverage reporting"
  type        = bool
  default     = false
}

variable "enable_matrix" {
  description = "If true, use a version matrix for test workflows"
  type        = bool
  default     = false
}


variable "language_default_versions" {
  description = "Map of default single-version values for each language"
  type        = map(string)
  default = {
    go         = "1.21"
    python     = "3.11"
    javascript = "20"
    typescript = "20"
  }
}

variable "language_matrix_versions" {
  description = "Map of version lists for matrix testing per language"
  type        = map(list(string))
  default = {
    go         = ["1.20", "1.21", "1.22"]
    python     = ["3.9",  "3.10", "3.11"]
    javascript = ["16",   "18",   "20"]
    typescript = ["4.5",  "4.6",  "4.7"]
  }
}

variable "coverage_threshold" {
  description = "Minimum coverage threshold to enforce (as percentage)"
  type        = number
  default     = 80
}