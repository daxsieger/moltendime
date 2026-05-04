# Git Versioning

Use this skill for repository initialization, prompt-based commits, and cross-engine AI customization versioning.

## Steps

1. Keep the workspace under git.
2. After a prompt changes the workspace, run `./scripts/commit-prompt-state.ps1`.
3. Give each personality its own `persona/<slug>` branch.
4. Keep `.ai/SHARED_LEARNINGS.md` updated and present across personality branches.
5. Keep Copilot, Claude Code, and Cursor customizations aligned.
6. Update `SUPPORTED.md` when support coverage changes.
7. Use `./scripts/sync-shared-learnings.ps1` when shared learnings need propagation.