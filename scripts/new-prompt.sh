#!/bin/bash
# new-prompt.sh
# Quick prompt creation script

set -e

CATEGORY="$1"
NAME="$2"

if [ -z "$CATEGORY" ] || [ -z "$NAME" ]; then
  echo "Usage: $0 <category> <name>"
  echo ""
  echo "Examples:"
  echo "  $0 coding debug-error"
  echo "  $0 writing email-template"
  echo "  $0 analysis trend-analysis"
  echo ""
  echo "Available categories:"
  ls -d prompts/*/ 2>/dev/null | sed 's|prompts/||g' | sed 's|/||g' | grep -v "^$" | sed 's/^/  - /'
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
CATEGORY_DIR="$REPO_ROOT/prompts/$CATEGORY"
TEMPLATE_FILE="$REPO_ROOT/prompts/_template.md"
NEW_FILE="$CATEGORY_DIR/${NAME}.md"

# Create category directory if it doesn't exist
if [ ! -d "$CATEGORY_DIR" ]; then
  echo "Creating new category: $CATEGORY"
  mkdir -p "$CATEGORY_DIR"
fi

# Check if prompt already exists
if [ -f "$NEW_FILE" ]; then
  echo "Error: Prompt already exists: $NEW_FILE"
  exit 1
fi

# Copy template
cp "$TEMPLATE_FILE" "$NEW_FILE"

# Update category in the new file
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/use_case: category-name/use_case: $CATEGORY/g" "$NEW_FILE"
  sed -i '' "s/author: username/author: $USER/g" "$NEW_FILE"
else
  # Linux
  sed -i "s/use_case: category-name/use_case: $CATEGORY/g" "$NEW_FILE"
  sed -i "s/author: username/author: $USER/g" "$NEW_FILE"
fi

echo "✅ Created new prompt: $NEW_FILE"
echo ""
echo "Next steps:"
echo "1. Edit the prompt file and fill in the metadata"
echo "2. Write the prompt content with {{variable}} placeholders"
echo "3. Add examples with expected behavior"
echo "4. Test with target models"
echo "5. Validate: tests/validate-prompt.sh $NEW_FILE"
echo "6. Update prompts/INDEX.md"
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
