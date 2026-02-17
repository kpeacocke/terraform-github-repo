#!/bin/bash
set -euo pipefail

# Simple security validation script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🔒 GitHub Actions Security Validation"
echo "====================================="

workflow_dir="$PROJECT_ROOT/.github/workflows"
issues=0

echo ""
echo "📁 Checking workflows in: $workflow_dir"
echo ""

for workflow_file in "$workflow_dir"/*.yml; do
    if [ -f "$workflow_file" ]; then
        workflow_name=$(basename "$workflow_file")
        echo "🔍 Checking: $workflow_name"
        
        # Check for unpinned actions (excluding comments)
        unpinned=$(grep -E "uses:.*@(v[0-9]+|master|main)" "$workflow_file" | grep -v "#" || true)
        if [ -n "$unpinned" ]; then
            echo "  ⚠️  Unpinned actions found:"
            echo "$unpinned" | head -3 | sed 's/^/      /'
            ((issues++))
        else
            echo "  ✅ All actions are SHA-pinned"
        fi
        
        # Check for permissions
        if grep -q "permissions:" "$workflow_file"; then
            echo "  ✅ Permissions declared"
        else
            echo "  ⚠️  Missing permissions declaration"
            ((issues++))
        fi
        
        echo ""
    fi
done

echo "📊 Summary:"
echo "  Total workflows: $(find "$workflow_dir" -name "*.yml" | wc -l)"
echo "  Security issues: $issues"

if [ $issues -eq 0 ]; then
    echo "  🎉 All workflows are security-hardened!"
else
    echo "  ⚠️  Security improvements needed"
fi

echo ""
echo "🔧 To fix issues:"
echo "  1. Pin actions to SHA commits"
echo "  2. Add explicit permissions to workflows"
echo "  3. Use task security:harden to apply fixes"
