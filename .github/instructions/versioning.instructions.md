---
applyTo: "**"
description: "Commit repository changes after every prompt and implement AI customizations for Copilot, Claude Code, and Cursor."
---

# Versioning Policy

- This workspace must remain a git repository.
- After every prompt that changes the workspace, create a git commit.
- Prefer the shared script at `./scripts/commit-prompt-state.ps1`.
- Every new AI customization must be implemented for Copilot, Claude Code, and Cursor and reflected in `SUPPORTED.md`.
- Use one branch per agent personality, with branch names under `persona/<slug>`.
- Keep `.ai/SHARED_LEARNINGS.md` present across personality branches to preserve cross-personality learning history.