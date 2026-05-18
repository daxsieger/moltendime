# Paper Imports

This directory stores imported or synthesized knowledge bundles derived from academic papers, theses, and other university research outputs.

## Bundle Layout

Each paper gets its own folder:

- `.ai/paper-imports/<paper-slug>/skills.md`
- `.ai/paper-imports/<paper-slug>/skills-index.md`
- `.ai/paper-imports/<paper-slug>/memories.md`
- `.ai/paper-imports/<paper-slug>/technical-docs.md`
- `.ai/paper-imports/<paper-slug>/sources.md`

## Rules

- Prefer explicit paper content such as abstract, methods, evaluation, appendices, and linked implementation assets.
- Convert research contributions into transferable first-level skills owned by a dedicated paper persona.
- Keep archivist personas focused on cataloging and discovery rather than runtime ownership.
- Mark inferred implementation guidance clearly when it is not stated directly in the source material.

## Automation

- Use `./scripts/import-paper-knowledge.ps1 -PaperUrl <paper-url>` to generate a first-pass bundle scaffold before refining the paper-specific skill packs.
