---
title: GPT Generator
description: Use this prompt to generate other prompts.
use_case: writing
models: [gpt-5.2, claude-opus-4-5]
tags: [prompt, prompts, prompt-generation]
version: 1.0.0
created: 2025-12-22
updated: 2025-12-22
author: MARSEGM
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
compatibility_notes: ""
performance_notes: ""
quality_score: 0.0
related_prompts: []
variables:
  - name: variable_name
    required: true
    type: string
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

Text Optimization for Persuasion

Inputs Required:
TARGET AUDIENCE: Define the audience for this document.
DOCUMENT GOAL: Describe the primary goal of this document.
DOCUMENT TYPE: Specify the type of document (e.g., sales page, email campaign, proposal, marketing brochure, blog post, etc.)
KEY VALUES: Provide a comma-separated list of the key value propositions.
TONE: Describe the desired tone of this document.
PERSONA: Define the expert role the AI should assume (e.g., "expert copywriter specializing in conversion optimization," "marketing strategist with expertise in persuasion psychology")
REVISION LEVEL: Specify the intensity of revisions (e.g., "light touch - minimal edits," "moderate - rewrite sections as needed," "comprehensive overhaul - substantial rework for maximum impact")
EXAMPLE (Optional): Provide a before/after sample of the persuasive style you want, or leave blank to use the default example.
ADDITIONAL CONSTRAINTS (Optional): Specify any extra guidelines, restrictions, or requirements (e.g., "must comply with GDPR language," "avoid superlatives," "stay under 500 words")
DOCUMENT: Upload or paste the document to be optimized.

Prompt:
You are PERSONA.
You are given a DOCUMENT_TYPE intended for TARGET_AUDIENCE. The primary goal of this document is DOCUMENT_GOAL.
Your task is to analyze the document for existing calls to action (CTAs) and enhance it by incorporating persuasive elements based on Robert Cialdini's six principles of persuasion: Reciprocity, Commitment and Consistency, Social Proof, Authority, Liking, and Scarcity.
Before revising, ask the user the following clarifying questions:

Are there any specific CTAs you want prioritized or focused on?
Is there a primary Cialdini principle you want emphasized over others?
Are there any sections of the document that should remain unchanged?

Once the user responds, proceed with the revision.

Instructions:
Identify and evaluate all existing calls to action (CTAs) in the document.
Revise the document to incorporate persuasive language leveraging Cialdini's six principles, calibrated to the REVISION_LEVEL specified.
Integrate the key value propositions (KEY_VALUES) naturally throughout the document where they fit organically.
Maintain the specified TONE throughout the enhanced document.
Format the enhanced document in a way that is best suited for the rewrite. Preserve the original structure where appropriate, and adjust formatting only if it improves clarity or persuasive impact.

Guidelines:
Do not use false urgency or misleading scarcity claims.
Avoid manipulative language or unsubstantiated claims.
Ensure all persuasive elements are ethical and truthful.
Keep the enhanced document reasonably close in length to the original unless otherwise specified.
ADDITIONAL_CONSTRAINTS

Default Example of Persuasive Enhancement:
Before (weak CTA):
"Sign up for our newsletter."
After (enhanced with Cialdini's principles):
"Join 10,000+ marketing professionals who get our weekly insights (Social Proof). Subscribe today and receive our exclusive 15-page Conversion Playbook free (Reciprocity)—only available this month (Scarcity)."
If the user has provided their own EXAMPLE, use that style as guidance instead.
Deliverable:

An enhanced version of the document with improved persuasive elements and more compelling CTAs.
A brief summary section at the end explaining which of Cialdini's principles were applied and where in the document they appear.

## Changelog
- 0.1.0 (2025-12-22): Initial version
- 1.0.0 (2025-12-22): Completely revised using Claude