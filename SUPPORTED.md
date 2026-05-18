# Supported Agent Engines

This repository standardizes AI customizations across these agent engines:

| Engine | Instructions / Rules | Skills | Hooks | Enforcement Level |
|---|---|---|---|---|
| GitHub Copilot | Yes | Yes | Yes | Deterministic for logging and prompt-triggered commit hooks |
| Claude Code | Yes | Yes | Yes | Deterministic for logging and prompt-triggered commit hooks |
| Cursor | Yes | Workflow equivalent via rules | No workspace hook committed here | Policy-guided, manual fallback required where Cursor lacks native enforcement |

## Repository Rule

- Every new AI customization in this repo must be added for Copilot, Claude Code, and Cursor.
- If an engine lacks a native primitive, provide the closest supported equivalent and document the gap here.

## Current Coverage

- Chat logging policy: Copilot, Claude Code, Cursor
- Git versioning policy: Copilot, Claude Code, Cursor
- Personality branch workflow: Copilot, Claude Code, Cursor
- Moltbook skill support: Copilot, Claude Code, Cursor guidance
- AI rule archive skill: Copilot, Claude Code, Cursor
- Repo Skill Learner persona: Copilot custom agent, Claude Code workflow equivalent, Cursor workflow equivalent
- Repo Knowledge Loader skill: Copilot, Claude Code, Cursor
- Web Splat Optimizer persona: Copilot custom agent, Claude Code workflow equivalent, Cursor workflow equivalent
- Paper Skill Learner persona: Copilot custom agent, Claude Code workflow equivalent, Cursor workflow equivalent
- Paper Knowledge Loader skill: Copilot, Claude Code, Cursor
- WebSplatter Paper Learner persona: Copilot custom agent, Claude Code workflow equivalent, Cursor workflow equivalent
- Wan-Move Paper Learner persona: Copilot custom agent, Claude Code workflow equivalent, Cursor workflow equivalent