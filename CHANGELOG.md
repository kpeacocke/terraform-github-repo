# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-disable MD024 -->

## [1.14.12](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.11...v1.14.12) (2025-07-17)

### 🐛 Bug Fixes

* update git permissions in Dependabot workflow to ensure proper ownership ([451028a](https://github.com/kpeacocke/terraform-github-repo/commit/451028acc1869a4737c5a28ddbee5c9a3d573451))

### 📚 Documentation

* update changelog for v1.14.11 ([8cf02b3](https://github.com/kpeacocke/terraform-github-repo/commit/8cf02b3b76da5df54827f2189f8f221b86353643))


Generating notes for 1.14.12

## [1.14.11](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.10...v1.14.11) (2025-07-17)

### 🐛 Bug Fixes

* update notification muting logic in end-to-end tests to log warnings on failure ([3165e3d](https://github.com/kpeacocke/terraform-github-repo/commit/3165e3d2650c89a92a817aa2048ff701e8fe1417))

### 📚 Documentation

* update changelog for v1.14.10 ([4560de4](https://github.com/kpeacocke/terraform-github-repo/commit/4560de457aecc959ad520962e585d64af0743f2a))

Generating notes for 1.14.11

## [1.14.10](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.9...v1.14.10) (2025-07-10)

### 🐛 Bug Fixes

* mute notifications for new GitHub repository to suppress creation and workflow emails ([47c5f6b](https://github.com/kpeacocke/terraform-github-repo/commit/47c5f6b569487c048b9760539ed90a497fda3518))

### 📚 Documentation

* update changelog for v1.14.9 ([31f9c0d](https://github.com/kpeacocke/terraform-github-repo/commit/31f9c0d5baf179c9bc69ee38f2eab47fdffe299c))

Generating notes for 1.14.10

## [1.14.9](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.8...v1.14.9) (2025-07-09)

### 🐛 Bug Fixes

* update Trivy commands to skip CodeQL queries and specify provider versions in README ([bb1b5de](https://github.com/kpeacocke/terraform-github-repo/commit/bb1b5de5392831f6e8ddde6c441847ae273c0408))

### 📚 Documentation

* update changelog for v1.14.8 ([34245fb](https://github.com/kpeacocke/terraform-github-repo/commit/34245fbdcc9ecea7291709504ae6fb46c81ea9bd))

Generating notes for 1.14.9

## [1.14.8](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.7...v1.14.8) (2025-07-09)

### 🐛 Bug Fixes

* update Dependabot workflow to use pull_request_target and correct token usage ([1712cea](https://github.com/kpeacocke/terraform-github-repo/commit/1712cea26c63ca40f2c58bde38942152d0710fca))

### 📚 Documentation

* **deps:** bump packaging from 23.2 to 25.0 in /docs ([a28e8a6](https://github.com/kpeacocke/terraform-github-repo/commit/a28e8a661e138357f131f3f5a00025da6fd85cbb))
* update changelog for v1.14.7 ([3e2d9d4](https://github.com/kpeacocke/terraform-github-repo/commit/3e2d9d49f1e74f753c3cdb9b3a7309e6c108ef5f))
* update terraform-docs [skip ci] ([09ddbc5](https://github.com/kpeacocke/terraform-github-repo/commit/09ddbc538cb8c54ab89dffb34aff21ea82d79bfc))

Generating notes for 1.14.8

## [1.14.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.6...v1.14.7) (2025-07-06)

### 🐛 Bug Fixes

* update trivy.yaml to change filePatterns to skip-files ([e9c233e](https://github.com/kpeacocke/terraform-github-repo/commit/e9c233ecfa9e9f8fde7daf8540023fdb2a7dbb4b))

### 📚 Documentation

* update changelog for v1.14.6 ([3f696a1](https://github.com/kpeacocke/terraform-github-repo/commit/3f696a1f491a278ef6940a0ca163d4f725064b55))

Generating notes for 1.14.7

## [1.14.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.5...v1.14.6) (2025-07-06)

### 🐛 Bug Fixes

* update Trivy configuration and remove obsolete ignore patterns ([2337c4e](https://github.com/kpeacocke/terraform-github-repo/commit/2337c4ee8cc9c32c2becedd9c02680811e9a9d82))

### 📚 Documentation

* update changelog for v1.14.5 ([458f566](https://github.com/kpeacocke/terraform-github-repo/commit/458f5667c73d5b37af3583d9f70fff52309e550f))

Generating notes for 1.14.6

## [1.14.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.4...v1.14.5) (2025-07-06)

### 🐛 Bug Fixes

* update GitHub token variable in Dependabot workflow and enhance .trivyignore for CodeQL tests ([5213ee2](https://github.com/kpeacocke/terraform-github-repo/commit/5213ee24e037d8dc2e35a9b6dd1fc7f5b22a6d16))

### 📚 Documentation

* update changelog for v1.14.4 ([eae4252](https://github.com/kpeacocke/terraform-github-repo/commit/eae42524fb059e3c9ef9764ed9eb3e6528a75be7))

Generating notes for 1.14.5

## [1.14.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.3...v1.14.4) (2025-07-06)

### 🐛 Bug Fixes

* enhance security scanning by adding .trivyignore support and conditional Terraform plan execution ([18636f2](https://github.com/kpeacocke/terraform-github-repo/commit/18636f2be20816ecff201a6eec12fc5e7509cbe8))

### 📚 Documentation

* update changelog for v1.14.3 ([5befdea](https://github.com/kpeacocke/terraform-github-repo/commit/5befdea1f3707de4db6559b733d754c7c7d67b6c))

Generating notes for 1.14.4

## [1.14.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.2...v1.14.3) (2025-07-05)

### 🐛 Bug Fixes

* update environment variable names and improve Terraform command options in Dependabot workflow ([6465066](https://github.com/kpeacocke/terraform-github-repo/commit/64650662b8538876f8399e907398c8fb56ad1dfa))

### 📚 Documentation

* update changelog for v1.14.2 ([66b1880](https://github.com/kpeacocke/terraform-github-repo/commit/66b18802ac84c86b284d32744974f4854ceb839d))

Generating notes for 1.14.3

## [1.14.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.1...v1.14.2) (2025-07-05)

### 🐛 Bug Fixes

* update GITHUB_TOKEN usage and improve Trivy exit code handling in workflows ([73e9bcb](https://github.com/kpeacocke/terraform-github-repo/commit/73e9bcb25e6cac33e0dc79e400df35b62bf35af0))

### 📚 Documentation

* update changelog for v1.14.1 ([c5eeece](https://github.com/kpeacocke/terraform-github-repo/commit/c5eeeceb482f0695e8c5db71a0304836dce9d8f9))

Generating notes for 1.14.2

## [1.14.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.14.0...v1.14.1) (2025-07-05)

### 🐛 Bug Fixes

* update GITHUB_TOKEN to use GIT_COMMITTERS_TOKEN for Go tests ([298f164](https://github.com/kpeacocke/terraform-github-repo/commit/298f164a732de23f056fcd3e0e4961ab50e2f7ef))

### 📚 Documentation

* update changelog for v1.14.0 ([8189bdb](https://github.com/kpeacocke/terraform-github-repo/commit/8189bdb9eb1ef0c3d951c0496c1c2b80a14c45d2))

Generating notes for 1.14.1

## [1.14.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.13.1...v1.14.0) (2025-07-04)

### 🚀 Features

* add github_owner and github_token variables for API access ([25648f6](https://github.com/kpeacocke/terraform-github-repo/commit/25648f664d39b94cd4ce81ab3b5f383f6471e56b))

### 📚 Documentation

* update changelog for v1.13.1 ([1425006](https://github.com/kpeacocke/terraform-github-repo/commit/1425006010c05e26cd17c9f0eec3a0bb6f1ab0e8))

Generating notes for 1.14.0

## [1.13.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.13.0...v1.13.1) (2025-07-04)

### 🐛 Bug Fixes

* add environment variables for GitHub token and repository details in Dependabot workflow ([e24f689](https://github.com/kpeacocke/terraform-github-repo/commit/e24f6897a07e96f14b12984ffb25c1550908a3be))

### 📚 Documentation

* update changelog for v1.13.0 ([4d0f19e](https://github.com/kpeacocke/terraform-github-repo/commit/4d0f19eda9cf0c2de6b50ab6c1ff7daa38d7dc76))

Generating notes for 1.13.1

## [1.13.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.5...v1.13.0) (2025-07-04)

### 🚀 Features

* add TF_VAR_visibility variable to dependabot workflow and update Trivy installation steps in security scan ([917f5a3](https://github.com/kpeacocke/terraform-github-repo/commit/917f5a331077bd95b75fa482725596ca3b20b1b7))

### 🐛 Bug Fixes

* rename TF_VAR_github_owner to TF_VAR_owner for consistency in workflow ([5a15901](https://github.com/kpeacocke/terraform-github-repo/commit/5a159016fbb0bba7156a02d80e2af0872b9bad41))

### 📚 Documentation

* update changelog for v1.12.5 ([7f61ee0](https://github.com/kpeacocke/terraform-github-repo/commit/7f61ee0ef5f5a7e0d26622fc886cd100861413fd))

Generating notes for 1.13.0

## [1.12.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.4...v1.12.5) (2025-07-04)

### 🐛 Bug Fixes

* update security scanning workflow to use conditional Trivy commands and improve README update process ([448850f](https://github.com/kpeacocke/terraform-github-repo/commit/448850fd6ce5915c601ec093f5c2120cb9e27f17))

### 📚 Documentation

* **deps:** bump mkdocs-git-revision-date-localized-plugin in /docs ([d7c1c62](https://github.com/kpeacocke/terraform-github-repo/commit/d7c1c62fe5fa9c1695882eb3837786d57109836d))
* **deps:** bump pygments from 2.16.1 to 2.19.2 in /docs ([f0c4089](https://github.com/kpeacocke/terraform-github-repo/commit/f0c40896539349e35d88d03818d30f7036e1460b))
* update changelog for v1.12.4 ([f6e134f](https://github.com/kpeacocke/terraform-github-repo/commit/f6e134f5578e2eba1810be5b74591d2f9f030f81))
* update terraform-docs [skip ci] ([fe90b09](https://github.com/kpeacocke/terraform-github-repo/commit/fe90b09fecdf658f581b02c31e1abf8aeb8b02a0))
* update terraform-docs [skip ci] ([b2906fb](https://github.com/kpeacocke/terraform-github-repo/commit/b2906fb9304d3b53773ebc84ea8b38424863f8fd))

Generating notes for 1.12.5

## [1.12.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.3...v1.12.4) (2025-07-04)

### 🐛 Bug Fixes

* add security-events permission for latest Terraform validation job ([7b102ad](https://github.com/kpeacocke/terraform-github-repo/commit/7b102ad161a3b8761f347545844e143475700a47))

### 📚 Documentation

* update changelog for v1.12.3 ([860e76a](https://github.com/kpeacocke/terraform-github-repo/commit/860e76a5321fa583695bbcab572322dcd5fc91a6))

Generating notes for 1.12.4

## [1.12.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.2...v1.12.3) (2025-07-02)

### 🐛 Bug Fixes

* update permissions for security-events in Dependabot workflow ([a582c8f](https://github.com/kpeacocke/terraform-github-repo/commit/a582c8fcd7086465abbe1987f95e36768442e33a))

### 📚 Documentation

* update changelog for v1.12.2 ([5d5c3f0](https://github.com/kpeacocke/terraform-github-repo/commit/5d5c3f0e626f63be33d47d24569bcb44d1a4bf33))

Generating notes for 1.12.3

## [1.12.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.1...v1.12.2) (2025-06-29)

### 🐛 Bug Fixes

* ensure latest gh-pages branch is fetched and rebased before deployment ([d57afe5](https://github.com/kpeacocke/terraform-github-repo/commit/d57afe516aa4227d790505d4df36c52f252fc126))

### 📚 Documentation

* update changelog for v1.12.1 ([bb4886b](https://github.com/kpeacocke/terraform-github-repo/commit/bb4886bd598a498c6a569218a09a50b3c8c4cfd7))

Generating notes for 1.12.2

## [1.12.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.12.0...v1.12.1) (2025-06-29)

### 🐛 Bug Fixes

* update workflow paths to use local reusable workflows ([af7f2cc](https://github.com/kpeacocke/terraform-github-repo/commit/af7f2ccb70312ce1e31d77e59dbb1f33a5d3905e))

### 📚 Documentation

* **deps:** bump markupsafe from 2.1.3 to 3.0.2 in /docs ([9ad6ecf](https://github.com/kpeacocke/terraform-github-repo/commit/9ad6ecfc1d42fcf458540fd01e712b43b2f32a61))
* **deps:** bump pymdown-extensions from 10.3.1 to 10.16 in /docs ([d1af6a9](https://github.com/kpeacocke/terraform-github-repo/commit/d1af6a96b4e53c75eee1db5ce25e48369e1ba2f3))
* **deps:** bump pyyaml from 6.0.1 to 6.0.2 in /docs ([712b5d0](https://github.com/kpeacocke/terraform-github-repo/commit/712b5d018bdf268f33e9c306b06a93da5a81848d))
* update changelog for v1.12.0 ([492a670](https://github.com/kpeacocke/terraform-github-repo/commit/492a67039ce1f1a9da448ec5f64a81eb885e28ef))
* update provider versions in README for clarity ([a4fe915](https://github.com/kpeacocke/terraform-github-repo/commit/a4fe9155006b47ab1957ad064a058e1e628c8624))
* update terraform-docs [skip ci] ([54bf4be](https://github.com/kpeacocke/terraform-github-repo/commit/54bf4be23f28bff150dea0fcfd10aae8a08ed0aa))
* update terraform-docs [skip ci] ([299016f](https://github.com/kpeacocke/terraform-github-repo/commit/299016f8fa0538d37737ca2080818adb98d800a7))
* update terraform-docs [skip ci] ([d3ca72f](https://github.com/kpeacocke/terraform-github-repo/commit/d3ca72fcc18c7477a5e39d8d55fe38113fd54d79))

Generating notes for 1.12.1

## [1.12.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.11.0...v1.12.0) (2025-06-28)

### 🚀 Features

* **tests:** enhance integration tests for GitHub repository validation and add debug controls ([af04cb4](https://github.com/kpeacocke/terraform-github-repo/commit/af04cb41898eac3b38f661e9b8b4b36f57098c74))

### 🐛 Bug Fixes

* **workflow:** update reusable workflow paths to use GitHub's official repository ([900fb5f](https://github.com/kpeacocke/terraform-github-repo/commit/900fb5f709c1bf5870fdc0c5828e42b1d5881b04))

### 📚 Documentation

* update changelog for v1.11.0 ([a285cc2](https://github.com/kpeacocke/terraform-github-repo/commit/a285cc225b60add778cac1ef0cc0bdfd26c18cdf))

Generating notes for 1.12.0

## [1.11.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.7...v1.11.0) (2025-06-28)

### 🚀 Features

* **workflow:** add security-events permission for Dependabot validation jobs ([3b4e7c7](https://github.com/kpeacocke/terraform-github-repo/commit/3b4e7c73437207a7168689916d906dd1e01f159a))
* **vscode:** add settings and tasks for Go and Ruby testing ([784479b](https://github.com/kpeacocke/terraform-github-repo/commit/784479b909f47f1f996a26f5adbfb9002da42446))

### 📚 Documentation

* update changelog for v1.10.7 ([dfb6cbf](https://github.com/kpeacocke/terraform-github-repo/commit/dfb6cbfa39ec1607d4b0ddf401bc8184605f29b0))

Generating notes for 1.11.0

## [1.10.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.6...v1.10.7) (2025-06-24)

### 🐛 Bug Fixes

* simplify mike alias conflict resolution script and update git author information ([311027e](https://github.com/kpeacocke/terraform-github-repo/commit/311027ef4ea6ea3faf22a2e5c14593478bb8a4a0))

### 📚 Documentation

* update changelog for v1.10.6 ([f595dee](https://github.com/kpeacocke/terraform-github-repo/commit/f595dee83c3abbad33c388492720e40fa33968c5))

Generating notes for 1.10.7

## [1.10.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.5...v1.10.6) (2025-06-24)

### 🐛 Bug Fixes

* update conflict resolution script execution in documentation workflow ([4d9552a](https://github.com/kpeacocke/terraform-github-repo/commit/4d9552a5754e6479a36a4aad7910bce7d3997439))

### 📚 Documentation

* update changelog for v1.10.5 ([309332b](https://github.com/kpeacocke/terraform-github-repo/commit/309332bcce746f45ec36b9244939240846d1595a))

Generating notes for 1.10.6

## [1.10.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.4...v1.10.5) (2025-06-24)

### 🐛 Bug Fixes

* enhance Git repository checks in documentation deployment workflow ([0c9d37b](https://github.com/kpeacocke/terraform-github-repo/commit/0c9d37b4e51763484bab5ccf5b9850b712120f94))

### 📚 Documentation

* update changelog for v1.10.4 ([a1a0b58](https://github.com/kpeacocke/terraform-github-repo/commit/a1a0b588b80548e7d9b577169bee3871683ca223))

Generating notes for 1.10.5

## [1.10.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.3...v1.10.4) (2025-06-24)

### 🐛 Bug Fixes

* update mike deployment commands to remove --force flag and improve reliability ([9cd699b](https://github.com/kpeacocke/terraform-github-repo/commit/9cd699b7678de291c89747d854e280d2a9871a25))

### 📚 Documentation

* update changelog for v1.10.3 ([9c739ab](https://github.com/kpeacocke/terraform-github-repo/commit/9c739abba55d0ea116e8316aa1266f4469ba60d3))

Generating notes for 1.10.4

## [1.10.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.2...v1.10.3) (2025-06-24)

### 🐛 Bug Fixes

* enhance mike alias conflict resolution and improve documentation workflow ([f943707](https://github.com/kpeacocke/terraform-github-repo/commit/f9437072a3ca074730e9742645e4147d9a7085a2))

### 📚 Documentation

* update changelog for v1.10.2 ([3661362](https://github.com/kpeacocke/terraform-github-repo/commit/3661362875c8c3c85ec7e95645ce360e958b920d))

Generating notes for 1.10.3

## [1.10.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.1...v1.10.2) (2025-06-24)

### 🐛 Bug Fixes

* enhance documentation workflow and validate mkdocs configuration ([df5c814](https://github.com/kpeacocke/terraform-github-repo/commit/df5c81411a6c3e2450c0bbafe13dcff2cf003d3f))

### 📚 Documentation

* update changelog for v1.10.1 ([cc7c07e](https://github.com/kpeacocke/terraform-github-repo/commit/cc7c07ece7b2f25ff7273ea754999d248bf4e0bb))

Generating notes for 1.10.2

## [1.10.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.10.0...v1.10.1) (2025-06-24)

### 🐛 Bug Fixes

* update badge links in README for module version and downloads ([3a41e8c](https://github.com/kpeacocke/terraform-github-repo/commit/3a41e8c9a28fe0acba3b4ee2aa483f1c0c9c8924))

### 📚 Documentation

* update changelog for v1.10.0 ([2330a8b](https://github.com/kpeacocke/terraform-github-repo/commit/2330a8b8b34bacd9cb9d425bd1aa4bd627439fb4))

Generating notes for 1.10.1

## [1.10.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.9.2...v1.10.0) (2025-06-24)

### 🚀 Features

* add validation for 'owners' and 'visibility' variables in Terraform module ([7277e9e](https://github.com/kpeacocke/terraform-github-repo/commit/7277e9ec06447d34692dbe53a9c5c23c5e8c22f8))

### 🐛 Bug Fixes

* update GitHub and null provider versions in README ([b854e31](https://github.com/kpeacocke/terraform-github-repo/commit/b854e31b1b4532adac413fac55da917b6248f085))

### 📚 Documentation

* update changelog for v1.9.2 ([78d107d](https://github.com/kpeacocke/terraform-github-repo/commit/78d107d10b45c7d64f98fa1ba0cd7e94ed5810b3))

Generating notes for 1.10.0

## [1.9.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.9.1...v1.9.2) (2025-06-24)

### 🐛 Bug Fixes

* update CI workflow to use GIT_COMMITTERS_TOKEN and enhance drift detection logic ([fb74a28](https://github.com/kpeacocke/terraform-github-repo/commit/fb74a28c3f698425a4442b3b8ddaced86af22f5f))
* update drift check script to accept additional arguments and improve OpenTofu installation method ([e1180dd](https://github.com/kpeacocke/terraform-github-repo/commit/e1180dd36ac4758c25e5199204c9e8ee8ac87c6a))

### 📚 Documentation

* update changelog for v1.9.1 ([1cf1b9d](https://github.com/kpeacocke/terraform-github-repo/commit/1cf1b9d00979bd6b30e4b6562694c9cef4386343))
* update terraform-docs [skip ci] ([f424ca8](https://github.com/kpeacocke/terraform-github-repo/commit/f424ca8189b05cbc4c6ca50b24c050017b26db88))

Generating notes for 1.9.2

## [1.9.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.9.0...v1.9.1) (2025-06-24)

### 🐛 Bug Fixes

* enhance drift check script and update OpenTofu installation method ([6c61ea7](https://github.com/kpeacocke/terraform-github-repo/commit/6c61ea7e903e971ba4f31b771fd248c4740afcf6))

### 📚 Documentation

* update changelog for v1.9.0 ([0483b94](https://github.com/kpeacocke/terraform-github-repo/commit/0483b94e648ac9e779bda69e5ed4975a806aea3b))

Generating notes for 1.9.1

## [1.9.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.9...v1.9.0) (2025-06-24)

### 🚀 Features

* update provider versions and add sample plans for S3 and IAM resources ([3fc1b13](https://github.com/kpeacocke/terraform-github-repo/commit/3fc1b13537e0e7e1610bbcac4b7b63f2ba18241d))

### 🐛 Bug Fixes

* update OPA lint command and improve OpenTofu installation process ([e1194f3](https://github.com/kpeacocke/terraform-github-repo/commit/e1194f3a1ab95c68c809a95b04f7370283d4be5d))

### 📚 Documentation

* update changelog for v1.8.9 ([2cd0c5f](https://github.com/kpeacocke/terraform-github-repo/commit/2cd0c5fbd777fd38e5d9cdc0826b56e35d2e217f))
* update terraform-docs [skip ci] ([4b9c516](https://github.com/kpeacocke/terraform-github-repo/commit/4b9c5167206ae45aac06fc43ae68093a7de496ce))

Generating notes for 1.9.0

## [1.8.9](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.8...v1.8.9) (2025-06-24)

### 📚 Documentation

* update changelog for v1.8.8 ([dd5e280](https://github.com/kpeacocke/terraform-github-repo/commit/dd5e280a7d593f7e42549667939d577968e3a263))

### ♻️ Code Refactoring

* standardize deny message handling across policies ([cdfbbc6](https://github.com/kpeacocke/terraform-github-repo/commit/cdfbbc63ab149bafda7c9e18893760b3cc28871c))

Generating notes for 1.8.9

## [1.8.8](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.7...v1.8.8) (2025-06-24)

### 📚 Documentation

* update changelog for v1.8.7 ([45d5ca1](https://github.com/kpeacocke/terraform-github-repo/commit/45d5ca1fbf17acef19b4e4e9bb832b7496fd2351))

### ♻️ Code Refactoring

* improve readability of S3 server-side encryption check in guardrails policy ([6e0e6c6](https://github.com/kpeacocke/terraform-github-repo/commit/6e0e6c6d197af47a0beb4ebd3a22b5a66f728028))
* standardize deny message formatting in guardrails policy ([9ae6dc6](https://github.com/kpeacocke/terraform-github-repo/commit/9ae6dc63cbe974912c77656ad864cff1244e70cf))

Generating notes for 1.8.8

## [1.8.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.6...v1.8.7) (2025-06-24)

### 📚 Documentation

* update changelog for v1.8.6 ([0b1a8ff](https://github.com/kpeacocke/terraform-github-repo/commit/0b1a8ff33c7f00e798b1412cb47c3695adeab63f))

### ♻️ Code Refactoring

* simplify validation checks by removing helper function in guardrails policy ([896854b](https://github.com/kpeacocke/terraform-github-repo/commit/896854b8e1104236b9dc28acf177cdfd41bcbc2f))

Generating notes for 1.8.7

## [1.8.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.5...v1.8.6) (2025-06-24)

### 🐛 Bug Fixes

* update provider version constraints in README and improve deny message in extra-guardrails policy ([2416770](https://github.com/kpeacocke/terraform-github-repo/commit/24167705ae110f9b2d447ec978f5731f0aa4f984))

### 📚 Documentation

* update changelog for v1.8.5 ([a3cd876](https://github.com/kpeacocke/terraform-github-repo/commit/a3cd87618a0346fccd81b24ff13f2555a432f04b))
* update terraform-docs [skip ci] ([20d50f3](https://github.com/kpeacocke/terraform-github-repo/commit/20d50f301e6f1ed271bfe67909fd7650ec03b773))

### ♻️ Code Refactoring

* improve validation logic and error messages in guardrails policy ([3e04d8f](https://github.com/kpeacocke/terraform-github-repo/commit/3e04d8fd0574fe302d50ecc5489a2de2b4d54afc))
* replace message variable with specific deny messages in guardrails policy ([b88396e](https://github.com/kpeacocke/terraform-github-repo/commit/b88396e31cd8ac338c9360e2968a39a397c7c5e2))

Generating notes for 1.8.6

## [1.8.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.4...v1.8.5) (2025-06-24)

### 🐛 Bug Fixes

* add condition to enforce cost estimation limit in extra-guardrails policy ([6a734e7](https://github.com/kpeacocke/terraform-github-repo/commit/6a734e75f0720cedd8bad4df0ceff4f6cf13be39))
* update provider version constraints in README and extra-guardrails policy ([1a160eb](https://github.com/kpeacocke/terraform-github-repo/commit/1a160eba44fe6c9083ff9f4885ec65f692eda834))

### 📚 Documentation

* update changelog for v1.8.4 ([6735fcb](https://github.com/kpeacocke/terraform-github-repo/commit/6735fcba04227dfd50b235e982cf7ff06c50af91))
* update terraform-docs [skip ci] ([d945ecc](https://github.com/kpeacocke/terraform-github-repo/commit/d945ecc9a3b773e670e3df0e54529693fd778d68))

Generating notes for 1.8.5

## [1.8.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.3...v1.8.4) (2025-06-23)

### 🐛 Bug Fixes

* update Terraform version check message format in extra-guardrails policy ([0e4d8d0](https://github.com/kpeacocke/terraform-github-repo/commit/0e4d8d085e0449e7bfb1b6b36a3df0207c071219))

### 📚 Documentation

* update changelog for v1.8.3 ([89a392e](https://github.com/kpeacocke/terraform-github-repo/commit/89a392e0740683b7349102bced95f6e6db2289f1))
* update terraform-docs [skip ci] ([924be9d](https://github.com/kpeacocke/terraform-github-repo/commit/924be9de9052bd702a505e95338ab861df193158))

Generating notes for 1.8.4

## [1.8.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.2...v1.8.3) (2025-06-23)

### 🐛 Bug Fixes

* configure git user for CHANGELOG.md updates in workflow ([188aeb9](https://github.com/kpeacocke/terraform-github-repo/commit/188aeb9bf47466bb283a132bc965124a5402febe))

Generating notes for 1.8.3

## [1.8.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.1...v1.8.2) (2025-06-23)

### 🐛 Bug Fixes

* add permissions for MkDocs build and deploy job ([e7999e0](https://github.com/kpeacocke/terraform-github-repo/commit/e7999e061b0c6ca23ac4840c0bfb30e705f8cd58))

Generating notes for 1.8.2

## [1.8.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.8.0...v1.8.1) (2025-06-23)

### 🐛 Bug Fixes

* add MKDOCS_GIT_COMMITTERS_APIKEY environment variable for MkDocs build ([4bc61d4](https://github.com/kpeacocke/terraform-github-repo/commit/4bc61d4b6459fc8ff33df11ebc55e790c7324b9f))

Generating notes for 1.8.1

## [1.8.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.7.0...v1.8.0) (2025-06-23)

### 🚀 Features

* add Workflow Refactoring section to documentation navigation ([d283e98](https://github.com/kpeacocke/terraform-github-repo/commit/d283e98dbaf529f177a17b4d1f24b7a332280980))

Generating notes for 1.8.0

## [1.7.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.6.0...v1.7.0) (2025-06-23)

### 🚀 Features

* update MkDocs installation to include additional plugins ([379af2e](https://github.com/kpeacocke/terraform-github-repo/commit/379af2eb111744e8f72b5453d8bb4b2ccd75ba9f))

Generating notes for 1.7.0

## [1.6.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.5.0...v1.6.0) (2025-06-23)

### 🚀 Features

* enhance MkDocs installation step to include additional plugins ([823c6da](https://github.com/kpeacocke/terraform-github-repo/commit/823c6da68b4e5dd09cfe243aeec7f1f8ae921e80))

Generating notes for 1.6.0

## [1.5.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.10...v1.5.0) (2025-06-23)

### 🚀 Features

* add installation steps for OpenTofu and Terraform in CI workflow ([ae26a50](https://github.com/kpeacocke/terraform-github-repo/commit/ae26a504e5be503b0b21a0a43ff132af5e7b4b81))
* add MkDocs build and deploy workflow for documentation ([6c20ff5](https://github.com/kpeacocke/terraform-github-repo/commit/6c20ff52143a0d5fa9391c15aa7c976241b31343))

### 🐛 Bug Fixes

* clean up CHANGELOG.md and improve formatting in documentation ([0976105](https://github.com/kpeacocke/terraform-github-repo/commit/097610559efb89825fa6bd240a7acd1963eb9b51))
* correct syntax for deny rules in extra-guardrails.rego ([1f585a9](https://github.com/kpeacocke/terraform-github-repo/commit/1f585a98658ea47daebd987b6e5e876eec2fe881))
* update provider versions in README.md for accuracy ([af83485](https://github.com/kpeacocke/terraform-github-repo/commit/af83485b741d075602ed73fccae3a66fb4887e52))

### 📚 Documentation

* update changelog for v1.4.10 ([1200e27](https://github.com/kpeacocke/terraform-github-repo/commit/1200e277243a08153a13eaf8b8b316a8618b3f39))

### ♻️ Code Refactoring

* reorganize deny rules for clarity and consistency in extra-guardrails.rego ([711d951](https://github.com/kpeacocke/terraform-github-repo/commit/711d951bcc0da093bacb389e4ed4f74bd985782b))

Generating notes for 1.5.0

## [1.4.10](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.9...v1.4.10) (2025-06-23)

### 🐛 Bug Fixes

* enhance terraform plan command with dynamic variables ([3a0fe31](https://github.com/kpeacocke/terraform-github-repo/commit/3a0fe31e1389096b062506bd55c97285e99e4e2f))
* markdown linting issues ([a1fbbf3](https://github.com/kpeacocke/terraform-github-repo/commit/a1fbbf3240fc75128898d5119626daa9d044c9c4))

### 📚 Documentation

* update changelog for v1.4.9 ([c7b91b4](https://github.com/kpeacocke/terraform-github-repo/commit/c7b91b43e3f2d1034679b6872e69783d0db68611))
* update terraform-docs [skip ci] ([9334845](https://github.com/kpeacocke/terraform-github-repo/commit/9334845433b51e6c26cd302f8dbd225057323c45))

Generating notes for 1.4.10

## [1.4.9](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.8...v1.4.9) (2025-06-23)

### 🐛 Bug Fixes

* update cloudflare/circl dependency to v1.6.1 ([a2a94c1](https://github.com/kpeacocke/terraform-github-repo/commit/a2a94c11c439dfb337f86e4fa2101f54aa4a4323))

### 📚 Documentation

* update changelog for v1.4.8 ([5a70a77](https://github.com/kpeacocke/terraform-github-repo/commit/5a70a774d2ef4f169e3ac8e4c32e6bbc6c4eac91))

Generating notes for 1.4.9

## [1.4.8](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.7...v1.4.8) (2025-06-23)

### 🐛 Bug Fixes

* expand CodeQL analysis to include Python ([2dc7f91](https://github.com/kpeacocke/terraform-github-repo/commit/2dc7f9152e066fbcc4c055ef83ab5a82ebef46fb))

### 📚 Documentation

* update changelog for v1.4.7 ([dc8b4ac](https://github.com/kpeacocke/terraform-github-repo/commit/dc8b4ac379b296ab496ba81e232f8b51a2850c67))

Generating notes for 1.4.8

## [1.4.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.6...v1.4.7) (2025-06-23)

### 🐛 Bug Fixes

* update mkdocs version range in requirements.txt ([e30bd5c](https://github.com/kpeacocke/terraform-github-repo/commit/e30bd5c5985052975bf3424a1ca68aeca1c80bcc))

Generating notes for 1.4.7

## [1.4.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.5...v1.4.6) (2025-06-23)

### 🐛 Bug Fixes

* update GitHub and null provider versions in README.md ([11897f3](https://github.com/kpeacocke/terraform-github-repo/commit/11897f35804409200e48f07fcfd32761937aeee2))
* update requirements and improve test scripts for fix_mike_info.py ([92dccdc](https://github.com/kpeacocke/terraform-github-repo/commit/92dccdceade7feac6b9beb8be810676a72f67ab4))

### 📚 Documentation

* **deps:** bump jinja2 from 3.1.2 to 3.1.6 in /docs ([40d89e4](https://github.com/kpeacocke/terraform-github-repo/commit/40d89e43770a8dc819cf72a693a9c5e0ceac921a))
* **deps:** bump mkdocs-material from 9.4.14 to 9.6.14 in /docs ([99907a5](https://github.com/kpeacocke/terraform-github-repo/commit/99907a5eca26cbf6865730cdc00ab229a977329f))
* **deps:** bump mkdocs-minify-plugin from 0.7.1 to 0.8.0 in /docs ([2673aa0](https://github.com/kpeacocke/terraform-github-repo/commit/2673aa0974aebc91566d32e34655902e0de41e05))
* update changelog for v1.4.5 ([aa2e6a1](https://github.com/kpeacocke/terraform-github-repo/commit/aa2e6a11b7aa0783945201efad5f18e5ccb0f460))
* update terraform-docs [skip ci] ([788c3cb](https://github.com/kpeacocke/terraform-github-repo/commit/788c3cb9cbd80feea6d6feb45e2663a176b6fa61))
* update terraform-docs [skip ci] ([03be4ce](https://github.com/kpeacocke/terraform-github-repo/commit/03be4ced9575019d99395b37ed6010aa0d0ae6a0))
* update terraform-docs [skip ci] ([8cdde00](https://github.com/kpeacocke/terraform-github-repo/commit/8cdde0023c98fb1539f58b870bbfffdb0c2e5b92))

Generating notes for 1.4.6

## [1.4.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.4...v1.4.5) (2025-06-23)

### 🐛 Bug Fixes

* correct formatting in release workflow for consistency ([c3ac5c3](https://github.com/kpeacocke/terraform-github-repo/commit/c3ac5c31de3b9cb2b3368d933220e9a522328f6a))

### 📚 Documentation

* update changelog for v1.4.4 ([87479e4](https://github.com/kpeacocke/terraform-github-repo/commit/87479e48fb1832a82c80c8eafd7fcd082e6f8fc2))

Generating notes for 1.4.5

## [1.4.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.3...v1.4.4) (2025-06-23)

### 🐛 Bug Fixes

* ensure mkdocs.yml is present by checking out the main branch in release workflow ([e986212](https://github.com/kpeacocke/terraform-github-repo/commit/e9862123496ed315b34b07067cce527d8e790df2))

### 📚 Documentation

* update changelog for v1.4.3 ([71c3678](https://github.com/kpeacocke/terraform-github-repo/commit/71c36781b52f0f93f16998552a71d7f9f4554a1e))

Generating notes for 1.4.4

## [1.4.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.2...v1.4.3) (2025-06-23)

### 🐛 Bug Fixes

* correct script path in verification step ([79aabed](https://github.com/kpeacocke/terraform-github-repo/commit/79aabed20254e75f1bc8bc5465a92a55a45a4da9))

### 📚 Documentation

* update changelog for v1.4.2 ([8d4b0e2](https://github.com/kpeacocke/terraform-github-repo/commit/8d4b0e2fb89eaabf0bbcfe3feb95943b5b0707a2))

Generating notes for 1.4.3

## [1.4.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.1...v1.4.2) (2025-06-23)

### 📚 Documentation

* update changelog for v1.4.1 ([7892d70](https://github.com/kpeacocke/terraform-github-repo/commit/7892d70c693567e601941475efa8a7efebaf7f71))

### ♻️ Code Refactoring

* remove obsolete fix_mike_info.py script ([b4927dc](https://github.com/kpeacocke/terraform-github-repo/commit/b4927dc7ddb88e7cc8a1d216f2458dec31609c36))

Generating notes for 1.4.2

## [1.4.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.4.0...v1.4.1) (2025-06-22)

### 🐛 Bug Fixes

* set working directory for script presence check in release workflow ([4581404](https://github.com/kpeacocke/terraform-github-repo/commit/4581404435562b973a9e0f65f7212f89197dab87))

### 📚 Documentation

* update changelog for v1.4.0 ([bb48672](https://github.com/kpeacocke/terraform-github-repo/commit/bb486720e61f733ad1f642f2d836d1875482fd04))

Generating notes for 1.4.1

## [1.4.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.3.0...v1.4.0) (2025-06-22)

### 🚀 Features

* add verification step for required scripts before notification ([fa78c79](https://github.com/kpeacocke/terraform-github-repo/commit/fa78c79a7af682f9058e0decf6009315e362feba))

### 📚 Documentation

* update changelog for v1.3.0 ([1032ebd](https://github.com/kpeacocke/terraform-github-repo/commit/1032ebd28fa85d769e61b1307008605edbc175c9))

Generating notes for 1.4.0

## [1.3.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.2.0...v1.3.0) (2025-06-22)

### 🚀 Features

* add alias conflict check before deploying documentation ([64853a2](https://github.com/kpeacocke/terraform-github-repo/commit/64853a2c36a38c5f336f73490a316a1977fc3c8c))

Generating notes for 1.3.0

## [1.2.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.27...v1.2.0) (2025-06-22)

### 🚀 Features

* add deploy_docs script for versioned documentation deployment ([b53b425](https://github.com/kpeacocke/terraform-github-repo/commit/b53b425c5766065cb00484c70b3d29b04efba79d))

Generating notes for 1.2.0

## [1.1.27](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.26...v1.1.27) (2025-06-22)

### 🐛 Bug Fixes

* add scripts for release management and MkDocs validation ([ad56933](https://github.com/kpeacocke/terraform-github-repo/commit/ad569336bc4e1e045ed94598bd63d4b5fbd9e482))

Generating notes for 1.1.27

## [1.1.26](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.25...v1.1.26) (2025-06-22)

### 🐛 Bug Fixes

* add script to clean up Mike configuration and validate workflows ([010ce41](https://github.com/kpeacocke/terraform-github-repo/commit/010ce418b5a121cd4befcb261be1c4a69bc76c38))

Generating notes for 1.1.26

## [1.1.25](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.24...v1.1.25) (2025-06-20)

### ♻️ Code Refactoring

* streamline dependency installation and mkdocs deployment steps ([04f1bc9](https://github.com/kpeacocke/terraform-github-repo/commit/04f1bc93a167d950f8bf805e1b918e5f16c2fbae))

Generating notes for 1.1.25

## [1.1.24](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.23...v1.1.24) (2025-06-20)

### 🐛 Bug Fixes

* add debug output for mkdocs.yml location in release workflow ([2d52fb2](https://github.com/kpeacocke/terraform-github-repo/commit/2d52fb27257297af25785a763c8bdec51b278647))

Generating notes for 1.1.24

## [1.1.23](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.22...v1.1.23) (2025-06-20)

### 🐛 Bug Fixes

* remove redundant debug step and set working directory for mkdocs.yml check ([8d56507](https://github.com/kpeacocke/terraform-github-repo/commit/8d56507b16dcfe2989ff50ad42dd03b31bedaf9c))

Generating notes for 1.1.23

## [1.1.22](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.21...v1.1.22) (2025-06-20)

### 🐛 Bug Fixes

* add debug step to show working directory and environment variables after checkout ([0a2a91f](https://github.com/kpeacocke/terraform-github-repo/commit/0a2a91fa5dfb41c13ea7cc79ca216ede08b944fe))
* update debug step name for clarity in release workflow ([76e822a](https://github.com/kpeacocke/terraform-github-repo/commit/76e822aeb058c8baff0256bbe65f43c93372da04))

Generating notes for 1.1.22

## [1.1.21](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.20...v1.1.21) (2025-06-19)

### 🐛 Bug Fixes

* simplify mkdocs.yml presence check and remove redundant debug steps ([94f0a8d](https://github.com/kpeacocke/terraform-github-repo/commit/94f0a8d3a0cc469afd111936f53f74fa7caf5d77))

Generating notes for 1.1.21

## [1.1.20](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.19...v1.1.20) (2025-06-19)

### 🐛 Bug Fixes

* enhance checkout step with additional logging and mkdocs.yml presence verification ([9936108](https://github.com/kpeacocke/terraform-github-repo/commit/9936108c8c006b37d4cdc4bfb450307243750fbc))

Generating notes for 1.1.20

## [1.1.19](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.18...v1.1.19) (2025-06-19)

### 🐛 Bug Fixes

* enhance checkout step with additional logging and mkdocs.yml presence verification ([45edb24](https://github.com/kpeacocke/terraform-github-repo/commit/45edb244dd0411ac1979e5bfd4c233c5107af8f7))

Generating notes for 1.1.19

## [1.1.18](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.17...v1.1.18) (2025-06-19)

### 🐛 Bug Fixes

* enhance checkout step with detailed logging and mkdocs.yml presence check ([621aab7](https://github.com/kpeacocke/terraform-github-repo/commit/621aab71f71851aa9ecabefd7090e9560d096ac1))

Generating notes for 1.1.18

## [1.1.17](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.16...v1.1.17) (2025-06-19)

### 🐛 Bug Fixes

* ensure clean checkout of main and verify mkdocs.yml presence ([2c82513](https://github.com/kpeacocke/terraform-github-repo/commit/2c8251311e151bdaff8e881998b4c8b366f3c26a))

Generating notes for 1.1.17

## [1.1.16](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.15...v1.1.16) (2025-06-19)

### 🐛 Bug Fixes

* update checkout step to ensure mkdocs.yml is present ([7a04e50](https://github.com/kpeacocke/terraform-github-repo/commit/7a04e503b528dc7eb17893dad432ae1542205507))

Generating notes for 1.1.16

## [1.1.15](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.14...v1.1.15) (2025-06-19)

### 🐛 Bug Fixes

* add debug information before MkDocs build to assist troubleshooting ([469f2fb](https://github.com/kpeacocke/terraform-github-repo/commit/469f2fbc8f076917214ca7faa00cc46581937b0b))

Generating notes for 1.1.15

## [1.1.14](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.13...v1.1.14) (2025-06-19)

### 🐛 Bug Fixes

* ensure fix-mike-aliases script runs without failing the deployment ([ca2fcdd](https://github.com/kpeacocke/terraform-github-repo/commit/ca2fcdda1ba15f6ea8b70250a7ace7f4fc67863e))

Generating notes for 1.1.14

## [1.1.13](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.12...v1.1.13) (2025-06-19)

### 🐛 Bug Fixes

* improve error handling in deployment scripts and prevent deploying 'latest' as a version ([6e87500](https://github.com/kpeacocke/terraform-github-repo/commit/6e8750077e3ac8cc566ca389a91cbffe6619f5e0))

Generating notes for 1.1.13

## [1.1.12](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.11...v1.1.12) (2025-06-19)

### 🐛 Bug Fixes

* standardize token parameter name in workflows and enhance mike alias conflict resolution ([904b16a](https://github.com/kpeacocke/terraform-github-repo/commit/904b16a2adaa283881dbf0b8c88445366e75e8fe))

Generating notes for 1.1.12

## Changelog

## [1.1.11](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.10...v1.1.11) (2025-06-18)

### 🐛 Bug Fixes (1.1.11)

* enhance MkDocs deployment process and resolve Mike alias conflicts ([66c4e3a](https://github.com/kpeacocke/terraform-github-repo/commit/66c4e3af032eecbc856d4053662740b683d03887))

Generating notes for 1.1.11

## [1.1.10](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.9...v1.1.10) (2025-06-18)

### 🐛 Bug Fixes (1.1.10)

* remove unsupported --no-redirect flag from mike commands ([2bd99d9](https://github.com/kpeacocke/terraform-github-repo/commit/2bd99d9bec102a925f72b25213e2c9e0a8f2907e))

Generating notes for 1.1.10

## [1.1.9](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.8...v1.1.9) (2025-06-18)

### 🐛 Bug Fixes (1.1.9)

* resolve mike alias collision error between version name and alias ([407ae87](https://github.com/kpeacocke/terraform-github-repo/commit/407ae8742907273f9b6e9c2b5e3e3c7595fd1d6f))

Generating notes for 1.1.9

## [1.1.8](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.7...v1.1.8) (2025-06-18)

### 🐛 Bug Fixes (1.1.8)

* update TFLint action to use terraform-linters/setup-tflint@v4.1.1 ([dc55f5f](https://github.com/kpeacocke/terraform-github-repo/commit/dc55f5f68d3e12b13f6557a6a658f792cd55ea7f))

Generating notes for 1.1.8

## [1.1.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.6...v1.1.7) (2025-06-18)

### 🐛 Bug Fixes (1.1.7)

* resolve docs-update job failures by addressing SSL module and mike alias collision issues ([72ccd07](https://github.com/kpeacocke/terraform-github-repo/commit/72ccd079be73bdd474216f700cedecd2f48594d0))

### 📚 Documentation (1.1.7)

* add documentation for docs-update job fixes ([dfd5557](https://github.com/kpeacocke/terraform-github-repo/commit/dfd5557b8a33069d56e079d9c9830c4d708d4b89))

Generating notes for 1.1.7

## [1.1.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.5...v1.1.6) (2025-06-18)

### 🐛 Bug Fixes (1.1.6)

* resolve workflow validation errors in build.yml ([3793b9f](https://github.com/kpeacocke/terraform-github-repo/commit/3793b9f20dd44a246bd1310400565dd3632319ba))

Generating notes for 1.1.6

## [1.1.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.4...v1.1.5) (2025-06-18)

### 🐛 Bug Fixes (1.1.5)

* make GitHub token optional in reusable workflows ([8c3c99a](https://github.com/kpeacocke/terraform-github-repo/commit/8c3c99a1383f3534600b08d63e79ffb75dfebbc7))

Generating notes for 1.1.5

## [1.1.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.3...v1.1.4) (2025-06-18)

### 🐛 Bug Fixes (1.1.4)

* standardize GITHUB_TOKEN parameter name in reusable workflows ([b7f7cda](https://github.com/kpeacocke/terraform-github-repo/commit/b7f7cda0f0ec3e3b0928e341b0e8118e483608f2))

Generating notes for 1.1.4

## [1.1.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.2...v1.1.3) (2025-06-18)

### ♻️ Code Refactoring (1.1.3)

* standardize GitHub Actions workflows using reusable workflows for validation, security, and docs ([ffd645c](https://github.com/kpeacocke/terraform-github-repo/commit/ffd645c023ffb53ed81d052c6663a1d7d34a1c16))

Generating notes for 1.1.3

## [1.1.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.1...v1.1.2) (2025-06-18)

### 🐛 Bug Fixes (1.1.2)

* streamline Git configuration and deployment process in documentation workflow ([bcf66ff](https://github.com/kpeacocke/terraform-github-repo/commit/bcf66ff71b1c1b6df9b9b4d4a422ed60de56ef76))

### 📚 Documentation (1.1.2)

* update changelog for v1.1.1 ([f230070](https://github.com/kpeacocke/terraform-github-repo/commit/f2300707c5d53c2c1335d81a09c5e592882cb910))

Generating notes for 1.1.2

## [1.1.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.1.0...v1.1.1) (2025-06-18)

### 🐛 Bug Fixes (1.1.1)

* refine permissions and enhance deployment process in GitHub Actions ([34efcad](https://github.com/kpeacocke/terraform-github-repo/commit/34efcadb9fed8ae7b5b66c567cf0fd57799d7ae6))

### 📚 Documentation (1.1.1)

* update changelog for v1.1.0 ([2884765](https://github.com/kpeacocke/terraform-github-repo/commit/288476537082d712212ae3e6561238630a7529e6))

Generating notes for 1.1.1

## [1.1.0](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.17...v1.1.0) (2025-06-18)

### 🚀 Features (1.1.0)

* enhance security and cleanup in CI workflows, add credential management guidelines ([7ad7806](https://github.com/kpeacocke/terraform-github-repo/commit/7ad7806d09856f9a1a4fe0eea9712b657ec509f4))

### 📚 Documentation (1.1.0)

* update changelog for v1.0.17 ([14bb6d3](https://github.com/kpeacocke/terraform-github-repo/commit/14bb6d3b6ea10f6feed7e8c16f347d5cc6359083))

Generating notes for 1.1.0

## [1.0.17](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.16...v1.0.17) (2025-06-18)

### 🐛 Bug Fixes (1.0.17)

* add required permissions to build-and-deploy-docs job ([8cb07f9](https://github.com/kpeacocke/terraform-github-repo/commit/8cb07f96f81ae35267b07b9e0393ce845bb6e727))

### 📚 Documentation (1.0.17)

* update changelog for v1.0.16 ([c15deaf](https://github.com/kpeacocke/terraform-github-repo/commit/c15deafccf1e10591ea7fca9dddfbea1d371f78f))

Generating notes for 1.0.17

## [1.0.16](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.15...v1.0.16) (2025-06-18)

### 🐛 Bug Fixes (1.0.16)

* update GitHub Pages deployment permissions ([5f62ddc](https://github.com/kpeacocke/terraform-github-repo/commit/5f62ddc694bdd6c7919a6b5ca1cdd1732f184bbf))

### 📚 Documentation (1.0.16)

* update changelog for v1.0.15 ([6ddc6d4](https://github.com/kpeacocke/terraform-github-repo/commit/6ddc6d463e9e55e12b296ca1562273cdead0564c))

Generating notes for 1.0.16

## [1.0.15](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.14...v1.0.15) (2025-06-18)

### 🐛 Bug Fixes (1.0.15)

* add fetch-depth:0 to docs checkout in release workflow ([8636b36](https://github.com/kpeacocke/terraform-github-repo/commit/8636b36b4bd802120ec3c590f7610a5f0672f446))

### 📚 Documentation (1.0.15)

* update changelog for v1.0.14 ([6fb7298](https://github.com/kpeacocke/terraform-github-repo/commit/6fb7298fed75bd8d44c9dbcdf8e7ede6e114da0f))

Generating notes for 1.0.15

## [1.0.14](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.13...v1.0.14) (2025-06-18)

### 🐛 Bug Fixes (1.0.14)

* resolve git-committers authentication and gh-pages branch conflicts ([e9c7ea1](https://github.com/kpeacocke/terraform-github-repo/commit/e9c7ea17dd0ebeb61760829fa8b924932e3a44f0))

### 📚 Documentation (1.0.14)

* fix MkDocs strict mode issues and add missing documentation files ([5178769](https://github.com/kpeacocke/terraform-github-repo/commit/51787691079219b8a9783adbea7bf798440c7b21))
* update changelog for v1.0.13 ([6b18a34](https://github.com/kpeacocke/terraform-github-repo/commit/6b18a34df643b5a36adf7443bf772d43a21dfaa4))

Generating notes for 1.0.14

## [1.0.13](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.12...v1.0.13) (2025-06-17)

### 🐛 Bug Fixes (1.0.13)

* correct emoji extension paths in MkDocs configuration ([eb62851](https://github.com/kpeacocke/terraform-github-repo/commit/eb62851536287a71ee8d309f324b20118c11b480))

Generating notes for 1.0.13

## [1.0.12](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.11...v1.0.12) (2025-06-17)

### 🐛 Bug Fixes (1.0.12)

* update MkDocs dependencies and improve documentation build process ([ab17abc](https://github.com/kpeacocke/terraform-github-repo/commit/ab17abc8f33f48ec4cef402203e9bfb35ebf52cc))

Generating notes for 1.0.12

## [1.0.11](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.10...v1.0.11) (2025-06-17)

### 🐛 Bug Fixes (1.0.11)

* update documentation dependencies and improve build output ([136f56f](https://github.com/kpeacocke/terraform-github-repo/commit/136f56f3803445571caf22ee79bcaf4a5bd386e8))

Generating notes for 1.0.11

## [1.0.10](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.9...v1.0.10) (2025-06-17)

### 🐛 Bug Fixes (1.0.10)

* update permissions and enhance documentation deployment process ([7b37bfe](https://github.com/kpeacocke/terraform-github-repo/commit/7b37bfeed28139c708ecdcfa95f8d4f1afc17b02))

Generating notes for 1.0.10

## [1.0.9](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.8...v1.0.9) (2025-06-17)

### 🐛 Bug Fixes (1.0.9)

* add permissions for discussions in terraform-registry and notify jobs ([d9af872](https://github.com/kpeacocke/terraform-github-repo/commit/d9af8728ea57f2245af964aff262f44d248efd58))

Generating notes for 1.0.9

## [1.0.8](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.7...v1.0.8) (2025-06-17)

### 🐛 Bug Fixes (1.0.8)

* enhance release comment handling by using discussion URL or creating a new issue ([a5e94f6](https://github.com/kpeacocke/terraform-github-repo/commit/a5e94f6cdc1c3f6170b6761d35d51ce26d1a112c))

Generating notes for 1.0.8

## [1.0.7](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.6...v1.0.7) (2025-06-17)

### 🐛 Bug Fixes (1.0.7)

* update GitHub API call to create release comment for improved functionality ([a5770fa](https://github.com/kpeacocke/terraform-github-repo/commit/a5770fa1326296699731a2586ca63343715c0545))

Generating notes for 1.0.7

## [1.0.6](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.5...v1.0.6) (2025-06-17)

### 🐛 Bug Fixes (1.0.6)

* add GitHub token to Terraform plan steps for enhanced security ([51a53e3](https://github.com/kpeacocke/terraform-github-repo/commit/51a53e3084bb5be167f4a3b43729e31f12426708))

Generating notes for 1.0.6

## [1.0.5](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.4...v1.0.5) (2025-06-17)

### 🐛 Bug Fixes (1.0.5)

* refactor issue fetching logic in traceability workflow for improved error handling ([dd9c35c](https://github.com/kpeacocke/terraform-github-repo/commit/dd9c35cc8cb69977cd7cf51642727a316ff3083e))
* remove custom_dir from theme configuration in mkdocs.yml ([9be77af](https://github.com/kpeacocke/terraform-github-repo/commit/9be77af56dfc3ecdfa05024dbf2c93b449981cb6))

Generating notes for 1.0.5

## [1.0.4](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.3...v1.0.4) (2025-06-17)

### 🐛 Bug Fixes (1.0.4)

* implement code changes to enhance functionality and improve performance ([c74db8b](https://github.com/kpeacocke/terraform-github-repo/commit/c74db8bb1dd0ca9168c1e2a3f8233215e958cd62))

Generating notes for 1.0.4

## [1.0.3](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.2...v1.0.3) (2025-06-17)

### 🐛 Bug Fixes (1.0.3)

* update Go version and SonarCloud action, refactor E2E tests for better structure ([1bc2c1b](https://github.com/kpeacocke/terraform-github-repo/commit/1bc2c1b8086d28e46b6ce1e091d880d7c514c359))

Generating notes for 1.0.3

## [1.0.2](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.1...v1.0.2) (2025-06-17)

### 🐛 Bug Fixes (1.0.2)

* update Terraform provider versions in SonarCloud configuration ([7f6b0ee](https://github.com/kpeacocke/terraform-github-repo/commit/7f6b0eedd4de562ae80e620bb48eaa176a476763))

Generating notes for 1.0.2

## [1.0.1](https://github.com/kpeacocke/terraform-github-repo/compare/v1.0.0...v1.0.1) (2025-06-17)

### 🐛 Bug Fixes (1.0.1)

* add check for changes before committing coverage report to wiki ([d97aaec](https://github.com/kpeacocke/terraform-github-repo/commit/d97aaec6764e82b27a59609f3a3c39cf18be25f9))

Generating notes for 1.0.1

## 1.0.0 (2025-06-17)

### 🚀 Features (1.0.0)

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

## [1.1.0] - 2025-06-05

### Added

* Refactored `variables.tf` and `outputs.tf` for clarity, registry readiness, and added `try(...)` error handling
* Taskfile `docs` task and Husky pre-commit hook to auto-inject Terraform docs via `terraform-docs`
* Complete `examples/minimal` with local backend config, variables, and outputs

### Changed

* Updated `README.md` for Terraform Registry conventions and integrated `terraform-docs` injection
* `.terraform-docs.yml` fixed to use proper map format for `sections`

### Fixed

* Removed unsupported output attributes (`.html_url`/`.url`)
* Disabled TFLint unused declarations rule to avoid false positives

### Maintenance

* Increased commitlint header length limit to 120 characters
* Tagged and published versions v1.0.0 and v1.1.0
