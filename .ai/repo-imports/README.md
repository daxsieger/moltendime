# Repository Imports

This directory stores imported or inferred knowledge bundles produced by the `Repo Skill Learner` persona.

## Bundle Layout

Each source repository gets its own folder:

- `.ai/repo-imports/<repo-slug>/skills.md`
- `.ai/repo-imports/<repo-slug>/memories.md`
- `.ai/repo-imports/<repo-slug>/technical-docs.md`
- `.ai/repo-imports/<repo-slug>/sources.md`

## Rules

- Prefer explicit source material from the target repository.
- Mark inferred content clearly when the source repository lacks AI assets.
- Keep bundles concise enough to be reused by other personas and external bridge skills.
