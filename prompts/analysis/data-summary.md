---
title: Data Snapshot Summary
description: Summarize a dataset or analysis snippet with risks and next steps.
use_case: analysis
models: [gpt-5.2, claude-opus-4-5]
tags: [analysis, summary, risks]
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
compatibility_notes: "Works well with frontier models; claude-opus-4-5 offers nuanced risk language, gpt-5.2 keeps concise summaries."
performance_notes: "Response time: 8-12s. Token usage: ~400-700 tokens depending on data complexity."
quality_score: 8.0
related_prompts: []
variables:
  - name: context
    required: true
    type: string
    default: ""
    validation: "Clear description of data source and timeframe"
    note: What the data represents (source, timeframe)
  - name: metrics
    required: true
    type: string
    default: ""
    validation: "Key-value pairs or structured metric data"
    note: Key metrics and values to summarize
  - name: audience
    required: false
    type: string
    default: ""
    validation: "Audience role or group (e.g., 'executives', 'engineering team')"
    note: Who will read the summary (e.g., execs, engineers)
examples:
  - input: "context: Web traffic past 7 days\nmetrics: visits=12k, conv rate=3.2%, bounce=41%\naudience: product leadership"
    expected_behavior: "Clear headline, notable changes, risks, and 2–3 next steps."
    model_tested: "gpt-5.2"
    test_date: "2025-12-22"
    actual_output: ""
---

Summarize the following dataset for {{audience}}.

## Context
- {{context}}
- Metrics: {{metrics}}

## Output format
1) Headline finding (1 sentence).
2) Highlights (3–5 bullets, note deltas if known).
3) Risks/limitations (2–3 bullets).
4) Next steps (2–3 bullets).

## Changelog
- 1.0.0 (2024-12-01): Initial version with risk-aware data summarization
