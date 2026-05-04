---
applyTo: "**"
description: "Commit repository changes after every prompt and implement AI customizations for Copilot, Claude Code, and Cursor."
---

# Versioning Policy

- This workspace must remain a git repository.
- After every prompt that changes the workspace, create a git commit.
- Prefer the shared script at `./scripts/commit-prompt-state.ps1`.
- Every new AI customization must be implemented for Copilot, Claude Code, and Cursor and reflected in `SUPPORTED.md`.