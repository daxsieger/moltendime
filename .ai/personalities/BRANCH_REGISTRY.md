# Personality Branch Registry

This registry makes the branch split explicit.

Each declared personality must have a dedicated `persona/<slug>` branch, and persona-specific knowledge work should start from that branch rather than from `main`.

## Active Personality Branches

| Personality | Branch | Primary Knowledge Surface |
|---|---|---|
| ai-rule-learner | `persona/ai-rule-learner` | rule archive, cataloging, cross-persona indexing |
| builder | `persona/builder` | implementation and workspace construction |
| gamefactory-interactive-video-architect | `persona/gamefactory-interactive-video-architect` | `.ai/repo-imports/gamefactory/` |
| matrix-3d-scene-architect | `persona/matrix-3d-scene-architect` | `.ai/repo-imports/matrix-3d/` |
| matrix-game-world-model-architect | `persona/matrix-game-world-model-architect` | `.ai/repo-imports/matrix-game/` |
| mineworld-minecraft-world-modeler | `persona/mineworld-minecraft-world-modeler` | `.ai/repo-imports/mineworld/` |
| moltbook-user | `persona/moltbook-user` | Moltbook user-facing guidance |
| moltbook-user-network | `persona/moltbook-user-network` | Moltbook network-oriented guidance |
| open-oasis-world-modeler | `persona/open-oasis-world-modeler` | `.ai/repo-imports/open-oasis/` |
| paper-skill-learner | `persona/paper-skill-learner` | `.ai/paper-imports/` |
| planner | `persona/planner` | planning and decomposition workflows |
| repo-skill-learner | `persona/repo-skill-learner` | repository import and bundle extraction workflows |
| researcher | `persona/researcher` | discovery and technical research workflows |
| reviewer | `persona/reviewer` | review and defect-finding workflows |
| wan-2-2-video-systems-architect | `persona/wan-2-2-video-systems-architect` | `.ai/repo-imports/wan-2-2/` |
| wan-move-paper-learner | `persona/wan-move-paper-learner` | Wan-Move paper bundle |
| web-llm-runtime-architect | `persona/web-llm-runtime-architect` | web-llm runtime bundle |
| web-splat-optimizer | `persona/web-splat-optimizer` | web-splat optimization bundle |
| websplatter-paper-learner | `persona/websplatter-paper-learner` | WebSplatter paper bundle |

## Operating Rule

1. Use `main` as the integration branch.
2. Use `persona/<slug>` as the working branch for personality-owned knowledge changes.
3. Keep shared cross-personality carryover in `.ai/SHARED_LEARNINGS.md`.
4. Merge or replay persona work back into `main` only after the personality-specific slice is coherent.

## Current Note

- `persona/moltbook-programmers` exists locally as a branch but does not currently have a matching file in `.ai/personalities/`.
- All declared personality files under `.ai/personalities/` now have a matching local `persona/<slug>` branch.