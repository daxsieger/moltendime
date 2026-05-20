---
name: knowledge-index-maintenance
description: 'Use for organizing, rebuilding, and updating the workspace-wide knowledge index so the system personas, bundles, skills, and agents stay discoverable.'
argument-hint: 'Describe what changed in the knowledge surfaces and whether you need to rebuild the index, update the owner docs, or catalog new assets.'
user-invocable: true
---

# Knowledge Index Maintenance

Use this skill when the workspace knowledge inventory needs to stay ordered, explicit, and queryable.

## Primary Owner

- Global index steward: `ai-rule-learner`
- Structural persona map: `.ai/personalities/README.md`
- Knowledge index entrypoint: `.ai/knowledge-index/README.md`
- Generated inventory snapshot: `.ai/knowledge-index/INDEX.md`

## When to Use

- A new structural persona is added or renamed.
- A new repo bundle or paper bundle is imported.
- A new Copilot skill, agent, rule, or workflow surface is added.
- The archive catalog exists, but the human-readable index is stale.
- You need to make it obvious which persona knows the whole index and how to refresh it.

## Scripts

- Rebuild the generated knowledge inventory: `./scripts/rebuild-knowledge-index.ps1`
- Append archive records: `./scripts/catalog-agent-asset.ps1`
- Query the archive: `./scripts/query-agent-archive.ps1`

## Procedure

1. Update the owning note first.
2. If the change is structural, update `.ai/personalities/README.md` and, if needed, `.ai/personalities/ai-rule-learner.md`.
3. Rebuild `.ai/knowledge-index/INDEX.md` with `./scripts/rebuild-knowledge-index.ps1`.
4. Catalog new index-facing assets in `.ai/rule-archive/catalog.jsonl`.
5. Keep Copilot, Claude Code, and Cursor equivalents aligned and update `SUPPORTED.md`.

## Example

```powershell
./scripts/rebuild-knowledge-index.ps1
./scripts/catalog-agent-asset.ps1 -Engine multi -AssetType skill -Name knowledge-index-maintenance -Path .github/skills/knowledge-index-maintenance/SKILL.md -Summary "Workflow for rebuilding and maintaining the workspace knowledge index"
```

## Rule

- The archivist owns the index.
- Expert personas own first-level expertise.
- Structural personas other than the archivist should not become the canonical source of the full index.