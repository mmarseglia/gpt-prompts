#!/bin/bash
# validate-all.sh
# Validates all prompts in the repository

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$(dirname "$SCRIPT_DIR")/prompts"

echo "Validating all prompts in $PROMPTS_DIR..."
echo

TOTAL=0
PASSED=0
FAILED=0

while IFS= read -r file; do
  [ -z "$file" ] && continue
  TOTAL=$((TOTAL + 1))
  if bash "$SCRIPT_DIR/validate-prompt.sh" "$file"; then
    PASSED=$((PASSED + 1))
  else
    FAILED=$((FAILED + 1))
  fi
  echo
done < <(find "$PROMPTS_DIR" -type f -name "*.md" ! -name "*_template*" ! -name "INDEX.md" | sort)

echo "================================"
echo "Validation Summary"
echo "================================"
echo "Total prompts: $TOTAL"
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "================================"

if [ $FAILED -gt 0 ]; then
  exit 1
fi
