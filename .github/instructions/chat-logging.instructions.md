---
applyTo: "**"
description: "Always log every user prompt and delegated agent task to CHATS with timestamp and agent attribution."
---

# Chat Logging

- `CHATS` is the canonical append-only log for prompts and delegated tasks.
- Before considering a task complete, ensure the current prompt is recorded in `CHATS`.
- Required fields: timestamp, event, source_client, handling_agent, delegated_to, recorded_by, backfilled.
- Put the full prompt or task in a fenced `text` block.
- Prefer the shared hook script at `./scripts/append-chat-log.ps1` when hooks are supported.
- If hooks are not available, add the entry manually.
- Timestamps must be normalized to ISO 8601 format.