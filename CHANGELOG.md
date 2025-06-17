# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-disable MD024 -->

## [1.0.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.1...v1.0.2) (2025-06-17)

### 🐛 Bug Fixes

* update Terraform provider versions in SonarCloud configuration ([7f6b0ee](https://github.com/kpeacocke/terraform-github-repo/commit/7f6b0eedd4de562ae80e620bb48eaa176a476763))


Generating notes for 1.0.2

## [1.0.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.0...v1.0.1) (2025-06-17)

### 🐛 Bug Fixes

* add check for changes before committing coverage report to wiki ([d97aaec](https://github.com/kpeacocke/terraform-github-repo/commit/d97aaec6764e82b27a59609f3a3c39cf18be25f9))


Generating notes for 1.0.1

## 1.0.0 (2025-06-17)

### 🚀 Features

* add .gitignore template and languages variable with validation ([4c8b169](https://github.com/kpeacocke/terraform-github-repo/commit/4c8b169abf4481280d9e47752ba78276e50f70ad))
* add backend configuration section to README ([1e73419](https://github.com/kpeacocke/terraform-github-repo/commit/1e73419db2177fbc67eb44f1b9bd199d16a709ac))
* add bootstrap, CI, GitFlow, security modules and workflows for coverage and documentation ([a67874e](https://github.com/kpeacocke/terraform-github-repo/commit/a67874e871243f3312f816898a29620017b4bed7))
* add branch naming enforcement and related workflow ([48d6697](https://github.com/kpeacocke/terraform-github-repo/commit/48d6697369859c99c8940e5a378d875d6c542d0e))
* add bug report and pull request templates for issue tracking ([9839842](https://github.com/kpeacocke/terraform-github-repo/commit/983984257ee587835a9fa84e818bbd5fa9a35c61))
* add CHANGELOG and semantic-release configuration ([7d6d553](https://github.com/kpeacocke/terraform-github-repo/commit/7d6d5534496f1d1ecb1f0f5324d077981037c31d))
* add CI and release workflows with corresponding templates ([67a1221](https://github.com/kpeacocke/terraform-github-repo/commit/67a122146a3760129fd0f71e26ea02a2100b1bac))
* add CI enforcement workflow to ensure issue integration, documentation, and test changes ([d6d67c6](https://github.com/kpeacocke/terraform-github-repo/commit/d6d67c63169baaf231632a8b8bad4a92c5f4823c))
* add CI workflow for Terraform validation, linting, and security; update README and Taskfile for doc automation ([6c7908c](https://github.com/kpeacocke/terraform-github-repo/commit/6c7908c9caa1ac78be5194065678fda65f5272ea))
* add CODEOWNERS support and related template for GitHub repository module ([651f5b5](https://github.com/kpeacocke/terraform-github-repo/commit/651f5b58509a83cb8b4d7e9c2ae4e2ae57864d1e))
* add CodeQL analysis configuration and integration tests with RSpec ([0359402](https://github.com/kpeacocke/terraform-github-repo/commit/0359402f9b92297cde93f20d3821dd10d3f79fc4))
* add CodeQL configuration and workflow support for multiple languages ([046d486](https://github.com/kpeacocke/terraform-github-repo/commit/046d48685192372b5b079d564989cd725561e9a7))
* add CodeQL security analysis configuration and custom queries for Go ([95ffa17](https://github.com/kpeacocke/terraform-github-repo/commit/95ffa172afa6c4908e1631a3e7b80a77837d8d47))
* add coverage workflow and variables for test coverage reporting ([4d29f84](https://github.com/kpeacocke/terraform-github-repo/commit/4d29f84b5937f071f0096743f426ed3c69fa7246))
* add coverage workflows and update README for coverage integration ([99fb858](https://github.com/kpeacocke/terraform-github-repo/commit/99fb858e6d2daea8387332f1524f81e85a39f3eb))
* add Dependabot configuration and enablement variable ([79b2acf](https://github.com/kpeacocke/terraform-github-repo/commit/79b2acf5ec8d92e6446a8430121adbcdf27927c1))
* add Dependabot configuration and management scripts for automated dependency updates ([d93a2ef](https://github.com/kpeacocke/terraform-github-repo/commit/d93a2ef7be150440edb76f55a3f97c60dd5daba6))
* add disable_actions_until_provisioning variable and update resource counts to manage workflow execution ([644fd3f](https://github.com/kpeacocke/terraform-github-repo/commit/644fd3f9af441d004abb3d73ebc674c3a1a044fa))
* add drift detection to CI workflow and implement ci-check-drift script ([55e4143](https://github.com/kpeacocke/terraform-github-repo/commit/55e41430c0ca6c5d738728f219b76b204eed48ff))
* add enforcement for semantic PR titles via GitHub Actions ([9f4fe12](https://github.com/kpeacocke/terraform-github-repo/commit/9f4fe12567dbdd0f6478bb5e89a87df8ae1dd171))
* add example usage section to README template for better guidance ([9034373](https://github.com/kpeacocke/terraform-github-repo/commit/90343731411a6f87d22ef3c44023948a1741183e))
* add examples, inputs, and outputs sections to README ([95c0f91](https://github.com/kpeacocke/terraform-github-repo/commit/95c0f913a688b8b1449a6be3cb85a7521a4be3a7))
* add GitHub Actions workflow for Go test coverage ([046f008](https://github.com/kpeacocke/terraform-github-repo/commit/046f008b5a7e5c3811798a599b9ad42d353b80b6))
* add GitHub Actions workflow to automatically update Terraform documentation ([2668538](https://github.com/kpeacocke/terraform-github-repo/commit/26685382c0f1f87bcb2e416e73caaa5143f999c4))
* add GitHub Actions workflow to push coverage reports to wiki ([2ff28a5](https://github.com/kpeacocke/terraform-github-repo/commit/2ff28a50dc0f8a4a68fa3ada39b2b600446e263e))
* add GitHub project board integration with auto-linking for issues and PRs ([e78aee7](https://github.com/kpeacocke/terraform-github-repo/commit/e78aee72fdc33322d26481e02cc319c73078b1ea))
* add GitHub repository module with enhanced variables and outputs ([968b799](https://github.com/kpeacocke/terraform-github-repo/commit/968b7991f701ad207c973f151af7f26948529e77))
* add GitHub token and owner variables, implement provisioning wait for Actions permissions ([e67ff93](https://github.com/kpeacocke/terraform-github-repo/commit/e67ff931da42c520bf7870fcb9083385cbcbf5b6))
* add GitHub workflows for scorecard analysis and stale issue management ([5d5f87e](https://github.com/kpeacocke/terraform-github-repo/commit/5d5f87e3b39d5fe86118985642690361eebfe6e2))
* add go.mod file for module management and dependency tracking ([0c2f8f8](https://github.com/kpeacocke/terraform-github-repo/commit/0c2f8f8099122d287625c9a8199b55d75f045d34))
* add initial test specifications for simple and integration tests ([e8b3716](https://github.com/kpeacocke/terraform-github-repo/commit/e8b3716e0a634cfdcb85a49753cbe914834ac70a))
* add issue and pull request templates, and auto-labeling workflows ([dd4a770](https://github.com/kpeacocke/terraform-github-repo/commit/dd4a770b5b623a1e4142dfba8f1bc8d9b4e66c6a))
* add license variable with validation and update module configuration in main.tf ([97c82ea](https://github.com/kpeacocke/terraform-github-repo/commit/97c82eacc17b3de459d46507d2063e09170e2a61))
* add minimal GitHub repository module example with backend and outputs ([117b1bf](https://github.com/kpeacocke/terraform-github-repo/commit/117b1bf2f7a6b4b4de617efa8ac824c73b5e5ecb))
* add module metadata and comprehensive documentation for GitHub repository management ([b495b61](https://github.com/kpeacocke/terraform-github-repo/commit/b495b610e33192409f17ee7aad330f83e2b59997))
* add Node.js setup and markdown linting to CI workflow ([f5bce13](https://github.com/kpeacocke/terraform-github-repo/commit/f5bce131ad1ca40fb467a3a8eb8678ea91f9c143))
* add pre-commit hook for Terraform linting and security checks; configure tflint and tfsec tasks in Taskfile ([faa8c46](https://github.com/kpeacocke/terraform-github-repo/commit/faa8c469fc0828c9535488d513e44a135a9db2d5))
* add README template and resource for GitHub repository module ([829e609](https://github.com/kpeacocke/terraform-github-repo/commit/829e609bbbc0aee2daab1caacf9fb2a85da5a836))
* add release branches and status check contexts variables for GitFlow ([209c8ca](https://github.com/kpeacocke/terraform-github-repo/commit/209c8ca2438f47bfbdaaa6d673697941f920baff))
* add repository initialization variables for GitHub configuration ([5d11d53](https://github.com/kpeacocke/terraform-github-repo/commit/5d11d5350dafc372e4cd8e2652cc27528af452d4))
* add SECURITY.md template and security_contact variable for GitHub repository module ([5a43163](https://github.com/kpeacocke/terraform-github-repo/commit/5a4316308d9eb0822569a53ed943897c284862aa))
* add SonarCloud configuration and update CI workflow for analysis ([cd954bb](https://github.com/kpeacocke/terraform-github-repo/commit/cd954bbcb0b9cffb9ea959abd8b78f14b17f7fd9))
* add template rendering tests for Dependabot, CodeQL, and CI enforcement workflows ([458a64c](https://github.com/kpeacocke/terraform-github-repo/commit/458a64c20767df86f2ac7b17675e2389ba957bf5))
* add Terraform module for GitHub repository management with templates and workflows ([d11848f](https://github.com/kpeacocke/terraform-github-repo/commit/d11848f99853302b994f7d77198504f25641fd30))
* add Terratest job to CI workflow for testing infrastructure ([a31f0ed](https://github.com/kpeacocke/terraform-github-repo/commit/a31f0ed2f3dfb66c3cbed4b1af12d91bbf1bea59))
* add test workflows for Go, Python, JavaScript, and TypeScript with matrix support ([e4ae2c7](https://github.com/kpeacocke/terraform-github-repo/commit/e4ae2c7f2745dcfceea42809269cae751a14a898))
* add traceability enforcement workflow and related templates ([ae304d8](https://github.com/kpeacocke/terraform-github-repo/commit/ae304d824b2550bb999ac9d8e3f78644401264cc))
* add validation for CODEOWNERS variable to ensure at least one owner is provided ([7f6d65b](https://github.com/kpeacocke/terraform-github-repo/commit/7f6d65b1bc18718ac02f17d5ec68f40d5066a861))
* added CONTIBUTING .editorconfig and .nvmrc templates ([d4e0804](https://github.com/kpeacocke/terraform-github-repo/commit/d4e08048ad27f61a2dfb84f3ff9c876aea451a81))
* enhance GitFlow module with detailed variable descriptions for better clarity ([351d9c9](https://github.com/kpeacocke/terraform-github-repo/commit/351d9c91b2d1b33d6658468649528eb97e0792e1))
* enhance GitHub repository module with CODEOWNERS support and CI improvements ([e05f925](https://github.com/kpeacocke/terraform-github-repo/commit/e05f925205087b4ccbcd0f6b286f206be70038fd))
* enhance GitHub repository module with improved Actions management and new variables ([5d63209](https://github.com/kpeacocke/terraform-github-repo/commit/5d632094eedf87a834ce7deb2edc3772f6d25c91))
* enhance GitHub repository module with security features and auto-merge for Dependabot PRs ([e6af657](https://github.com/kpeacocke/terraform-github-repo/commit/e6af6570b5f7f27c8bf861b245054665129096a8))
* enhance outputs with additional repository details and branch protection configurations ([eeb7c45](https://github.com/kpeacocke/terraform-github-repo/commit/eeb7c45b5622ece86e2677908d0508b625b37c10))
* enhance README template with CI, release, and weekly reporting badges ([be9be1a](https://github.com/kpeacocke/terraform-github-repo/commit/be9be1a14e40bae036f43f7d2e5ea242542aa7c9))
* enhance release management with semantic release configuration ([d5169a2](https://github.com/kpeacocke/terraform-github-repo/commit/d5169a265b66719bd6a82afca634ecb569f0a766))
* enhance security module with CodeQL and Dependabot configurations ([727cbd5](https://github.com/kpeacocke/terraform-github-repo/commit/727cbd5cb923810ec9467dbbb11c86ecaa6f68d8))
* implement OPA guardrails and compliance checks in CI, enhance README with policy details ([c678bc4](https://github.com/kpeacocke/terraform-github-repo/commit/c678bc4f7140cc88830e05863bc9c859db923c52))
* implement Terraform state management helpers and clean up test cases ([7cada52](https://github.com/kpeacocke/terraform-github-repo/commit/7cada529ab4a1aaf4df5dc8257aff068872590bd))
* migrate from tfsec to Trivy for enhanced security scanning and reporting ([d1087c2](https://github.com/kpeacocke/terraform-github-repo/commit/d1087c2eeab4c5b7a0b7062cec8d759e4a73dd9d))
* semantic-release setup with commitlint and Husky for automated versioning/changelog management ([a6c87d6](https://github.com/kpeacocke/terraform-github-repo/commit/a6c87d64f437c0d174035ea3dc63ae10f58ff5ab))
* update CI workflow to use matrix for Terraform versions; add SECURITY.md for vuln reporting and sec features ([2a01cc7](https://github.com/kpeacocke/terraform-github-repo/commit/2a01cc7cd9e9836af4b1cfc18d36d0c7532c64f2))
* update default status check contexts for improved clarity and coverage ([ee29f89](https://github.com/kpeacocke/terraform-github-repo/commit/ee29f89a200ed88e1f13127dc8a1a449840379f7))
* update dependabot to support language selection ([6bf70cd](https://github.com/kpeacocke/terraform-github-repo/commit/6bf70cd6d0cd6206c532ef81c20f3cf76ffae736))
* update GitHub repository configuration and add integration tests ([f8f6d03](https://github.com/kpeacocke/terraform-github-repo/commit/f8f6d0348117d358096457f206d3892dd64eb70d))
* update main.tf to include GitHub token and owner variables for API access ([f8fe760](https://github.com/kpeacocke/terraform-github-repo/commit/f8fe760922c50763bb217075cf6b131e31ce4706))
* update validation test to use terraform plan and enhance error handling for missing owners variable ([be27b23](https://github.com/kpeacocke/terraform-github-repo/commit/be27b23ccb24f57bc1663fabb4db4d7e320c2f09))

### 🐛 Bug Fixes

* add custom security queries to CodeQL configuration ([39a84be](https://github.com/kpeacocke/terraform-github-repo/commit/39a84be0e0243aded849efc2f7ac27cdc93dc09e))
* add GitHub owner and repository name as environment variables for Terraform plan and validation ([0535e8d](https://github.com/kpeacocke/terraform-github-repo/commit/0535e8d4ba59c17e9dc4b3f8a697f4cd9b7a6cc4))
* add Terraform setup step and refine Go test command in CI workflow ([70ce56b](https://github.com/kpeacocke/terraform-github-repo/commit/70ce56baecde53fe755ff076452e5357092073cf))
* all required variables are now declared and deprected output removed ([5886ba0](https://github.com/kpeacocke/terraform-github-repo/commit/5886ba03c11cac5b856067de62c34e0afed1b239))
* clean up of old files and path fix ([88c42ca](https://github.com/kpeacocke/terraform-github-repo/commit/88c42ca6dff5e39ee337696d46d92d143aeb26be))
* correct markdown formatting in release automation guide and security hardening documentation ([ba7adec](https://github.com/kpeacocke/terraform-github-repo/commit/ba7adec61b0e0638da6479076d35e615047141fd))
* correct syntax for cloning wiki repository in coverage workflow ([f98ea3a](https://github.com/kpeacocke/terraform-github-repo/commit/f98ea3a6dca08504379c88e7b842d6289ed9d3ec))
* enable GitHub Pages setup and standardize environment name ([343b2ff](https://github.com/kpeacocke/terraform-github-repo/commit/343b2ffc149b2da6154f33f43e52a9f2cd9cd97d))
* enable Go modules and download dependencies in CI workflows ([b83175a](https://github.com/kpeacocke/terraform-github-repo/commit/b83175aa93a8219a45eab94cd9619f712d43010b))
* enhance README with structured navigation table for better usability ([aaaa5e8](https://github.com/kpeacocke/terraform-github-repo/commit/aaaa5e8840663f96890ab0ec088eacf681af1a20))
* enhance SonarCloud integration by setting environment variable and updating scan action ([5fb80ef](https://github.com/kpeacocke/terraform-github-repo/commit/5fb80ef710512e61ca11492177d760ed32d1f456))
* refine Go test command to run only template rendering tests without external dependencies ([b7dbdd3](https://github.com/kpeacocke/terraform-github-repo/commit/b7dbdd3ebb1fe2c01e570a69554719e62198d4fa))
* remove debug environment step from CI workflow to streamline process ([6d8b2dd](https://github.com/kpeacocke/terraform-github-repo/commit/6d8b2dd6b8afdd7648f05b909fb73df993b6b9e7))
* remove deprecated outputs and clean up workflow file references ([99a9ba5](https://github.com/kpeacocke/terraform-github-repo/commit/99a9ba53583cfb700e472b2f259e00ad57c67652))
* remove npm cache option from Node.js setup in workflows ([d8eba74](https://github.com/kpeacocke/terraform-github-repo/commit/d8eba741955bd6b29eaea93fc37005cd92cd6a40))
* remove redundant 'go mod download' step from test workflows ([96bd419](https://github.com/kpeacocke/terraform-github-repo/commit/96bd419a3ea6b930c6864b4c15698076c59991a1))
* remove reviewer assignments from Dependabot configuration ([a53b282](https://github.com/kpeacocke/terraform-github-repo/commit/a53b2821f0c3e2d1a6be2b71cc9981b65fbc116e))
* reorganize README for improved clarity and structure ([fec1c5b](https://github.com/kpeacocke/terraform-github-repo/commit/fec1c5ba99f259b84d2a0c3348d7090e5af7b997))
* replace 'go mod download' with 'go mod tidy' in CI workflows for improved dependency management ([4a4a102](https://github.com/kpeacocke/terraform-github-repo/commit/4a4a102a62741c398dd04d676238f857b18409dd))
* restrict CodeQL analysis to Go only for Terraform module ([abcd025](https://github.com/kpeacocke/terraform-github-repo/commit/abcd025a74f11b6a223f19b08c5291f07563d346))
* set working directory for Go commands in CI workflows ([a0e6cd8](https://github.com/kpeacocke/terraform-github-repo/commit/a0e6cd86a08f3a90335ffe557cdb3a4001091446))
* specify test directory for coverage report generation ([7fad088](https://github.com/kpeacocke/terraform-github-repo/commit/7fad08828576c80399cf0f5ab33d0c739693a4c3))
* update build workflow to use Go instead of Python for testing ([cc32401](https://github.com/kpeacocke/terraform-github-repo/commit/cc32401443b47f8d4aa835835c758c249865c242))
* update checkout action version and add debug environment step in CI workflow ([3adfe1e](https://github.com/kpeacocke/terraform-github-repo/commit/3adfe1ea48befef68ded52e8bcc831c4871192bb))
* update GitHub Actions workflows and dependencies for improved functionality ([78c2800](https://github.com/kpeacocke/terraform-github-repo/commit/78c2800149c84586003e5ba5b957434a064ba866))
* update GitHub provider source and version constraints in Terraform configuration ([1e068a5](https://github.com/kpeacocke/terraform-github-repo/commit/1e068a5a0bf4c4ea2feac412b3779a41830010a8))
* update GitHub workflows and templates for consistency and functionality ([b5aa359](https://github.com/kpeacocke/terraform-github-repo/commit/b5aa35959fa0f77fe6972a03340e75264f49fb2e))
* update Go test command to include all packages in the workspace ([5935c68](https://github.com/kpeacocke/terraform-github-repo/commit/5935c68df046ca66d877fdd765b2a23e51e847ed))
* update Go test command to specify test directory ([17c788b](https://github.com/kpeacocke/terraform-github-repo/commit/17c788b75146dba0fedc93b7536091ffb965314c))
* update Go test commands to target specific test files ([544abd8](https://github.com/kpeacocke/terraform-github-repo/commit/544abd83210e236c208aa5bd19f4c70c089086af))
* update Go test commands to target test directory instead of specific files ([82680df](https://github.com/kpeacocke/terraform-github-repo/commit/82680df963fa8afa00392252ce8ee7ebe8538c91))
* update Go version specification in workflows and add working directory context ([20a4223](https://github.com/kpeacocke/terraform-github-repo/commit/20a42239f7d6df0343f7abc56a54234958f54f1c))
* update README to clarify disable_actions_until_provisioning variable description and improve formatting in main.tf ([f824ec5](https://github.com/kpeacocke/terraform-github-repo/commit/f824ec5a62704124a60ba53911c3b84b1fb15dd6))
* update README to include null provider requirement and remove outputs section ([8003426](https://github.com/kpeacocke/terraform-github-repo/commit/80034262bf5a377500f6e7be50fdbc10f1319033))
* update SonarCloud action version in CI workflow for consistency ([232a70e](https://github.com/kpeacocke/terraform-github-repo/commit/232a70e7057e4d83e4e507816428333ad6cc57c1))
* update SonarCloud project key for correct repository identification ([3015d8b](https://github.com/kpeacocke/terraform-github-repo/commit/3015d8bd0d2f1553d19898a4b386a7f5b2cf6a2c))

### ♻️ Code Refactoring

* remove outdated test workflows for Go and language-specific templates ([a3993e8](https://github.com/kpeacocke/terraform-github-repo/commit/a3993e8d82402727799d99caed2b6f298f1a7ff2))
* streamline README structure. Esentially stopped mixing up this and template. I'm an idiot ([a652c79](https://github.com/kpeacocke/terraform-github-repo/commit/a652c79619d478c91ca873466c80ffd546d24d55))
* update GitHub workflows to use escaped GitHub token syntax & improve variable descriptions ([c1bc946](https://github.com/kpeacocke/terraform-github-repo/commit/c1bc946a282bdcd25e1a240493c0e6379ed8a39f))


Generating notes for 1.0.0

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
