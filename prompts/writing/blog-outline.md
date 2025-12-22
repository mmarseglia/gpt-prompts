---
title: Concise Blog Outline
description: Produce a tight, engaging outline with hooks and CTA.
use_case: writing
models: [gpt-5.2, claude-opus-4-5]
tags: [outline, blog, structure]
version: 1.0.0
created: 2024-12-01
updated: 2025-12-22
author: repository-maintainer
model_versions: {}
tested_with:
  - model: gpt-5.2
    version: latest
    status: experimental
    last_tested: 2025-12-22
  - model: claude-opus-4-5
    version: latest
    status: experimental
    last_tested: 2025-12-22
compatibility_notes: "Works well across frontier models; claude-opus-4-5 may add extra nuance, gpt-5.2 tends to stay concise."
performance_notes: "Quick response time: 5-10s. Token usage: ~300-600 tokens."
quality_score: 9.0
related_prompts: []
variables:
  - name: topic
    required: true
    type: string
    default: ""
    validation: "Clear subject or headline idea"
    note: Core subject or headline idea
  - name: audience
    required: true
    type: string
    default: ""
    validation: "Specific audience description (e.g., 'first-time homeowners', 'B2B marketers')"
    note: Target reader profile
  - name: goal
    required: false
    type: string
    default: ""
    validation: "Specific desired outcome (e.g., 'newsletter signup', 'product demo request')"
    note: Desired outcome (e.g., newsletter signup)
examples:
  - input: "topic: Sustainable home energy\n audience: First-time homeowners\n goal: newsletter signup"
    expected_behavior: "Clear hook, 5–7 sections, key takeaways, CTA tuned to the goal."
    model_tested: "gpt-5.2"
    test_date: "2025-12-22"
    actual_output: ""
---

Create a blog post outline that is lean and compelling.

## Inputs
- Topic: {{topic}}
- Audience: {{audience}}
- Goal/CTA: {{goal}}

## Requirements
- Open with a sharp hook and value promise.
- 5–7 sections with working titles and 1–2 bullets each.
- Include key stats or examples to anchor credibility.
- Close with a CTA aligned to the goal.

## Output
- Title options (3).
- Outline sections with bullets.
- One-sentence CTA copy.

## Changelog
- 1.0.0 (2024-12-01): Initial version with hook-driven outline structure
