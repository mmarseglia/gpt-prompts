# Prompt Judge Report

**Date:** 2026-03-18
**Evaluated by:** prompt-judge skill (automated scheduled task)
**Scope:** All prompt files in `prompts/` (excluding `_template.md` and `INDEX.md`)

---

## Summary

Six prompts were evaluated across five dimensions (Safety/Compliance, Technical Soundness, Best Practices, Practical Effectiveness, Domain Appropriateness) and rewritten for production readiness. Common improvements applied across all prompts:

- **Added XML-tagged sections** to provide clear structural boundaries for complex instructions, improving parsing reliability across models.
- **Separated concerns** (task definition, inputs, instructions, output format) into distinct sections rather than mixing them in prose.
- **Tightened output specifications** with explicit format requirements and constraints.
- **Added guardrails** for edge cases and ambiguous inputs.
- **Updated version numbers and changelog entries** to reflect the revision.

---

## Per-Prompt Changes

### 1. `writing/gpt-generator.md` (v2.0.0 → v2.1.0)

**Issues found:**
- *High Impact:* Overly verbose role description ("Expert Prompt Engineering Consultant specializing in systematic prompt development through structured discovery") added tokens without improving performance.
- *High Impact:* 17 questions presented with lengthy explanatory preambles that the model doesn't need — the question itself suffices.
- *Enhancement:* No XML structure to delineate the discovery framework from the synthesis protocol.
- *Enhancement:* Quality criteria were implicit rather than explicit.

**Changes made:**
- Condensed the system role to one clear sentence.
- Streamlined all 17 questions to their essential ask, removing redundant elaboration.
- Wrapped the discovery framework, synthesis protocol, and quality criteria in `<discovery_framework>`, `<synthesis>`, and `<quality_criteria>` XML tags.
- Added explicit quality criteria section listing what every generated prompt must include.

---

### 2. `writing/project-management-mentor-event-planning.md` (v1.0.0 → v1.1.0)

**Issues found:**
- *Critical:* The entire file (frontmatter + prompt body) was duplicated — the content appeared twice, which would confuse any system processing the file.
- *High Impact:* Output expectations section at the end ("5-8 tailored questions and 2-3 next actions") conflicted with the response format section ("avoid overwhelming your mentee with too many questions"), creating ambiguity about how many questions to ask.
- *Enhancement:* Persuasion principles and mentoring modes were described in long prose paragraphs that could be more scannable.

**Changes made:**
- Removed the complete duplicate of frontmatter and prompt body.
- Resolved the question-count conflict by specifying "3–5 questions per response" in the response format section and removing the rigid "5-8 questions" expectation.
- Restructured into XML-tagged sections: `<project_details>`, `<project_context>`, `<mentoring_approach>`, `<persuasion_principles>`, `<session_framework>`, `<pm_guidance>`, `<communication_drafting>`, `<response_format>`.
- Condensed the three mentoring modes into a tighter format with clear primary/secondary/ongoing labels.

---

### 3. `writing/facebook-marketplace-listing.md` (v0.1.0 → v0.2.0)

**Issues found:**
- *High Impact:* Instructions and output format were interleaved, making it hard to distinguish rules from structure.
- *Enhancement:* The "Ask the above clearly before writing" instruction was buried mid-prompt rather than being a clear conditional gate.
- *Enhancement:* Web search instruction ("use web search to research similar listings") lacked specificity about what to do if search is unavailable.

**Changes made:**
- Separated `<instructions>` (rules and constraints) from `<output_format>` (structure of the listing) into distinct XML sections.
- Moved the "ask before writing" gate into the instructions section with clearer conditional language.
- Strengthened honesty guardrails with a dedicated opening rule: "Never fabricate urgency, social proof, or authority claims."
- Added `<task>` section for a one-sentence goal statement.

---

### 4. `writing/blog-outline.md` (v1.0.0 → v1.1.0)

**Issues found:**
- *High Impact:* No role definition — the prompt jumped straight into "Create a blog post outline" with no persona or expertise framing.
- *High Impact:* "Include key stats or examples to anchor credibility" gave no guidance on what to do when stats can't be verified, risking hallucinated data.
- *Enhancement:* Output format listed items but didn't specify constraints (e.g., title length, CTA length).

**Changes made:**
- Added a content strategist role definition.
- Wrapped the prompt in `<task>`, `<inputs>`, `<requirements>`, and `<output_format>` XML sections.
- Added explicit instruction to mark unverifiable stats with `[STAT]` or `[EXAMPLE]` placeholders rather than fabricating them.
- Added constraints: titles under 70 characters, section descriptions limited to two sentences, default CTA behavior when no goal is provided.

---

### 5. `coding/refactor-function.md` (v1.0.0 → v1.1.0)

**Issues found:**
- *High Impact:* "You are a careful software engineer" is too vague — doesn't specify seniority, focus area, or what "careful" means in practice.
- *High Impact:* No constraint preventing the model from renaming functions or changing public signatures, which could break calling code.
- *Enhancement:* Code block in the input section wasn't language-tagged, reducing syntax highlighting utility.
- *Enhancement:* "Suggest tests" was underspecified — no minimum count, no edge case requirement.

**Changes made:**
- Upgraded role to "senior software engineer performing a careful code refactor" with explicit behavior-preservation mandate.
- Added `<constraints>` section: no signature changes unless flagged, prefer idiomatic patterns, acknowledge when code is already clean.
- Language-tagged the input code block with `{{language}}`.
- Specified 3–5 test cases with at least one edge case required.
- Wrapped the process in `<process>` XML tags and added an `<output_format>` section with labeled sections.

---

### 6. `analysis/data-summary.md` (v1.0.0 → v1.1.0)

**Issues found:**
- *High Impact:* "Summarize the following dataset for {{audience}}" provided no guidance on how to adapt for different audiences (executives vs. engineers get very different summaries).
- *High Impact:* No guardrails against speculating beyond the data or fabricating deltas when none are provided.
- *Enhancement:* The `audience` variable had no default value, meaning the prompt would break if the user omitted it.

**Changes made:**
- Added explicit audience-adaptation instruction: "use plain language for non-technical audiences, precise terminology for technical ones."
- Added data integrity rules: "State findings factually," "say 'delta unknown' rather than guessing."
- Set default audience to "general stakeholders" in the frontmatter.
- Restructured into `<data>`, `<instructions>`, and `<output_format>` XML sections.
- Moved the role definition into a proper system-style sentence with audience awareness built in.
