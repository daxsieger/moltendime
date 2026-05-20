---
name: wan-2-2-knowledge-bridge
description: 'Use when an external repository needs to load the wan-2-2 knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# wan-2-2 Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: wan-2-2
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open $hostRepoUrl.
2. Read .ai/repo-imports/wan-2-2/skills.md.
3. Read .ai/repo-imports/wan-2-2/memories.md.
4. Read .ai/repo-imports/wan-2-2/technical-docs.md.
5. Read .ai/repo-imports/wan-2-2/sources.md.
6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.
