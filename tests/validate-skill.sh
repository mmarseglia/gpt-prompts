#!/bin/bash
# validate-skill.sh
# Validates a single SKILL.md file against the skill schema

set -euo pipefail

SKILL_FILE="${1:-}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JS_VALIDATOR="$SCRIPT_DIR/validate-skill-frontmatter.js"

if [ -z "$SKILL_FILE" ]; then
  echo "Usage: $0 <SKILL.md>"
  exit 1
fi

if [ ! -f "$SKILL_FILE" ]; then
  echo "Error: File not found: $SKILL_FILE"
  exit 1
fi

if [ ! -f "$JS_VALIDATOR" ]; then
  echo "Error: Validator missing: $JS_VALIDATOR"
  exit 1
fi

echo "Validating $SKILL_FILE..."

# Basic frontmatter presence check before schema validation
if ! grep -q "^---" "$SKILL_FILE"; then
  echo "  ❌ Missing YAML frontmatter start delimiter ('---')"
  exit 1
fi

# Schema validation
if node "$JS_VALIDATOR" "$SKILL_FILE"; then
  echo "  ✅ Validation passed"
else
  exit 1
fi
