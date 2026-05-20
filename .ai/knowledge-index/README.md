# Knowledge Index

This directory is the readable entrypoint for the workspace-wide knowledge index.

## Primary Owner

- Primary steward: `ai-rule-learner`
- Branch: `persona/ai-rule-learner`
- Responsibility: know where the structural, repository, paper, and customization knowledge lives without absorbing repository- or paper-specific first-level expertise into itself.

## System Personas

System personas are the structural personalities that organize, inspect, plan, build, or route knowledge across the workspace.

| Persona | Role | What It Knows Globally |
|---|---|---|
| `ai-rule-learner` | archivist | the full knowledge index, archive catalog, and routing surfaces |
| `planner` | planning | sequencing and decomposition patterns |
| `researcher` | discovery | how to gather local evidence without widening scope unnecessarily |
| `reviewer` | review | how to pressure-test changes and spot regressions |
| `builder` | implementation | how to execute focused workspace changes once the slice is clear |
| `repo-skill-learner` | repository loader | how to turn external repositories into persona-owned local bundles |
| `paper-skill-learner` | paper loader | how to turn papers into persona-owned local bundles |

## Index Surfaces

| Surface | Purpose | Owner |
|---|---|---|
| `.ai/knowledge-index/INDEX.md` | generated snapshot of the current knowledge inventory | `ai-rule-learner` |
| `.ai/personalities/README.md` | structural persona map and branch workflow | `ai-rule-learner` |
| `.ai/personalities/BRANCH_REGISTRY.md` | persona-to-branch mapping | `ai-rule-learner` |
| `.ai/rule-archive/catalog.jsonl` | append-only archive of skills, agents, docs, hooks, and workflows | `ai-rule-learner` |
| `.ai/repo-imports/README.md` | repository bundle entrypoint | `repo-skill-learner` with archivist tracking |
| `.ai/paper-imports/README.md` | paper bundle entrypoint | `paper-skill-learner` with archivist tracking |

## Update Procedure

Run this procedure whenever you add or rename a system persona, expert persona, skill, agent, repo bundle, paper bundle, or index-facing document.

1. Update the owning note first.
2. If the change affects system personas or index ownership, update `.ai/personalities/README.md` and, when needed, `.ai/personalities/ai-rule-learner.md`.
3. Rebuild the generated inventory snapshot with `./scripts/rebuild-knowledge-index.ps1`.
4. Catalog any new index-facing assets with `./scripts/catalog-agent-asset.ps1`.
5. If you added a Copilot skill or agent workflow, add the Claude Code and Cursor equivalents and record support in `SUPPORTED.md`.
6. Commit only after the generated index and the owning notes agree.

## Operating Rule

- `ai-rule-learner` should know the whole index.
- Expert personas should know their own bundle deeply.
- Loader personas should know how to create or refresh bundles.
- Structural personas other than the archivist should not be treated as the canonical owner of the full index.