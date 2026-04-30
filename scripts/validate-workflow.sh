#!/usr/bin/env bash
# Script to validate GitHub Actions workflow YAML files

set -euo pipefail

# Find yamllint if available
if ! command -v yamllint &> /dev/null; then
  echo "⚠️  yamllint not found - skipping detailed YAML validation"
  YAML_LINT_AVAILABLE=false
else
  YAML_LINT_AVAILABLE=true
fi

# Find GitHub Actions CLI if available
if ! command -v act &> /dev/null; then
  echo "⚠️  act CLI not found - skipping GitHub Actions validation"
  ACT_CLI_AVAILABLE=false
else
  ACT_CLI_AVAILABLE=true
fi

# Validate a single file
validate_file() {
  local file=$1
  echo "🔍 Validating $file..."
  
  # Basic syntax check with Python (always available)
  python3 -c "import yaml; yaml.safe_load(open('$file'))" || {
    echo "❌ YAML syntax error in $file"
    return 1
  }
  
  # Detailed validation with yamllint if available
  if [ "$YAML_LINT_AVAILABLE" = true ]; then
    yamllint -f parsable "$file" || {
      echo "⚠️  YAML lint warnings in $file (may not be critical)"
    }
  fi
  
  # GitHub Actions validation with act CLI if available
  if [ "$ACT_CLI_AVAILABLE" = true ] && [[ "$file" == *"workflows"* ]]; then
    echo "🧪 Testing workflow with act CLI..."
    act -n -W "$file" || {
      echo "⚠️  GitHub Actions validation warnings (may not be critical)"
    }
  fi
  
  echo "✅ $file validation complete"
  return 0
}

# Main function
main() {
  # Check if specific files were provided
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <workflow-file.yml> [workflow-file2.yml] ..."
    echo "Validating all workflow files..."
    
    # Find all GitHub Actions workflow files
    files=$(find .github/workflows -name "*.yml" 2>/dev/null || echo "")
    
    if [ -z "$files" ]; then
      echo "No workflow files found in .github/workflows/"
      return 1
    fi
  else
    files="$@"
  fi
  
  # Validate each file
  for file in $files; do
    if [ -f "$file" ]; then
      validate_file "$file" || exit_code=1
    else
      echo "❌ File not found: $file"
      exit_code=1
    fi
  done
  
  if [ "${exit_code:-0}" -eq 0 ]; then
    echo "✅ All validations passed!"
  else
    echo "❌ Some validations failed."
  fi
  
  return "${exit_code:-0}"
}

# Run main function
main "$@"
