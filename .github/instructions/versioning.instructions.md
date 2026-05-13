---
applyTo: "**"
description: "Commit repository changes after every prompt and implement AI customizations for Copilot, Claude Code, and Cursor."
---

# Versioning Policy

- This workspace must remain a git repository.
- After every prompt that changes the workspace, create a git commit.
- Prefer the shared script at `./scripts/commit-prompt-state.ps1`.
- Refresh `.ai/persona-knowledge/` before the commit so persona rule knowledge is versioned in a merge-friendly textual form.
- Refresh branch-aware DB state hashes from `.ai/db-definitions.json` so derived indexes can detect total knowledge changes across one or more branches.
- Every new AI customization must be implemented for Copilot, Claude Code, and Cursor and reflected in `SUPPORTED.md`.
- Use one branch per agent personality, with branch names under `persona/<slug>`.
- Keep `.ai/SHARED_LEARNINGS.md` present across personality branches to preserve cross-personality learning history.