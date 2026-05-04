---
name: ai-rule-archive
description: 'Use for cataloging AI skills, hooks, instructions, custom agents, and workflow algorithms into a local archive without executing them. Supports populate, maintain, and query operations.'
argument-hint: 'Describe which AI customization files to catalog or what you want to query from the local archive.'
user-invocable: true
---

# AI Rule Archive

Use this skill to maintain a local archive of AI-agent customizations and reusable workflow knowledge.

## Scope

- Skills
- Hooks
- Instructions
- Custom agents
- Algorithmic workflow notes for agents

## Rules

- Read and catalog files without executing the archived automation.
- Store entries in `.ai/rule-archive/catalog.jsonl`.
- Keep compatibility notes for Copilot, Claude Code, and Cursor.
- Prefer concise summaries and stable file paths.

## Scripts

- Populate or update records: [catalog-agent-asset.ps1](../../../scripts/catalog-agent-asset.ps1)
- Query archive records: [query-agent-archive.ps1](../../../scripts/query-agent-archive.ps1)

## Example: Add an archive record

```powershell
./scripts/catalog-agent-asset.ps1 -Engine copilot -AssetType skill -Name git-versioning -Path .github/skills/git-versioning/SKILL.md -Summary "Prompt-based git versioning workflow"
```

## Example: Query the archive

```powershell
./scripts/query-agent-archive.ps1 -Query versioning
```