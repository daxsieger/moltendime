---
name: matrix-game-knowledge-bridge
description: 'Use when an external repository needs to load and adapt the Matrix-Game knowledge bundle from the canonical knowledge host repository.'
argument-hint: 'Optional: provide a branch, tag, or commit for the canonical knowledge host repository and the destination repository context.'
user-invocable: true
---

# matrix-game Knowledge Bridge

## Canonical Reference

- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_name: matrix-game
- maintained_by_agent: Matrix Game World Model Architect

## Load Sequence

1. Open https://github.com/daxsieger/moltendime.
2. Read `.ai/repo-imports/matrix-game/skills.md` and `.ai/repo-imports/matrix-game/skills-index.md`.
3. Load the ten skill packs under `.ai/repo-imports/matrix-game/` according to the destination repository's needs.
4. Read `.ai/repo-imports/matrix-game/memories.md`, `.ai/repo-imports/matrix-game/technical-docs.md`, `.ai/repo-imports/matrix-game/sources.md`, and `.ai/repo-imports/matrix-game/lineage-and-import-candidates.md`.
5. Reuse Matrix-Game techniques for action-conditioned world modeling, streaming rollout, long-horizon memory, benchmark design, and world-data planning.
6. Do not transfer the `matrix-game-world-model-architect` persona ownership itself; adapt the relevant skills into the destination repository persona.
7. Delegate refresh work to `matrix-game-world-model-architect` when the upstream repository changes materially.

## Automatic Reuse Rule

- If a destination repository works on interactive world models, action-conditioned video generation, Minecraft-like world rollouts, first-person memory-aware generation, or adjacent procedural-world systems, load this bundle before synthesizing new guidance.
- If the destination repository is closer to classic terrain or voxel generation than to diffusion world models, reuse the lineage and benchmark notes selectively and record the adaptation boundary.
