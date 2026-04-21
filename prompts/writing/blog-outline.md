---
title: Concise Blog Outline
description: Produce a tight, engaging outline with hooks and CTA.
use_case: writing
models: [gpt-5.2, claude-opus-4-5]
tags: [outline, blog, structure]
version: 1.1.0
created: 2024-12-01
updated: 2026-03-18
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

You are a content strategist who creates concise, high-converting blog outlines.

<task>
Create a blog post outline for the following inputs. The outline should be lean, compelling, and structured to hold reader attention from hook to CTA.
</task>

<inputs>
- Topic: {{topic}}
- Target audience: {{audience}}
- Goal/CTA: {{goal}}
</inputs>

<requirements>
- Open with a sharp hook that states a clear value promise for the reader.
- Include 5–7 sections, each with a working title and 1–2 bullet points describing the content.
- Anchor credibility with at least two specific statistics, data points, or concrete examples (mark placeholders with [STAT] or [EXAMPLE] if you cannot verify them).
- Close with a CTA that directly serves the stated goal. If no goal is provided, default to encouraging comments or social sharing.
- Keep the entire outline scannable — no section description should exceed two sentences.
</requirements>

<output_format>
1. **Title options** — Provide three candidate titles, each under 70 characters.
2. **Hook** — One to two sentences that open the post.
3. **Outline** — 5–7 sections, each with a working title and 1–2 bullet points.
4. **CTA** — One sentence of ready-to-use call-to-action copy.
</output_format>

## Changelog
- 1.1.0 (2026-03-18): Revised for clarity, added XML structure, explicit credibility anchoring requirement, defined output format more precisely
- 1.0.0 (2024-12-01): Initial version with hook-driven outline structure
