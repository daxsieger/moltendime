---
name: external-repo-knowledge-bridge
description: 'Use when this repository needs to load skills, memories, and technical documents from the canonical knowledge host repository managed by Repo Skill Learner.'
argument-hint: 'Provide the canonical knowledge host repository URL and the bundle name to load.'
user-invocable: true
---

# External Repo Knowledge Bridge

Use this skill from an external project when the canonical AI knowledge bundle is hosted in another repository.

## Required Inputs

- Canonical knowledge host repository URL
- Bundle name or source repository slug
- Optional branch, tag, or commit

## Workflow

1. Open the canonical knowledge host repository.
2. Read `.ai/repo-imports/<bundle-name>/skills.md`.
3. Read `.ai/repo-imports/<bundle-name>/memories.md`.
4. Read `.ai/repo-imports/<bundle-name>/technical-docs.md`.
5. Read `.ai/repo-imports/<bundle-name>/sources.md` for provenance and inferred gaps.
6. Delegate any refresh or regeneration work to `Repo Skill Learner` in the canonical host repository.

## Rules

- Prefer imported explicit assets over inferred ones.
- Treat files marked as inferred as editable summaries, not source-of-truth code.
- Keep the bridge thin; do not duplicate the full bundle unless the external repository needs a snapshot.

## Reference Placeholder

- knowledge_host_repo: <https://github.com/OWNER/KNOWLEDGE-HOST-REPO>
- bundle_name: <target-repo-slug>
- maintained_by_agent: Repo Skill Learner
