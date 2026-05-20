# Interactive World Models Comparison Note

## Purpose

This note distinguishes the most comparable public peers around `matrix-game` without collapsing them into one bucket.

Use it when routing future imports, deciding which skill bundle to reuse, or explaining why two repositories belong to the same family but should not be compared on the same axis.

## Reference Anchor

- `matrix-game` is the family anchor in this comparison, not a peer to itself.
- It combines continuation-oriented rollout, benchmark posture, and system-scale runtime evolution across three releases.
- The other repositories below should be read in relation to that anchor rather than as interchangeable alternatives.

## Continuation Peers

### `open-oasis`

- Primary role: lightweight continuation peer
- Why: the public repo is a compact action-conditioned rollout path that starts from prompt frames and continues gameplay one frame at a time.
- Limits: it is a narrow public inference slice, not a full benchmark or full product system.
- Reuse when: the destination project needs a minimal action-to-rollout path, compact DiT plus VAE wiring, or a public baseline for action-conditioned continuation.

### `mineworld`

- Primary role: strong continuation peer with benchmark weight
- Why: it exposes a real interactive runtime, explicit action-following evaluation, and decoding strategies designed for real-time continuation.
- Distinctive signal: diagonal decoding, cache refresh, and evaluation scripts make it closer to an executable benchmark peer than Open Oasis.
- Reuse when: the destination project needs interactive continuation plus measurable action-following behavior.

## Benchmark Peers

### `mineworld`

- Primary benchmark peer to `matrix-game`
- Why: both emphasize controllability, action-faithful rollout, and runtime behavior in a Minecraft-like environment.
- Strongest borrowed assets: decoding schedules, cache-management techniques, and metric-oriented evaluation posture.

### `open-oasis`

- Secondary benchmark-adjacent peer
- Why: it provides a public action-conditioned baseline, but its exposed repository surface is much narrower than MineWorld or Matrix-Game.
- Strongest borrowed assets: compact public inference contracts and backbone patterns for action-conditioned rollout.

## Creation Peer

### `gamefactory`

- Primary role: creation peer
- Why: its center of gravity is not extending one existing world state, but creating new games through scene generalization plus decoupled action control.
- Distinctive signal: the public repository contributes dataset/action-processing and control-visualization techniques rather than a full public rollout engine.
- Reuse when: the destination project needs to generalize control across scenes, clean action metadata, or audit controls visually during dataset preparation.

## Quick Routing Rules

- Reach for `mineworld` first when the question is continuation plus benchmarkability.
- Reach for `open-oasis` first when the question is public minimal continuation infrastructure.
- Reach for `gamefactory` first when the question is new-game creation or action-annotation quality.
- Keep `matrix-game` as the synthesis anchor when the question spans continuation, runtime scale, and long-horizon system design.