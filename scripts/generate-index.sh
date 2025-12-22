#!/bin/bash
# generate-index.sh
# Automatically generate prompts/INDEX.md from all prompts

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PROMPTS_DIR="$REPO_ROOT/prompts"
INDEX_FILE="$PROMPTS_DIR/INDEX.md"

echo "Generating prompt index..."

# Start the index file
cat > "$INDEX_FILE" << 'EOF'
# Prompt Catalog

Quick reference for finding and discovering prompts in this repository.

## By Category

EOF

# Function to extract YAML field value
get_field() {
  local file="$1"
  local field="$2"
  grep "^${field}:" "$file" | head -1 | sed "s/^${field}: *//" | sed 's/^"//' | sed 's/"$//'
}

capitalize() {
  local input="$1"
  python3 - <<'PY' "$input"
import sys
s = sys.argv[1]
print(s[:1].upper() + s[1:]) if s else print("")
PY
}

# Group prompts by category
for category_dir in "$PROMPTS_DIR"/*/; do
  category=$(basename "$category_dir")

  # Skip if not a directory or is special
  if [ ! -d "$category_dir" ] || [ "$category" = "_template.md" ]; then
    continue
  fi

  category_title=$(capitalize "$category")
  # Check if category has any prompts
  prompt_files=("$category_dir"*.md)
  if [ ! -f "${prompt_files[0]}" ]; then
    continue
  fi

  echo "### ${category_title}" >> "$INDEX_FILE"

  for prompt_file in "$category_dir"*.md; do
    if [ -f "$prompt_file" ]; then
      filename=$(basename "$prompt_file" .md)

      # Extract metadata
      title=$(get_field "$prompt_file" "title")
      description=$(get_field "$prompt_file" "description")
      tags=$(get_field "$prompt_file" "tags")
      models=$(get_field "$prompt_file" "models")

      # Extract variable names
      variables=$(grep -A 100 "^variables:" "$prompt_file" | grep "  - name:" | sed 's/.*name: *//' | tr '\n' ', ' | sed 's/, $//')

      # Write to index
      cat >> "$INDEX_FILE" << EOF
- **[$title]($category/$filename.md)**
  - Description: $description
  - Tags: $tags
  - Models: $models
  - Variables: $variables

EOF
    fi
  done
done

# Add "By Tag" section
cat >> "$INDEX_FILE" << 'EOF'

## By Tag

EOF

TAG_TMP=$(mktemp)
for prompt_file in $(find "$PROMPTS_DIR" -type f -name "*.md" ! -name "*_template*" ! -name "INDEX.md"); do
  tags_line=$(grep "^tags:" "$prompt_file" | head -1)
  [ -z "$tags_line" ] && continue
  tags=$(echo "$tags_line" | sed 's/tags: *\[//' | sed 's/\]//' | sed 's/, */ /g')
  relative_path=$(echo "$prompt_file" | sed "s|$PROMPTS_DIR/||")
  for tag in $tags; do
    tag=$(echo "$tag" | tr -d '[],"')
    [ -n "$tag" ] && echo "$tag $relative_path" >> "$TAG_TMP"
  done
done

for tag in $(cut -d' ' -f1 "$TAG_TMP" | sort -u); do
  echo "- **$tag**:" >> "$INDEX_FILE"
  grep "^$tag " "$TAG_TMP" | cut -d' ' -f2- | while read -r path; do
    echo "  - [$path]($path)" >> "$INDEX_FILE"
  done
done
rm -f "$TAG_TMP"

# Add "By Model" section
cat >> "$INDEX_FILE" << 'EOF'

## By Model

EOF

MODEL_TMP=$(mktemp)
for prompt_file in $(find "$PROMPTS_DIR" -type f -name "*.md" ! -name "*_template*" ! -name "INDEX.md"); do
  models_line=$(grep "^models:" "$prompt_file" | head -1)
  [ -z "$models_line" ] && continue
  models=$(echo "$models_line" | sed 's/models: *\[//' | sed 's/\]//' | sed 's/, */ /g')
  relative_path=$(echo "$prompt_file" | sed "s|$PROMPTS_DIR/||")
  for model in $models; do
    model=$(echo "$model" | tr -d '[],"')
    [ -n "$model" ] && echo "$model $relative_path" >> "$MODEL_TMP"
  done
done

for model in $(cut -d' ' -f1 "$MODEL_TMP" | sort -u); do
  echo "### $model" >> "$INDEX_FILE"
  grep "^$model " "$MODEL_TMP" | cut -d' ' -f2- | while read -r path; do
    echo "- [$path]($path)" >> "$INDEX_FILE"
  done
done
rm -f "$MODEL_TMP"

# Add search commands section
cat >> "$INDEX_FILE" << 'EOF'

## Quick Search Commands

Search by tag:
```bash
grep -r "tags:.*refactor" prompts/ --include="*.md"
```

Search by model:
```bash
grep -r "models:.*gpt-5.2" prompts/ --include="*.md"
```

Search by variable:
```bash
grep -r "{{language}}" prompts/ --include="*.md"
```

Find prompts with optional variables:
```bash
grep -r "required: false" prompts/ --include="*.md"
```

---
EOF

# Add footer with date
echo "*Last updated: $(date +%Y-%m-%d)*" >> "$INDEX_FILE"
echo "*To regenerate: \`scripts/generate-index.sh\`*" >> "$INDEX_FILE"

echo "✅ Index generated: $INDEX_FILE"
