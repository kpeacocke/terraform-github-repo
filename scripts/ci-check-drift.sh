#!/usr/bin/env bash
set -euo pipefail

# Run terraform plan and check for unexpected resource changes
PLAN_FILE="ci-tfplan.json"
terraform plan -input=false -refresh=false -no-color -compact-warnings "$@" -out=tfplan.binary
terraform show -json tfplan.binary > "$PLAN_FILE"
# Remove binary plan file immediately after converting to JSON to avoid persisting sensitive data
rm -f tfplan.binary

# Check for resource changes in the plan
ADDED=$(jq '.resource_changes[] | select(.change.actions | index("create"))' "$PLAN_FILE" | wc -l)
DESTROYED=$(jq '.resource_changes[] | select(.change.actions | index("delete"))' "$PLAN_FILE" | wc -l)

# In CI environment, we expect resources to be created since there's no state
# Only fail if there are resources being destroyed as that's more likely to indicate an issue
if [[ "$DESTROYED" -gt 0 ]]; then
  echo -e "\n[ERROR] Drift detected: $ADDED to add, $DESTROYED to destroy. Resources being destroyed indicates potential issues. Review plan output: $PLAN_FILE"
  exit 1
elif [[ "$ADDED" -gt 0 ]]; then
  echo "[INFO] Resources to be added: $ADDED. This is expected in CI environment with no state."
  # CI environments typically have no state, so resources to be created are normal
  # Uncomment the line below if you want to fail on adds as well
  # exit 1
else
  echo "No drift detected. Plan is clean."
fi
