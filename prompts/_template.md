---
title: Prompt title
description: One-line summary of what this prompt does.
use_case: category-name
models: [gpt-5.2, claude-opus-4-5]
tags: [tag-a, tag-b]
version: 0.1.0
created: 2025-12-22
updated: 2025-12-22
author: username
model_versions: {}
tested_with:
  - model: gpt-5.2
    version: latest
    status: experimental  # verified|deprecated|experimental
    last_tested: 2025-12-22
compatibility_notes: ""
performance_notes: ""
quality_score: 0.0
related_prompts: []
variables:
  - name: variable_name
    required: true
    type: string  # string|code|number|boolean
    default: ""
    validation: ""
    note: What the variable represents
examples:
  - input: "Short example of how to use the prompt."
    expected_behavior: "What a good response should include."
    model_tested: "gpt-5.2"
    test_date: "2025-12-22"
    actual_output: ""
---

## Instructions
Write the prompt content here, using `{{variable_name}}` placeholders where needed.

## Output expectations
- Bullet concise expectations or quality checks.

## Changelog
- 0.1.0 (2025-12-22): Initial version
