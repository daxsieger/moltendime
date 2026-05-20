---
name: gamefactory-knowledge-bridge
description: 'Use when an external repository needs to load the gamefactory knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# gamefactory Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: gamefactory
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open $hostRepoUrl.
2. Read .ai/repo-imports/gamefactory/skills.md.
3. Read .ai/repo-imports/gamefactory/memories.md.
4. Read .ai/repo-imports/gamefactory/technical-docs.md.
5. Read .ai/repo-imports/gamefactory/sources.md.
6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.
