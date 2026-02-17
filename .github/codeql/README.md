# CodeQL Security Analysis

This project includes CodeQL security analysis for Go and JavaScript code.

## Setup

### GitHub Actions (Automated)

CodeQL analysis runs automatically on:

- Push to main/master branch
- Pull requests to main/master branch  
- Weekly scheduled scans (Thursdays at 6:34 PM UTC)

### Local Analysis (Manual)

#### Prerequisites

1. Install CodeQL CLI: [https://github.com/github/codeql-cli-binaries/releases](https://github.com/github/codeql-cli-binaries/releases)
2. Add CodeQL to your PATH
3. Install the CodeQL VS Code extension (already configured)

#### Running Analysis

1. **Create CodeQL Database:**

   ```bash
   # From VS Code: Ctrl+Shift+P -> "Tasks: Run Task" -> "CodeQL Database Create"
   # Or manually:
   codeql database create codeql-db --language=go --source-root=.
   ```

2. **Run Standard Security Analysis:**

   ```bash
   # From VS Code: Ctrl+Shift+P -> "Tasks: Run Task" -> "CodeQL Analyze"  
   # Or manually:
   codeql database analyze codeql-db --format=csv --output=codeql-results.csv codeql/go-queries/security
   ```

3. **Run Custom Queries:**

   ```bash
   # From VS Code: Ctrl+Shift+P -> "Tasks: Run Task" -> "CodeQL Custom Queries"
   # Or manually:
   codeql database analyze codeql-db --format=sarif-latest --output=codeql-custom-results.sarif .github/codeql/queries/
   ```

## Custom Queries

The project includes custom security queries in `.github/codeql/queries/`:

- **go-hardcoded-credentials.ql**: Detects hardcoded GitHub tokens
- **go-env-injection.ql**: Finds environment variable injection risks
- **custom-security.qls**: Query suite for all custom security queries

## Configuration

- **Workflow**: `.github/workflows/codeql.yml`
- **Config**: `.github/codeql/codeql-config.yml`
- **VS Code Settings**: `.vscode/settings.json`
- **VS Code Tasks**: `.vscode/tasks.json`

## Excluded Paths

The following paths are excluded from analysis:

- `test/fixtures/**`
- `examples/**`
- `templates/**`
- `*.tfstate*`
- `coverage.out`
- `go-test*.log`

## Results

- GitHub Actions results appear in the Security tab of your repository
- Local results are saved as:
  - `codeql-results.csv` (standard queries)
  - `codeql-custom-results.sarif` (custom queries)

## Adding New Queries

1. Create `.ql` files in `.github/codeql/queries/`
2. Update `.github/codeql/queries/custom-security.qls` if needed
3. Test locally before committing
