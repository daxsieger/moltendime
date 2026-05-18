---
name: visionary-knowledge-bridge
description: 'Use when an external repository needs to load the visionary knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# visionary Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: visionary
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open $hostRepoUrl.
2. Read .ai/repo-imports/visionary/skills.md.
3. Read .ai/repo-imports/visionary/memories.md.
4. Read .ai/repo-imports/visionary/technical-docs.md.
5. Read .ai/repo-imports/visionary/sources.md.
6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.
