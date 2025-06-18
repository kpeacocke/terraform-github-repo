#!/usr/bin/env bash
set -euo pipefail

# Run terraform plan and check for unexpected resource changes
PLAN_FILE="ci-tfplan.json"
terraform plan -input=false -refresh=false -no-color -compact-warnings -out=tfplan.binary
terraform show -json tfplan.binary > "$PLAN_FILE"
# Remove binary plan file immediately after converting to JSON to avoid persisting sensitive data
rm -f tfplan.binary

# Check for resource changes in the plan
ADDED=$(jq '.resource_changes[] | select(.change.actions | index("create"))' "$PLAN_FILE" | wc -l)
DESTROYED=$(jq '.resource_changes[] | select(.change.actions | index("delete"))' "$PLAN_FILE" | wc -l)

if [[ "$ADDED" -gt 0 || "$DESTROYED" -gt 0 ]]; then
  echo "\n[ERROR] Drift detected: $ADDED to add, $DESTROYED to destroy. Review plan output: $PLAN_FILE"
  exit 1
else
  echo "No drift detected. Plan is clean."
fi
