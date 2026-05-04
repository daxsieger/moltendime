---
name: chat-logging
description: 'Use for logging every user prompt, command, and delegated task into CHATS with timestamp, handling agent, delegated agent, and source client.'
argument-hint: 'Provide the prompt or task text plus the handling agent and delegated agent when relevant.'
user-invocable: true
---

# Chat Logging

Use this skill whenever prompt logging is requested, when hooks are unavailable, or when you need to backfill missing entries.

## Procedure

1. Read `CHATS` if you need to verify whether the prompt is already present.
2. Append a new entry using the canonical format from `AGENTS.md`.
3. If a hook system is available, prefer the shared script at [append-chat-log.ps1](../../../scripts/append-chat-log.ps1).
4. If work is delegated, record `delegated_to` with the target agent name.

## Required Fields

- timestamp
- event
- source_client
- handling_agent
- delegated_to
- recorded_by
- backfilled
- prompt body