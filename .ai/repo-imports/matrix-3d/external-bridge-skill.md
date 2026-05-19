---
name: matrix-3d-knowledge-bridge
description: 'Use when an external repository needs to load the matrix-3d knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# matrix-3d Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: matrix-3d
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open $hostRepoUrl.
2. Read .ai/repo-imports/matrix-3d/skills.md.
3. Read .ai/repo-imports/matrix-3d/memories.md.
4. Read .ai/repo-imports/matrix-3d/technical-docs.md.
5. Read .ai/repo-imports/matrix-3d/sources.md.
6. Delegate refresh work to `Repo Skill Learner` when the upstream repository changes materially.
