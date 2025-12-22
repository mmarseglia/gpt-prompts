# Prompt Repository
Lightweight structure for storing, discovering, and iterating on generative AI prompts with metadata, tagging, and simple templating.

## Quick Start

1. **Browse prompts**: Check [prompts/INDEX.md](prompts/INDEX.md) for a searchable catalog
2. **Use a prompt**: Replace `{{variables}}` with your values
3. **Add a prompt**: `scripts/new-prompt.sh <category> <name>`
4. **Validate**: `tests/validate-all.sh` before committing

## Repository Layout

```
gpt-prompts/
├── prompts/              # Prompt files grouped by use case
│   ├── INDEX.md         # Searchable catalog of all prompts
│   ├── _template.md     # Template for new prompts
│   ├── coding/          # Code-related prompts
│   ├── writing/         # Content creation prompts
│   └── analysis/        # Data analysis prompts
├── tests/               # Validation scripts and test runs
│   ├── validate-prompt.sh
│   ├── validate-all.sh
│   └── example-runs/    # Documented test executions
├── scripts/             # Helper scripts for prompt management
├── docs/                # Additional documentation
└── schema/              # Validation schemas
```

## Prompt Format

Every prompt is a Markdown file that begins with YAML front matter. See [prompts/_template.md](prompts/_template.md) for the full template.

### Required Fields

```yaml
title: Short, descriptive name
description: One-line summary of what this prompt does
use_case: category-name (coding, writing, analysis, etc.)
models: [gpt-5.2, claude-opus-4-5]  # Models this works with
tags: [tag-a, tag-b]  # Searchable tags
version: 1.0.0  # SemVer format
variables:  # Document all {{placeholders}}
  - name: variable_name
    required: true
    type: string  # string|code|number|boolean
    note: What this variable represents
examples:  # At least one test case
  - input: "Example usage..."
    expected_behavior: "What should happen..."
```

### Enhanced Metadata (Recommended)

```yaml
created: 2025-12-22
updated: 2025-12-22
author: username
tested_with:  # Detailed testing info
  - model: gpt-5.2
    version: latest
    status: experimental  # verified|experimental|deprecated
    last_tested: 2025-12-22
compatibility_notes: "Model-specific behaviors or known issues"
performance_notes: "Response time, token usage observations"
quality_score: 8.5  # 0-10 scale
related_prompts: [other-prompt-name]  # Similar/complementary prompts
```

### Versioning

Use [SemVer](https://semver.org/) for version numbers:
- **Major** (X.0.0): Behavioral changes, breaking changes to variables
- **Minor** (0.X.0): Guidance improvements, new optional features
- **Patch** (0.0.X): Metadata updates, typo fixes, clarifications

## Using Prompts

1. **Find a prompt**: Browse [prompts/INDEX.md](prompts/INDEX.md) or search by tag/model
2. **Read the frontmatter**: Check `variables` to see what you need to provide
3. **Replace placeholders**: Substitute `{{variable_name}}` with your actual values
4. **Test**: Compare output against `expected_behavior` in the examples

### Example

For `prompts/coding/refactor-function.md`:

```
Input to LLM:
--------------
[Copy the entire prompt content]

Replace:
  {{language}} → Python
  {{code}} → def add(a,b):return a+b
```

## Quick Reference Table

| Prompt | Use Case | Models | Variables |
|--------|----------|--------|-----------|
| [refactor-function](prompts/coding/refactor-function.md) | Coding | gpt-5.2, claude-opus-4-5 | language, code |
| [blog-outline](prompts/writing/blog-outline.md) | Writing | gpt-5.2, claude-opus-4-5 | topic, audience, goal |
| [data-summary](prompts/analysis/data-summary.md) | Analysis | gpt-5.2, claude-opus-4-5 | context, metrics, audience |

## Search Strategies

### By Tag
```bash
grep -r "tags:.*refactor" prompts/ --include="*.md"
```

### By Model
```bash
grep -r "models:.*claude" prompts/ --include="*.md"
```

### By Variable
```bash
grep -r "{{language}}" prompts/ --include="*.md"
```

### Find Prompts with Optional Variables
```bash
grep -r "required: false" prompts/ --include="*.md"
```

## Adding New Prompts

### Quick Method
```bash
scripts/new-prompt.sh coding my-new-prompt
# Edit prompts/coding/my-new-prompt.md
```

### Manual Method
1. Copy `prompts/_template.md` to `prompts/<category>/<name>.md`
2. Fill in all required frontmatter fields
3. Write the prompt body with `{{variable}}` placeholders
4. Add at least one example with expected behavior
5. Test with target models and document in `example-runs/`
6. Validate: `tests/validate-prompt.sh prompts/<category>/<name>.md`
7. Update `prompts/INDEX.md`

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## Maintaining Prompts

### Version Updates

When updating a prompt:
1. Increment the version number following SemVer
2. Update the `updated` field
3. Add an entry to the `## Changelog` section at the bottom
4. Re-test with target models
5. Update `tested_with` status and dates

Example changelog:
```markdown
## Changelog
- 1.1.0 (2025-12-22): Added error handling section
- 1.0.1 (2025-12-15): Fixed typo in examples
- 1.0.0 (2024-12-01): Initial version
```

### Handling Model Drift

When models update and prompt behavior changes:
1. Test the prompt with the new model version
2. Document results in `tests/example-runs/`
3. Update `tested_with` field with new model version
4. If behavior degrades, update the prompt and increment version
5. Update [docs/MODEL_COMPATIBILITY.md](docs/MODEL_COMPATIBILITY.md)

## Categories and Tags

### Categories (Directories)
Use directories for broad grouping:
- `coding/` - Code generation, refactoring, debugging
- `writing/` - Content creation, editing, outlines
- `analysis/` - Data analysis, summarization, insights

Add new categories as needed. Keep names short, lowercase, and descriptive.

### Tags
Use tags for fine-grained search:
- **Workflow stage**: `planning`, `execution`, `review`
- **Style**: `concise`, `detailed`, `technical`
- **Domain**: `web`, `data`, `security`, `ml`
- **Quality**: `tested`, `experimental`, `deprecated`

## Validation

Validation uses the schema in `schema/prompt-schema.yaml` via the Ruby stdlib validator (`tests/validate-frontmatter.rb`); no extra gems required.

### Before Committing
```bash
# Validate a single prompt
tests/validate-prompt.sh prompts/coding/my-prompt.md

# Validate all prompts
tests/validate-all.sh
```

### CI Integration
Add to your `.github/workflows/validate.yml`:
```yaml
name: Validate Prompts
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate all prompts
        run: |
          chmod +x tests/validate-all.sh
          ./tests/validate-all.sh
```
