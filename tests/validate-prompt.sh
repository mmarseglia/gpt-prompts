#!/bin/bash
# validate-prompt.sh
# Validates a single prompt file against the schema and basic frontmatter rules

set -euo pipefail

PROMPT_FILE="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JS_VALIDATOR="$SCRIPT_DIR/validate-frontmatter.js"

if [ -z "$PROMPT_FILE" ]; then
  echo "Usage: $0 <prompt-file.md>"
  exit 1
fi

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Error: File not found: $PROMPT_FILE"
  exit 1
fi

if [ ! -f "$JS_VALIDATOR" ]; then
  echo "Error: Validator missing: $JS_VALIDATOR"
  exit 1
fi

echo "Validating $PROMPT_FILE..."

# Basic frontmatter presence check before schema validation
if ! grep -q "^---" "$PROMPT_FILE"; then
  echo "  ❌ Missing YAML frontmatter start delimiter ('---')"
  exit 1
fi

# Schema validation
if node "$JS_VALIDATOR" "$PROMPT_FILE"; then
  echo "  ✅ Validation passed"
else
  exit 1
fi
