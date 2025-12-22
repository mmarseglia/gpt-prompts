# AGENTS.md
Instructions for AI agents working in this repository.

## Scope and goals
- Maintain a library of high-quality generative AI prompts with rich metadata, validation, testing, and discoverability.
- Preserve structure: prompts live under `prompts/<category>/` with YAML frontmatter plus changelog sections.

## Key files
- Prompt template: `prompts/_template.md`
- Catalog: `prompts/INDEX.md` (regenerate via `scripts/generate-index.sh`)
- Schema: `schema/prompt-schema.yaml`
- Validator: `tests/validate-frontmatter.js` (Node.js built-ins only)
- Single-file validator wrapper: `tests/validate-prompt.sh` (Bash)
- Batch validator: `tests/validate-all.sh` (Bash)
- Compatibility matrix: `docs/MODEL_COMPATIBILITY.md`
- Contribution guide: `CONTRIBUTING.md`
- ChatGPT usage notes: `CHATGPT_INSTRUCTIONS.md`

## Editing prompts
- Copy `prompts/_template.md` into the correct category; ensure `use_case` matches the directory.
- Keep frontmatter complete: `title`, `description`, `use_case`, `models`, `tags`, `version`, `variables`, `examples`.
- Use `{{variable_name}}` placeholders consistent with `variables`.
- Update `version` (SemVer), `updated`, and add a `## Changelog` entry for meaningful changes.
- Add/refresh `tested_with` and example `actual_output` when testing.

## Validation and testing
- Validate a prompt: `tests/validate-prompt.sh prompts/<category>/<name>.md`
- Validate all prompts: `tests/validate-all.sh`
- Record real runs in `tests/example-runs/<prompt>/YYYY-MM-DD-<model>-<status>.md`
- Align `tested_with` and `docs/MODEL_COMPATIBILITY.md` with observed results.

## Catalog and discovery
- After adding or renaming prompts, regenerate catalog: `scripts/generate-index.sh`
- Keep tags meaningful; add related prompts when applicable.

## Safety and conventions
- Do not delete prompts; deprecate by marking `tested_with.status: deprecated` and adding a notice at top.
- Line endings are LF; scripts/docs are plain text (see `.gitattributes`).
- Avoid introducing dependencies; automation uses only Bash and JavaScript (Node.js built-ins).

## When unsure
- Consult `README.md` for workflow, `CONTRIBUTING.md` for standards, and `docs/MODEL_COMPATIBILITY.md` for model behavior.
