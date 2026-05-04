# Chat Logging Rule

- Follow `AGENTS.md` for the canonical log format.
- Every incoming user prompt must appear in `CHATS`.
- Every delegated task must appear in `CHATS` with the delegated agent name.
- If hooks do not append the entry automatically, append it manually before finishing the response.
- Timestamps must be normalized to ISO 8601 format.