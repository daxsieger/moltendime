---
name: mineworld-knowledge-bridge
description: 'Use when an external repository needs to load the mineworld knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# mineworld Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: mineworld
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open $hostRepoUrl.
2. Read .ai/repo-imports/mineworld/skills.md.
3. Read .ai/repo-imports/mineworld/memories.md.
4. Read .ai/repo-imports/mineworld/technical-docs.md.
5. Read .ai/repo-imports/mineworld/sources.md.
6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.
