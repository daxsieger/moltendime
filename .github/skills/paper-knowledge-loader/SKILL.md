---
name: paper-knowledge-loader
description: 'Use for learning skills, memories, and technical documents from academic papers and university research outputs, then materializing a dedicated paper persona and local bundle.'
argument-hint: 'Provide the paper URL, title or identifier, and optionally the destination persona or paper bundle name.'
user-invocable: true
---

# Paper Knowledge Loader

Use this skill to ingest reusable AI knowledge from a research paper into the local `paper-skill-learner` persona and a dedicated paper-owned bundle.

## Inputs

- Paper URL, DOI, or arXiv identifier
- Optional destination paper slug
- Optional dedicated persona name

## What to Import First

- Abstract, introduction, methods, evaluation, ablations, and conclusion
- Appendix material that clarifies workflows, algorithms, or system constraints
- Linked code, benchmarks, datasets, or supplementary technical assets when relevant
- Explicit claims about speedups, quality, stability, memory use, or portability

## Extraction Rules

1. Create one dedicated persona for the paper or research line.
2. Turn method contributions into first-level skills owned by that persona.
3. Turn stable facts into memory notes.
4. Turn architecture, equations, pipeline structure, and evaluation takeaways into concise technical docs.
5. Mark inferred implementation guidance clearly when the paper implies it rather than stating it directly.

## Local Destination Layout

- Imported bundles: `.ai/paper-imports/<paper-slug>/`
- Persona metadata: `.ai/personalities/paper-skill-learner.md`
- Dedicated paper persona metadata: `.ai/personalities/<paper-persona>.md`
- Automation script: `scripts/import-paper-knowledge.ps1`

## Expected Bundle Contents

- `skills.md`: top-level paper skills and ownership summary
- `skills-index.md`: index of extracted skill packs
- `memories.md`: stable paper facts, claims, and constraints
- `technical-docs.md`: concise explanation of methods and evaluation
- `sources.md`: URLs, sections, figures, appendices, and linked artifacts used for extraction

## Ownership Model

- The dedicated paper persona is the runtime receptacle for paper-specific first-level skills.
- Archivist personas catalog the resulting personas, skills, and bundles for discovery and audit.
- Do not collapse paper-specific skills into the archivist persona itself.

## Output Format

- paper source
- dedicated persona
- extracted skill count
- local bundle path
- archivist catalog impact

## Automation

Use the shared automation script to scaffold a first-pass bundle from a paper URL:

```powershell
./scripts/import-paper-knowledge.ps1 -PaperUrl https://arxiv.org/abs/2512.08765
```
