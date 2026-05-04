@AGENTS.md

# Claude Code

- Follow the shared logging policy from `AGENTS.md`.
- Load the workspace log at `CHATS` when checking whether a prompt was already recorded.
- If Claude hooks are disabled or unavailable, append to `CHATS` manually before responding.
- Follow the shared versioning policy from `AGENTS.md`.
- If hooks do not commit automatically, run `./scripts/commit-prompt-state.ps1` before finishing a prompt that changed the workspace.
- Any new AI customization added to this repo must also be represented for Copilot and Cursor and listed in `SUPPORTED.md`.