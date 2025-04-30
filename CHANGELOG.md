# Changelog

All notable changes to this project will be documented in this file automatically by semantic-release

## [1.1.0] - 2025-06-05

### Added

- Refactored `variables.tf` and `outputs.tf` for clarity, registry readiness, and added `try(...)` error handling
- Taskfile `docs` task and Husky pre-commit hook to auto-inject Terraform docs via `terraform-docs`
- Complete `examples/minimal` with local backend config, variables, and outputs

### Changed

- Updated `README.md` for Terraform Registry conventions and integrated `terraform-docs` injection
- `.terraform-docs.yml` fixed to use proper map format for `sections`

### Fixed

- Removed unsupported output attributes (`.html_url`/`.url`)
- Disabled TFLint unused declarations rule to avoid false positives

### Maintenance

- Increased commitlint header length limit to 120 characters
- Tagged and published versions v1.0.0 and v1.1.0
