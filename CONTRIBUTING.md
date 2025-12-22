# Contributing Guidelines

Thank you for contributing to this prompt repository! This guide will help you add high-quality prompts that are well-documented, tested, and easy to maintain.

## Quick Start

```bash
# Create a new prompt
scripts/new-prompt.sh <category> <name>

# Edit the generated file
# Fill in metadata and write prompt content

# Validate before committing
tests/validate-prompt.sh prompts/<category>/<name>.md

# Update the index
scripts/generate-index.sh
```

## Adding a New Prompt

### 1. Create the Prompt File

**Option A: Use the helper script (recommended)**
```bash
scripts/new-prompt.sh coding debug-error
```

**Option B: Manual creation**
```bash
cp prompts/_template.md prompts/coding/debug-error.md
```

### 2. Fill in the Frontmatter

Complete all required fields in the YAML frontmatter:

```yaml
---
title: Short, Descriptive Name
description: One-line summary of what this prompt does
use_case: coding  # Category name
models: [gpt-5.2, claude-opus-4-5]  # Models tested with
tags: [debugging, error-handling, step-by-step]  # Searchable tags
version: 0.1.0  # Start with 0.1.0 for new prompts
created: 2025-12-22  # Today's date
updated: 2025-12-22  # Same as created initially
author: your-username
tested_with:
  - model: gpt-5.2
    version: latest
    status: experimental  # Start with experimental
    last_tested: 2025-12-22
compatibility_notes: ""  # Add after testing
performance_notes: ""  # Add after testing
quality_score: 0.0  # Update after testing (0-10)
related_prompts: []  # Link to similar prompts
variables:
  - name: error_message
    required: true
    type: string
    default: ""
    validation: "Stack trace or error output"
    note: The error message to debug
examples:
  - input: "error_message: TypeError: Cannot read property 'x' of undefined"
    expected_behavior: "Identifies the issue, explains the cause, suggests fixes"
    model_tested: "gpt-5.2"
    test_date: "2025-12-22"
    actual_output: ""  # Fill in after testing
---
```

### 3. Write the Prompt Content

Use clear sections and `{{variable}}` placeholders:

```markdown
## Instructions
You are a helpful debugging assistant.

Given the following error message, help identify the root cause and suggest fixes.

## Error
{{error_message}}

## Output Format
1. Summary of the error
2. Likely root causes (2-3 bullets)
3. Suggested fixes (step-by-step)
4. Prevention tips

## Changelog
- 0.1.0 (2025-12-22): Initial version
```

### 4. Test with Target Models

Test your prompt with the models listed in the frontmatter:

1. Replace variables with realistic test data
2. Run through each target model
3. Document results in `tests/example-runs/<prompt-name>/`
4. Update `actual_output` in examples
5. Update `tested_with` status to `verified` if successful
6. Add notes about model-specific behaviors

### 5. Validate the Prompt

Run validation before committing:

```bash
# Validate your prompt
tests/validate-prompt.sh prompts/coding/debug-error.md

# Validate all prompts
tests/validate-all.sh
```

### 6. Update the Index

Regenerate the index to include your new prompt:

```bash
scripts/generate-index.sh
```

Or manually add it to `prompts/INDEX.md`.

### 7. Submit Your Changes

If this is a collaborative repository:

1. Create a new branch: `git checkout -b add-debug-error-prompt`
2. Commit your changes: `git commit -m "Add debug-error prompt for coding"`
3. Push and create a pull request
4. Wait for review and address feedback

## Prompt Quality Checklist

Before submitting, ensure your prompt meets these quality standards:

### Metadata
- [ ] Clear, specific title (not too generic)
- [ ] Concise description (one line)
- [ ] Appropriate use_case/category
- [ ] All variables documented with types and validation
- [ ] At least one complete example
- [ ] Version number follows SemVer (0.1.0 for new)
- [ ] Author field filled in
- [ ] Tags are descriptive and reusable

### Content
- [ ] Clear instructions for the model
- [ ] All variables used in the prompt are defined in frontmatter
- [ ] Output format is specified
- [ ] Prompt is concise (avoid unnecessary verbosity)
- [ ] Language is clear and unambiguous
- [ ] Examples demonstrate realistic use cases

### Testing
- [ ] Tested with at least one target model
- [ ] Results documented in `tests/example-runs/`
- [ ] `tested_with` field updated with actual results
- [ ] `actual_output` in examples filled in
- [ ] Quality score assigned (1-10)
- [ ] Performance notes added (response time, token usage)

### Documentation
- [ ] Compatibility notes mention model-specific behaviors
- [ ] Related prompts linked (if applicable)
- [ ] Changelog started with initial version
- [ ] INDEX.md updated

## Versioning Strategy

Follow [SemVer](https://semver.org/) for version numbers:

### Major Version (X.0.0)
Increment when:
- Breaking changes to required variables
- Complete rewrite of prompt logic
- Fundamentally different behavior

Example: `1.0.0 → 2.0.0`

### Minor Version (0.X.0)
Increment when:
- Adding new optional variables
- Improving guidance or instructions
- Enhancing output format
- Adding new examples

Example: `1.2.0 → 1.3.0`

### Patch Version (0.0.X)
Increment when:
- Fixing typos
- Clarifying existing text
- Updating metadata only
- Adding compatibility notes

Example: `1.2.3 → 1.2.4`

### Pre-release Versions
Start new prompts at `0.1.0` and increment to `1.0.0` once:
- Tested with all target models
- Quality score >= 7.0
- At least one documented test run
- Positive user feedback (if applicable)

## Best Practices

### Writing Effective Prompts

1. **Be Specific**: Clear instructions produce better results
   - Bad: "Analyze this"
   - Good: "Analyze this code for security vulnerabilities, focusing on SQL injection and XSS"

2. **Use Examples**: Show the model what good output looks like
   ```markdown
   Example output:
   1. Vulnerability: SQL Injection
      Location: Line 45
      Severity: High
      Fix: Use parameterized queries
   ```

3. **Structure Output**: Define the expected format
   - Use numbered lists for sequences
   - Use bullet points for collections
   - Use sections for complex outputs

4. **Set Constraints**: Be explicit about limitations
   - "Respond in 3-5 bullet points"
   - "Keep explanations under 100 words"
   - "Focus only on Python solutions"

### Variable Design

1. **Clear Names**: Use descriptive variable names
   - Bad: `{{input}}`, `{{data}}`
   - Good: `{{code_snippet}}`, `{{error_message}}`

2. **Type Hints**: Always specify the variable type
   - `string`, `code`, `number`, `boolean`

3. **Validation**: Describe what valid input looks like
   - "Valid JSON object"
   - "Python code snippet (10-100 lines)"
   - "URL starting with https://"

4. **Defaults**: Provide defaults for optional variables when sensible

### Tag Strategy

Choose tags that help users find prompts:

**Good tags:**
- Workflow: `planning`, `execution`, `review`, `debugging`
- Domain: `web`, `api`, `database`, `ml`, `security`
- Style: `concise`, `detailed`, `step-by-step`, `creative`
- Format: `code`, `prose`, `list`, `table`

**Avoid:**
- Redundant tags already in the category
- Too generic tags like `general`, `misc`, `other`
- Single-use tags that won't help search

### Testing Guidelines

Document test runs in `tests/example-runs/<prompt-name>/`:

```markdown
# Test Run: Debug Error (GPT-4o)

**Date:** 2025-12-22
**Model:** gpt-5.2 (latest)
**Status:** ✅ Success
**Tester:** username

## Input
[actual input provided]

## Expected Behavior
[what should happen]

## Actual Output
[what actually happened]

## Assessment
✅ Met expectations
- Clear identification of issue
- Good explanation
- Actionable fixes

⚠ Partial issues
- Response was verbose

## Notes
Response time: ~8 seconds
Token usage: ~450 tokens
```

## Maintaining Existing Prompts

### Updating Prompts

When updating an existing prompt:

1. **Increment version** following SemVer
2. **Update `updated` field** with today's date
3. **Add changelog entry** at the bottom
4. **Re-test** with target models
5. **Update `tested_with`** with new test dates
6. **Validate** before committing

Example changelog:
```markdown
## Changelog
- 1.2.0 (2025-12-22): Added error prevention section
- 1.1.1 (2025-12-15): Fixed typo in example
- 1.1.0 (2025-12-10): Added support for async errors
- 1.0.0 (2024-12-01): Initial stable release
- 0.1.0 (2024-11-15): Initial version
```

### Handling Model Drift

When models update and behavior changes:

1. **Test** with the new model version
2. **Document** results in a new test run file
3. **Update** `tested_with` with new version info
4. **Decide** on action:
   - If still works well: Update `last_tested` date
   - If degraded: Update prompt and increment version
   - If broken: Mark status as `deprecated` and create new version
5. **Update** `docs/MODEL_COMPATIBILITY.md`

### Deprecating Prompts

When a prompt no longer works well:

1. Set `tested_with.status` to `deprecated`
2. Add deprecation notice at the top of the prompt
3. Link to replacement prompt if available
4. Keep the file for historical reference

Example deprecation notice:
```markdown
> **⚠ DEPRECATED**: This prompt no longer works reliably with GPT-4o 2024-11-20 and later.
> Please use [improved-debug-error](./improved-debug-error.md) instead.
```

## Code of Conduct

- Be respectful and constructive in reviews
- Focus on improving prompt quality, not criticism
- Share knowledge and help newcomers
- Test thoroughly before submitting
- Document your changes clearly
- Credit others' work when building on it

## Getting Help

- Check the [README.md](README.md) for usage guidelines
- Review existing prompts for examples
- Read [tests/README.md](tests/README.md) for testing guidance
- Look at [docs/MODEL_COMPATIBILITY.md](docs/MODEL_COMPATIBILITY.md) for model info

## Questions?

If you have questions or need clarification:
- Open an issue for discussion
- Review existing prompts for patterns
- Ask for feedback early and often

Thank you for contributing!
