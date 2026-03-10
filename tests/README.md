# Testing and Validation

This directory contains tools and test runs for validating prompts in the repository.

## Validation Scripts

### validate-prompt.sh

Validates a single prompt file via the schema-aware JavaScript validator:
- Checks YAML frontmatter structure
- Ensures required fields exist (title, description, use_case, models, tags, version, variables, examples)
- Validates SemVer, date formats, tag/model patterns, and variable/example structure
- Uses `tests/validate-frontmatter.js` (Node.js built-ins only; no external dependencies required)

**Usage:**
```bash
./tests/validate-prompt.sh prompts/coding/refactor-function.md
```

### validate-skill.sh

Validates a single `SKILL.md` file via the skill schema validator:
- Checks YAML frontmatter structure
- Ensures required fields exist (`name`, `description`)
- Validates name pattern (lowercase, hyphens) and directory-name match
- Uses `tests/validate-skill-frontmatter.js` (Node.js built-ins only; no external dependencies required)

**Usage:**
```bash
./tests/validate-skill.sh skills/updated-skills/prompt-generator/SKILL.md
```

### validate-all.sh

Validates all prompts and skills in the repository and provides a summary report.

**Usage:**
```bash
./tests/validate-all.sh
```

## Example Runs

The `example-runs/` directory stores actual test executions of prompts with real LLM outputs. This helps:

1. Verify prompts work as expected after model updates
2. Document actual behavior vs. expected behavior
3. Track quality over time
4. Provide examples for new contributors

### Directory Structure

```
example-runs/
├── refactor-function/
│   ├── 2025-12-22-gpt4o-success.md
│   └── 2024-11-15-claude-verified.md
├── blog-outline/
│   └── ...
└── data-summary/
    └── ...
```

### Naming Convention

Test run files follow this pattern:
```
YYYY-MM-DD-{model}-{status}.md
```

Examples:
- `2025-12-22-gpt4o-success.md`
- `2025-12-20-claude-sonnet-verified.md`
- `2025-12-15-gpt4-1-failed.md`

### Test Run Template

Each test run should include:

```markdown
# Test Run: {Prompt Name} ({Model})

**Date:** YYYY-MM-DD
**Model:** model-name (version)
**Status:** ✅ Success | ⚠️ Partial | ❌ Failed
**Tester:** username

## Input
{Actual input provided to the model}

## Expected Behavior
{What should happen}

## Actual Output
{What actually happened}

## Assessment
{Did it meet expectations? Any issues?}

## Notes
{Additional observations}
```

## Running Tests

### Before Committing

Always validate before committing:

```bash
# Validate a single prompt
./tests/validate-prompt.sh prompts/coding/your-new-prompt.md

# Validate a single skill
./tests/validate-skill.sh skills/updated-skills/your-new-skill/SKILL.md

# Validate all prompts and skills
./tests/validate-all.sh
```

### After Model Updates

When a new model version is released:

1. Pick representative prompts to test
2. Run them through the new model
3. Document the results in `example-runs/`
4. Update the `tested_with` field in the prompt frontmatter
5. Update `docs/MODEL_COMPATIBILITY.md`

## Continuous Integration

You can add these validation scripts to your CI pipeline:

```yaml
# Example GitHub Actions workflow
- name: Validate prompts
  run: |
    chmod +x tests/validate-all.sh
    ./tests/validate-all.sh
```

## Quality Metrics

Track these metrics for prompts:

- **Consistency**: Does the prompt produce consistent results across runs?
- **Accuracy**: Does the output match expected behavior?
- **Performance**: Response time and token usage
- **Compatibility**: Works across different models
- **Maintainability**: Easy to update and modify

Record these observations in test run files and update the `quality_score` field in prompt frontmatter.
