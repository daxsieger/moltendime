# Copilot Instructions

- Follow the shared logging policy in `../AGENTS.md`.
- Every user prompt must be recorded in `CHATS` with timestamp, handling agent, delegated agent, source client, and raw prompt text.
- Delegations to subagents must also be recorded.
- Use the chat logging hook when available.
- If a hook fails or a client path bypasses hooks, append the missing entry manually before finishing the task.
- Follow the shared versioning policy in `../AGENTS.md`.
- After each prompt that changes the workspace, create a git commit.
- If a hook does not commit automatically, run `./scripts/commit-prompt-state.ps1` before finishing the task.
- Any new AI customization added to this repo must also be implemented for Claude Code and Cursor and listed in `SUPPORTED.md`.