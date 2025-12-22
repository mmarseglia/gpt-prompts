# Prompt Catalog

Quick reference for finding and discovering prompts in this repository.

## By Category

### Analysis
- **[Data Snapshot Summary](analysis/data-summary.md)**
  - Description: Summarize a dataset or analysis snippet with risks and next steps.
  - Tags: [analysis, summary, risks]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: context,metrics,audience,

### Coding
- **[Refactor a Function Safely](coding/refactor-function.md)**
  - Description: Stepwise refactor with reasoning, diff, and tests.
  - Tags: [refactor, testing, step-by-step]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: language,code,

### Writing
- **[Concise Blog Outline](writing/blog-outline.md)**
  - Description: Produce a tight, engaging outline with hooks and CTA.
  - Tags: [outline, blog, structure]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: topic,audience,goal,

- **[GPT Generator](writing/gpt-generator.md)**
  - Description: Use this prompt to generate other prompts.
  - Tags: [prompt, prompts, prompt generation]
  - Models: [gpt-5.2, claude-opus-4-5]
  - Variables: variable_name,


## By Tag

- **analysis**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **blog**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **generation**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **outline**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **prompt**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **prompts**:
  - [writing/gpt-generator.md](writing/gpt-generator.md)
- **refactor**:
  - [coding/refactor-function.md](coding/refactor-function.md)
- **risks**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **step-by-step**:
  - [coding/refactor-function.md](coding/refactor-function.md)
- **structure**:
  - [writing/blog-outline.md](writing/blog-outline.md)
- **summary**:
  - [analysis/data-summary.md](analysis/data-summary.md)
- **testing**:
  - [coding/refactor-function.md](coding/refactor-function.md)

## By Model

### claude-opus-4-5
- [analysis/data-summary.md](analysis/data-summary.md)
- [coding/refactor-function.md](coding/refactor-function.md)
- [writing/gpt-generator.md](writing/gpt-generator.md)
- [writing/blog-outline.md](writing/blog-outline.md)
### gpt-5.2
- [analysis/data-summary.md](analysis/data-summary.md)
- [coding/refactor-function.md](coding/refactor-function.md)
- [writing/gpt-generator.md](writing/gpt-generator.md)
- [writing/blog-outline.md](writing/blog-outline.md)

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
*Last updated: 2025-12-22*
*To regenerate: `scripts/generate-index.sh`*
