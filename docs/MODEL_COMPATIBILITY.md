# Model Compatibility Matrix

This document tracks which prompts work with which models, their verification status, and any known issues.

**Last Updated:** 2025-12-22

## Legend

- ✅ **Verified**: Tested and working as expected
- 🔄 **Testing**: Currently being tested
- ⚠️ **Needs Testing**: Not yet tested with this model
- ❌ **Known Issues**: Tested but has problems
- 🔶 **Experimental**: Works but needs more testing
- ⛔ **Deprecated**: No longer recommended for this model

## Compatibility Table

| Prompt | gpt-5.2 | claude-opus-4-5 | Gemini Pro | Status |
|--------|---------|-----------------|------------|--------|
| [refactor-function](../prompts/coding/refactor-function.md) | 🔶 latest | 🔶 latest | ⚠️ | Active |
| [blog-outline](../prompts/writing/blog-outline.md) | 🔶 latest | 🔶 latest | ⚠️ | Active |
| [data-summary](../prompts/analysis/data-summary.md) | 🔶 latest | 🔶 latest | ⚠️ | Active |

## Detailed Model Notes

### gpt-5.2 (OpenAI)

**Tested Version:** `latest` (experimental)

**Generally Works Well With:**
- Coding prompts (structured diffs and plans)
- Writing prompts (concise outlines)
- Analysis prompts (balanced brevity and clarity)

**Strengths:**
- Follows structured output formats
- Concise by default compared to earlier generations
- Strong reasoning on step-by-step tasks

**Weaknesses:**
- Early testing; watch for occasional over-trimming of detail
- Provide explicit format and length guidance to avoid drift

**Compatibility Notes by Prompt:**
- `refactor-function`: 🔶 Good diffs; ensure explicit diff format.
- `blog-outline`: 🔶 Concise outlines; add section count caps to avoid expansion.
- `data-summary`: 🔶 Clear summaries; add “call out deltas” when needed.

---

### claude-opus-4-5 (Anthropic)

**Tested Version:** `latest` (experimental)

**Generally Works Well With:**
- Writing prompts (nuanced tone and hooks)
- Analysis prompts (risk-oriented language)
- Coding prompts with explicit diff instructions

**Strengths:**
- Nuanced, context-aware writing
- Good at risk framing and caveats
- Handles longer context gracefully

**Weaknesses:**
- May add extra narrative unless constrained
- Diff formatting can vary; provide explicit unified diff examples

**Compatibility Notes by Prompt:**
- `refactor-function`: 🔶 Provide unified diff example to avoid alternative formats.
- `blog-outline`: 🔶 Strong hooks; occasionally verbose—set bullet limits.
- `data-summary`: 🔶 Good risk emphasis; remind to be concise.

---

### Gemini Pro (Google)

**Tested Version:** TBD

**Generally Works Well With:**
- TBD — needs testing across prompts

**Strengths:**
- TBD

**Weaknesses:**
- TBD

**Compatibility Notes by Prompt:**
- All prompts need testing

---

## Testing Schedule

### High Priority (Test Next)
1. Verify all prompts with claude-opus-4-5 using unified diff examples for coding.
2. Capture gpt-5.2 regression notes on longer inputs.
3. Run first-pass tests with Gemini Pro.

### Medium Priority
1. Create specialized coding prompts tuned for Claude diff formatting.
2. Document token usage patterns per model.
3. Add more few-shot examples for verbose models.

### Low Priority
1. Historical version compatibility
2. Edge case testing
3. Performance benchmarking

## Version Tracking

When a model updates:

1. **Test Representative Prompts**: Pick 2-3 prompts from different categories
2. **Document Changes**: Note any behavior differences
3. **Update This Matrix**: Mark new version and status
4. **Update Prompt Files**: Update `tested_with` fields
5. **Create Test Runs**: Document in `tests/example-runs/`

## Model-Specific Best Practices

### OpenAI (gpt-5.2)
- Use explicit output format specifications
- Include length constraints when brevity is important
- Provide examples of desired output structure

### Anthropic (claude-opus-4-5)
- Benefits from contextual reasoning and examples
- Provide explicit diff/output formatting
- Set bullet/length caps to limit verbosity

### Gemini (Google)
- Testing needed to establish best practices

## Known Issues

### Issue: Model Verbosity (All Prompts)
- **Status**: Minor
- **Workaround**: Add "Be concise" to prompts or specify word/bullet limits
- **Affected Prompts**: All
- **Tracking**: Will monitor in future versions

### Issue: Diff Format Compatibility (Claude)
- **Status**: Needs Testing
- **Description**: Claude may format code diffs differently than GPT models
- **Affected Prompts**: `refactor-function`, other coding prompts
- **Next Steps**: Test and document preferred format

## Contributing Compatibility Data

When testing prompts with models:

1. Use the test run template in `tests/README.md`
2. Save results to `tests/example-runs/<prompt-name>/YYYY-MM-DD-<model>-<status>.md`
3. Update this matrix with your findings
4. Update the prompt's `tested_with` field
5. Note any model-specific behaviors

## Model Version History

### GPT-4o
- `2024-08-06`: Primary testing version
- Future versions will be tracked here

### GPT-4.1
- `latest`: Current version
- Versioning information TBD

### Claude Sonnet 3.5
- Version tracking TBD

---

**Need help testing?** See [CONTRIBUTING.md](../CONTRIBUTING.md#testing-guidelines) for testing guidelines.
