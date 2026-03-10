#!/bin/bash
# validate-all.sh
# Validates all prompts and skills in the repository

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PROMPTS_DIR="$REPO_ROOT/prompts"
SKILLS_DIR="$REPO_ROOT/skills/updated-skills"

# --- Validate prompts ---
echo "Validating all prompts in $PROMPTS_DIR..."
echo

PROMPT_TOTAL=0
PROMPT_PASSED=0
PROMPT_FAILED=0

while IFS= read -r file; do
  [ -z "$file" ] && continue
  PROMPT_TOTAL=$((PROMPT_TOTAL + 1))
  if bash "$SCRIPT_DIR/validate-prompt.sh" "$file"; then
    PROMPT_PASSED=$((PROMPT_PASSED + 1))
  else
    PROMPT_FAILED=$((PROMPT_FAILED + 1))
  fi
  echo
done < <(find "$PROMPTS_DIR" -type f -name "*.md" ! -name "*_template*" ! -name "INDEX.md" | sort)

# --- Validate skills ---
SKILL_TOTAL=0
SKILL_PASSED=0
SKILL_FAILED=0

if [ -d "$SKILLS_DIR" ]; then
  echo "Validating all skills in $SKILLS_DIR..."
  echo

  while IFS= read -r file; do
    [ -z "$file" ] && continue
    SKILL_TOTAL=$((SKILL_TOTAL + 1))
    if bash "$SCRIPT_DIR/validate-skill.sh" "$file"; then
      SKILL_PASSED=$((SKILL_PASSED + 1))
    else
      SKILL_FAILED=$((SKILL_FAILED + 1))
    fi
    echo
  done < <(find "$SKILLS_DIR" -type f -name "SKILL.md" | sort)
fi

TOTAL=$((PROMPT_TOTAL + SKILL_TOTAL))
PASSED=$((PROMPT_PASSED + SKILL_PASSED))
FAILED=$((PROMPT_FAILED + SKILL_FAILED))

echo "================================"
echo "Validation Summary"
echo "================================"
echo "Prompts: $PROMPT_PASSED/$PROMPT_TOTAL passed"
echo "Skills:  $SKILL_PASSED/$SKILL_TOTAL passed"
echo "--------------------------------"
echo "Total:   $PASSED/$TOTAL passed"
echo "Failed:  $FAILED"
echo "================================"

if [ $FAILED -gt 0 ]; then
  exit 1
fi
