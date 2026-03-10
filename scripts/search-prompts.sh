#!/bin/bash
# search-prompts.sh
# Search prompts by tag, model, keyword, or variable

set -e

QUERY="$1"
SEARCH_TYPE="${2:-all}"  # all, tag, model, variable, keyword

if [ -z "$QUERY" ]; then
  echo "Usage: $0 <query> [search-type]"
  echo ""
  echo "Search types:"
  echo "  all       - Search everywhere (default)"
  echo "  tag       - Search in tags only"
  echo "  model     - Search in models only"
  echo "  variable  - Search for variable placeholders"
  echo "  keyword   - Search in title and description"
  echo ""
  echo "Examples:"
  echo "  $0 refactor tag"
  echo "  $0 gpt-5.2 model"
  echo "  $0 '{{language}}' variable"
  echo "  $0 'data analysis' keyword"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PROMPTS_DIR="$REPO_ROOT/prompts"
SKILLS_DIR="$REPO_ROOT/skills/updated-skills"

echo "Searching for: $QUERY (type: $SEARCH_TYPE)"
echo "================================"
echo ""

echo "--- Prompts ---"
case "$SEARCH_TYPE" in
  tag)
    grep -r "tags:.*$QUERY" "$PROMPTS_DIR" --include="*.md" -l | grep -v "_template" | grep -v "INDEX" || true
    ;;
  model)
    grep -r "models:.*$QUERY" "$PROMPTS_DIR" --include="*.md" -l | grep -v "_template" | grep -v "INDEX" || true
    ;;
  variable)
    grep -r "$QUERY" "$PROMPTS_DIR" --include="*.md" -l | grep -v "_template" | grep -v "INDEX" || true
    ;;
  keyword)
    grep -r -E "(title|description):.*$QUERY" "$PROMPTS_DIR" --include="*.md" -l -i | grep -v "_template" | grep -v "INDEX" || true
    ;;
  all|*)
    grep -r "$QUERY" "$PROMPTS_DIR" --include="*.md" -l -i | grep -v "_template" | grep -v "INDEX" || true
    ;;
esac

if [ -d "$SKILLS_DIR" ]; then
  echo ""
  echo "--- Skills ---"
  case "$SEARCH_TYPE" in
    keyword)
      grep -r -E "(name|description):.*$QUERY" "$SKILLS_DIR" --include="*.md" -l -i | grep -v "_template" || true
      ;;
    all|*)
      grep -r "$QUERY" "$SKILLS_DIR" --include="*.md" -l -i | grep -v "_template" || true
      ;;
  esac
fi

echo ""
echo "================================"
echo "Search complete"
