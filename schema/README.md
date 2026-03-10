# Schema Documentation

This directory contains JSON Schema definitions for validating prompt and skill frontmatter.

## Files

- `prompt-schema.yaml`: JSON Schema for prompt YAML frontmatter
- `skill-schema.yaml`: JSON Schema for skill YAML frontmatter
- `prompt-schema.json`: (Optional) JSON version of the prompt schema for tooling

## Using the Schema

### Manual Validation with yq/jq

If you have `yq` and `ajv-cli` installed:

```bash
# Extract frontmatter from a prompt
yq eval 'select(di == 0)' prompts/coding/refactor-function.md > temp-frontmatter.yaml

# Validate against schema (requires ajv-cli)
ajv validate -s schema/prompt-schema.yaml -d temp-frontmatter.yaml
```

### IDE Integration

Many IDEs can validate YAML frontmatter against JSON Schema:

**VS Code:**
1. Install the "YAML" extension by Red Hat
2. Add to `.vscode/settings.json`:
```json
{
  "yaml.schemas": {
    "./schema/prompt-schema.yaml": "prompts/**/*.md"
  }
}
```

**IntelliJ/PyCharm:**
1. Settings → Languages & Frameworks → Schemas and DTDs → JSON Schema Mappings
2. Add schema file and map to `prompts/**/*.md`

### Pre-commit Hook

Add schema validation to your pre-commit hooks:

```bash
#!/bin/bash
# .git/hooks/pre-commit

# Validate all staged prompt files
for file in $(git diff --cached --name-only | grep "^prompts/.*\.md$"); do
  if [ -f "$file" ]; then
    echo "Validating $file..."
    ./tests/validate-prompt.sh "$file" || exit 1
  fi
done

# Validate all staged skill files
for file in $(git diff --cached --name-only | grep "^skills/updated-skills/.*/SKILL\.md$"); do
  if [ -f "$file" ]; then
    echo "Validating $file..."
    ./tests/validate-skill.sh "$file" || exit 1
  fi
done
```

## Schema Fields Reference

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `title` | string | Short, descriptive name (5-100 chars) |
| `description` | string | One-line summary (10-200 chars) |
| `use_case` | string | Category name (2-50 chars) |
| `models` | array | List of target models |
| `tags` | array | Searchable tags (1-10 items) |
| `version` | string | SemVer version (e.g., "1.0.0") |
| `variables` | array | Variable definitions |
| `examples` | array | Test cases with expected behavior |

### Optional but Recommended

| Field | Type | Description |
|-------|------|-------------|
| `created` | date | Creation date (YYYY-MM-DD) |
| `updated` | date | Last update date (YYYY-MM-DD) |
| `author` | string | Author username |
| `tested_with` | array | Detailed testing info per model |
| `compatibility_notes` | string | Model-specific notes |
| `performance_notes` | string | Performance observations |
| `quality_score` | number | Quality rating (0-10) |
| `related_prompts` | array | Links to related prompts |

### Variable Object Schema

Each variable must have:
```yaml
- name: variable_name        # Required: lowercase, underscores only
  required: true|false       # Required: is this mandatory?
  type: string|code|number|boolean  # Optional: data type
  default: ""                # Optional: default value
  validation: ""             # Optional: validation rules
  note: "Description"        # Required: human explanation
```

### Example Object Schema

Each example must have:
```yaml
- input: "example input"                    # Required: test input
  expected_behavior: "what should happen"   # Required: expected result
  model_tested: "gpt-5.2"                    # Optional: which model
  test_date: "2025-12-22"                   # Optional: test date
  actual_output: ""                         # Optional: actual result
```

## Validation Rules

### Title
- Length: 5-100 characters
- Should be specific and descriptive
- Avoid generic names like "General Prompt"

### Description
- Length: 10-200 characters
- One clear sentence
- Should explain what the prompt does, not how

### Use Case
- Length: 2-50 characters
- Should match directory name in `prompts/`
- Lowercase, no spaces
- Examples: `coding`, `writing`, `analysis`

### Models
- At least one model required
- Lowercase with hyphens and dots: `gpt-5.2`, `claude-opus-4-5`
- Use official model names

### Tags
- 1-10 tags required
- Each tag: 2-30 characters
- Lowercase with hyphens: `step-by-step`, `refactor`
- No spaces or special characters

### Version
- Must follow SemVer: `MAJOR.MINOR.PATCH`
- Start new prompts at `0.1.0`
- Graduate to `1.0.0` after thorough testing
- Examples: `1.0.0`, `2.3.1`, `0.1.0`

### Variable Names
- Pattern: `^[a-z_][a-z0-9_]*$`
- Start with lowercase letter or underscore
- Only lowercase letters, numbers, and underscores
- Good: `language`, `code_snippet`, `error_message`
- Bad: `Language`, `code-snippet`, `1st_input`

### Tested With Status
Must be one of:
- `verified`: Tested and works as expected
- `experimental`: Works but needs more testing
- `deprecated`: No longer recommended

## Common Validation Errors

### Error: Missing Required Field
```
Error: Missing required field 'version'
```
**Solution:** Add the missing field to your frontmatter.

### Error: Invalid Version Format
```
Error: Invalid version '1.0' (expected SemVer: X.Y.Z)
```
**Solution:** Use three-part version: `1.0.0` instead of `1.0`

### Error: Invalid Variable Name
```
Error: Variable name 'Code-Snippet' doesn't match pattern
```
**Solution:** Use lowercase with underscores: `code_snippet`

### Error: No Examples
```
Error: examples array must have at least 1 item
```
**Solution:** Add at least one example with input and expected behavior.

## Updating the Schema

When updating the schema:

1. Edit `prompt-schema.yaml`
2. Update this README with new fields
3. Test with existing prompts: `tests/validate-all.sh`
4. Update `prompts/_template.md` to reflect changes
5. Document breaking changes in schema version
6. Update `CONTRIBUTING.md` if guidelines change

## Schema Versioning

The schema itself should be versioned if breaking changes occur:

- Add `version: "1.0.0"` to schema file
- Increment when validation rules change significantly
- Document changes in a CHANGELOG section

## Tools and Libraries

### Recommended Tools

**YAML Validation:**
- [yq](https://github.com/mikefarah/yq) - YAML processor
- [yamllint](https://yamllint.readthedocs.io/) - YAML linter

**JSON Schema Validation:**
- [ajv-cli](https://github.com/ajv-validator/ajv-cli) - JSON Schema validator
- [check-jsonschema](https://github.com/python-jsonschema/check-jsonschema) - Python-based validator

**IDE Extensions:**
- VS Code: "YAML" by Red Hat
- IntelliJ: Built-in JSON Schema support

## Skill Schema Fields Reference

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `name` | string | Skill identifier (2-50 chars, lowercase with hyphens) |
| `description` | string | Summary with trigger phrases (10-500 chars) |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `version` | string | SemVer version (e.g., "1.0.0") |

### Skill Validation Rules

#### Name
- Pattern: `^[a-z][a-z0-9-]*$`
- Must match the containing directory name under `skills/updated-skills/`
- Length: 2-50 characters
- Good: `prompt-generator`, `code-reviewer`
- Bad: `Prompt_Generator`, `my skill`

#### Description
- Length: 10-500 characters
- Should include trigger phrases so the skill is invoked correctly
- Example: "Generate prompts. Use when users ask to create, write, or develop a prompt."

### Validating a Skill

```bash
./tests/validate-skill.sh skills/updated-skills/my-skill/SKILL.md
```

## Future Enhancements

Potential schema improvements:
- Add pattern validation for common variable types
- Validate that all variables in examples are defined
- Check that {{variables}} in prompt body match frontmatter
- Automated schema version checking
- Custom validation rules for domain-specific fields

## Questions?

See [CONTRIBUTING.md](../CONTRIBUTING.md) for general guidelines or open an issue for schema-specific questions.
