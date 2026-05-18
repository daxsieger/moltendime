---
name: visionary-knowledge-bridge
description: 'Use when an external repository needs to load the Visionary skill bundle, memory notes, and technical documents from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository.'
user-invocable: true
---

# Visionary Knowledge Bridge

Use this skill from an external project when you want to load the curated Visionary knowledge bundle maintained by `Repo Skill Learner`.

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: visionary
- maintained_by_agent: Repo Skill Learner

## Load Sequence

1. Open `https://github.com/daxsieger/moltendime`.
2. Read `.ai/repo-imports/visionary/skills.md`.
3. Read `.ai/repo-imports/visionary/memories.md`.
4. Read `.ai/repo-imports/visionary/technical-docs.md`.
5. Read `.ai/repo-imports/visionary/sources.md` for provenance and inference boundaries.
6. If the upstream Visionary repository changed materially, delegate refresh work to `Repo Skill Learner` in the knowledge host repository.

## Rules

- Prefer these bundle files over ad-hoc reinterpretation of the upstream repository when you need a concise operational summary.
- Treat the bundle as derived knowledge, not as a replacement for source code.
- When implementing changes against Visionary itself, go back to the upstream repository and validate against current code.
