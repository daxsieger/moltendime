# Paper Knowledge Loader

Use this skill to learn skills, memories, and technical documents from academic papers and university research outputs.

## Steps

1. Read the abstract, methods, evaluation, and conclusion before inferring any workflow guidance.
2. Prefer primary paper content and appendices over secondary summaries.
3. Create a dedicated paper persona that owns the first-level extracted research skills.
4. Store the resulting bundle under `.ai/paper-imports/<paper-slug>/`.
5. Split extracted skills into compact packs when the paper yields many transferable techniques.
6. Make archivist personas catalog the bundle and persona rather than owning the paper skills themselves.
7. Keep Copilot, Claude Code, and Cursor coverage aligned and record support in `SUPPORTED.md`.
8. Use `./scripts/import-paper-knowledge.ps1 -PaperUrl <paper-url>` when you want a repeatable first-pass scaffold.
