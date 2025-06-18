# Credential Security Guidelines

## Local Development

For local development and testing, follow these steps for secure credential management:

1. Copy `.env.example` to `.env` (which is git-ignored)

   ```bash
   cp .env.example .env
   ```

2. Edit your `.env` file and add your personal access token and other required variables

   ```properties
   GITHUB_TOKEN=your_personal_access_token
   GITHUB_OWNER=your_github_username_or_org
   ```

3. When running Terraform or tests, the environment variables will be automatically loaded

## CI/CD Workflows

In GitHub Actions workflows:

- Use GitHub repository secrets for all credentials
- Reference them via `${{ secrets.SECRET_NAME }}`
- Never commit tokens or sensitive data directly to any files

## Terraform Plan Files

- Terraform plan files (`.tfplan`, `tfplan.binary`, etc.) **contain sensitive values, including PATs and tokens**
- These files are now excluded by `.gitignore`, but you should be extra cautious:
  - Never commit these files to version control
  - Delete plan files immediately after use (`rm -f tfplan.binary`)
  - Use `-compact-warnings` flag to reduce sensitive data in logs
  - Use `-no-color` flag to avoid ANSI codes that may obfuscate patterns in security scans
  - Always verify no plan files exist using `git status` before pushing
- Our CI workflows have been updated to automatically delete plan files after use

## Rotating Compromised Credentials

If credentials are ever compromised:

1. Immediately revoke the compromised token/credential
2. Generate a new token with appropriate scopes
3. Update all repository secrets with the new token
4. Check repository history for any other potential leaks

## Checking for Committed Sensitive Data

If you suspect sensitive data may have been committed, use these steps:

1. **Check for tokens in the repository**:
   
   ```bash
   git grep -i "token\|secret\|password\|key\|credential" -- "*.tf" "*.tfvars" "*.sh" "*.md"
   ```

2. **Check for accidentally committed plan files**:
   
   ```bash
   git ls-files | grep -E "tfplan|\.binary$|plan\.json"
   ```

3. **Use git-secrets or other scanning tools**:
   
   ```bash
   # If git-secrets is installed
   git secrets --scan
   ```

4. **If sensitive data is found**:
   
   - Revoke the compromised credentials immediately
   - Create a new commit that replaces the sensitive data
   - Consider using BFG Repo-Cleaner or git-filter-repo to clean history
   - Force-push the cleaned history after coordinating with your team

5. **Consult detailed guidance on handling leaks in our [Sensitive Data](./sensitive-data.md) documentation**
