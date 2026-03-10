# AGENTS.md
Instructions for AI agents working in this repository.

## Scope and goals
- Maintain a library of high-quality generative AI prompts with rich metadata, validation, testing, and discoverability.
- Maintain Claude/Copilot skills that extend AI assistant capabilities.
- Preserve structure: prompts live under `prompts/<category>/` with YAML frontmatter plus changelog sections.
- Preserve structure: skills live under `skills/updated-skills/<name>/SKILL.md` with YAML frontmatter (`name`, `description`).

## Key files
- Prompt template: `prompts/_template.md`
- Skill template: `skills/_template/SKILL.md`
- Catalog: `prompts/INDEX.md` (regenerate via `scripts/generate-index.sh`)
- Prompt schema: `schema/prompt-schema.yaml`
- Skill schema: `schema/skill-schema.yaml`
- Prompt validator: `tests/validate-frontmatter.js` (Node.js built-ins only)
- Skill validator: `tests/validate-skill-frontmatter.js` (Node.js built-ins only)
- Single-file prompt validator wrapper: `tests/validate-prompt.sh` (Bash)
- Single-file skill validator wrapper: `tests/validate-skill.sh` (Bash)
- Batch validator (prompts + skills): `tests/validate-all.sh` (Bash)
- Compatibility matrix: `docs/MODEL_COMPATIBILITY.md`
- Contribution guide: `CONTRIBUTING.md`
- ChatGPT usage notes: `CHATGPT_INSTRUCTIONS.md`

## Editing prompts
- Copy `prompts/_template.md` into the correct category; ensure `use_case` matches the directory.
- Keep frontmatter complete: `title`, `description`, `use_case`, `models`, `tags`, `version`, `variables`, `examples`.
- Use `{{variable_name}}` placeholders consistent with `variables`.
- Update `version` (SemVer), `updated`, and add a `## Changelog` entry for meaningful changes.
- Add/refresh `tested_with` and example `actual_output` when testing.

## Editing skills
- Copy `skills/_template/SKILL.md` into a new directory under `skills/updated-skills/<name>/`.
- Keep frontmatter complete: `name` (must match directory name), `description` (include trigger phrases).
- Organize skill body with `## Process`, `## Output`, `## Standards` sections.
- Optionally add a `references/` subdirectory for supporting files.
- Add a `## Changelog` entry for meaningful changes.

## Validation and testing
- Validate a prompt: `tests/validate-prompt.sh prompts/<category>/<name>.md`
- Validate a skill: `tests/validate-skill.sh skills/updated-skills/<name>/SKILL.md`
- Validate all prompts and skills: `tests/validate-all.sh`
- Record real runs in `tests/example-runs/<prompt>/YYYY-MM-DD-<model>-<status>.md`
- Align `tested_with` and `docs/MODEL_COMPATIBILITY.md` with observed results.

## Catalog and discovery
- After adding or renaming prompts or skills, regenerate catalog: `scripts/generate-index.sh`
- Keep tags meaningful; add related prompts when applicable.
- Skills are also included in the generated catalog.

## Safety and conventions
- Do not delete prompts or skills; deprecate by marking `tested_with.status: deprecated` (prompts) or adding a notice at top.
- Line endings are LF; scripts/docs are plain text (see `.gitattributes`).
- Avoid introducing dependencies; automation uses only Bash and JavaScript (Node.js built-ins).

## When unsure
- Consult `README.md` for workflow, `CONTRIBUTING.md` for standards, and `docs/MODEL_COMPATIBILITY.md` for model behavior.
