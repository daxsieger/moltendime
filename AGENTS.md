# Agent Logging Policy

This repository uses a mandatory shared chat log in `CHATS`.

## Required Behavior

- Log every user prompt, command, or delegated task to `CHATS`.
- Include an ISO 8601 timestamp for every entry.
- Include the agent currently handling the prompt.
- Include the delegated agent when work is handed off.
- Preserve the original prompt or task text in a fenced `text` block.
- If deterministic hooks are available, rely on them first.
- If hooks are unavailable or fail, append the entry manually before completing the task.
- Commit repository changes after every prompt.
- Implement every new AI customization for GitHub Copilot, Claude Code, and Cursor, then record support status in `SUPPORTED.md`.

## Canonical Entry Format

```markdown
### 2026-05-04T10:49:15.3670244+02:00
- event: user_prompt
- source_client: copilot
- handling_agent: GitHub Copilot
- delegated_to: none
- recorded_by: hook
- backfilled: false

```text
User prompt or delegated task body
```
```

## Delegation Rules

- On subagent start, log the task with `event: subagent_start` and set `delegated_to`.
- On subagent completion, log `event: subagent_stop` with the same delegated agent name.
- If a tool-specific hook system cannot guarantee the append, the acting agent must update `CHATS` manually.

## Versioning Rules

- The workspace must remain a git repository.
- After each prompt that changes the workspace, create a git commit.
- Prefer the shared script at `./scripts/commit-prompt-state.ps1` for consistent commit messages and repo bootstrapping.
- If a client cannot enforce prompt-end commits with hooks, the acting agent must run the commit script before completing the response.

## Cross-Engine Rule

- Every new skill, instruction, hook, or agent workflow for AI tooling must be implemented for GitHub Copilot, Claude Code, and Cursor.
- If one engine lacks a native primitive, provide the closest supported equivalent and document the limitation in `SUPPORTED.md`.

## Compatibility Notes

- GitHub Copilot: enforced with workspace instructions, skill, and `.github/hooks/`.
- Claude Code: enforced with `CLAUDE.md`, `.claude/rules/`, and `.claude/settings.json` hooks.
- Cursor: guided with `.cursor/rules/`. Cursor project rules can require the behavior, but they do not provide the same deterministic hook guarantee available in Copilot and Claude Code.