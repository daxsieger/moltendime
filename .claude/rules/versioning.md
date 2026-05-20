# Versioning Rule

- Keep this workspace under git.
- After each prompt that changes the workspace, create a git commit.
- Use `./scripts/commit-prompt-state.ps1` when possible.
- Any new AI customization must also be represented for Copilot and Cursor and documented in `SUPPORTED.md`.
- Use one branch per agent personality, named `persona/<slug>`.
- Keep `.ai/SHARED_LEARNINGS.md` synchronized across personality branches.
- Use `./scripts/sync-personality-branches.ps1` for batch push/pull of `main` and `persona/*` against GitHub when branch hygiene work is needed.
- Publish new `persona/<slug>` branches before normal personality-owned work begins.
- Use `./scripts/assert-personality-branch-published.ps1` to fail fast when the active personality branch is not yet on `origin`.