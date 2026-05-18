# Repo Knowledge Loader

Use this skill to learn skills, memories, and technical documents from a target GitHub repository.

## Steps

1. Inspect the target repository for explicit AI assets and technical documentation.
2. Prefer importing existing skills, instructions, prompts, rules, memories, and docs.
3. If assets are missing or incomplete, infer a minimum viable set of skills, memories, and technical docs from the codebase and scripts.
4. Store the resulting bundle under `.ai/repo-imports/<repo-slug>/`.
5. Refresh the external bridge template at `.github/skills/repo-knowledge-loader/templates/external-bridge-skill.md` when another repository must reference the bundle.
6. Keep Copilot, Claude Code, and Cursor coverage aligned and record support in `SUPPORTED.md`.
