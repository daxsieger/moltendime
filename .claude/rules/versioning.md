# Versioning Rule

- Keep this workspace under git.
- After each prompt that changes the workspace, create a git commit.
- Use `./scripts/commit-prompt-state.ps1` when possible.
- Refresh `.ai/persona-knowledge/` before the commit so persona rule knowledge is stored as merge-friendly text.
- Refresh DB state manifests from `.ai/db-definitions.json` so cross-branch indexes can compare total knowledge hashes.
- Any new AI customization must also be represented for Copilot and Cursor and documented in `SUPPORTED.md`.
- Use one branch per agent personality, named `persona/<slug>`.
- Keep `.ai/SHARED_LEARNINGS.md` synchronized across personality branches.