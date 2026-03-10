#!/bin/bash
# new-skill.sh
# Quick skill creation script

set -e

NAME="$1"

if [ -z "$NAME" ]; then
  echo "Usage: $0 <skill-name>"
  echo ""
  echo "Examples:"
  echo "  $0 code-reviewer"
  echo "  $0 test-generator"
  echo ""
  echo "Existing skills:"
  ls -d skills/updated-skills/*/ 2>/dev/null | sed 's|skills/updated-skills/||g' | sed 's|/||g' | grep -v "^$" | sed 's/^/  - /'
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILL_DIR="$REPO_ROOT/skills/updated-skills/$NAME"
TEMPLATE_FILE="$REPO_ROOT/skills/_template/SKILL.md"
NEW_FILE="$SKILL_DIR/SKILL.md"

# Check if skill already exists
if [ -d "$SKILL_DIR" ]; then
  echo "Error: Skill already exists: $SKILL_DIR"
  exit 1
fi

# Check template exists
if [ ! -f "$TEMPLATE_FILE" ]; then
  echo "Error: Template missing: $TEMPLATE_FILE"
  exit 1
fi

# Create skill directory
mkdir -p "$SKILL_DIR"

# Copy template
cp "$TEMPLATE_FILE" "$NEW_FILE"

# Update name in the new file
TODAY=$(date +%Y-%m-%d)
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' "s/name: skill-name/name: $NAME/g" "$NEW_FILE"
  sed -i '' "s/YYYY-MM-DD/$TODAY/g" "$NEW_FILE"
else
  sed -i "s/name: skill-name/name: $NAME/g" "$NEW_FILE"
  sed -i "s/YYYY-MM-DD/$TODAY/g" "$NEW_FILE"
fi

echo "✅ Created new skill: $NEW_FILE"
echo ""
echo "Next steps:"
echo "1. Edit the SKILL.md and fill in the description with trigger phrases"
echo "2. Write the skill instructions with process/output/standards sections"
echo "3. Optionally create a references/ subdirectory for supporting files"
echo "4. Validate: tests/validate-skill.sh $NEW_FILE"
echo "5. Regenerate index: scripts/generate-index.sh"
echo ""
echo "Opening file..."

# Try to open in editor if available
if command -v code &> /dev/null; then
  code "$NEW_FILE"
elif command -v vim &> /dev/null; then
  vim "$NEW_FILE"
else
  echo "File created at: $NEW_FILE"
fi
