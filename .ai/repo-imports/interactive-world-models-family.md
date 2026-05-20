# Interactive World Models Family

## Scope

This family groups repositories that treat world generation as an interactive or explorable runtime problem rather than as generic offline video generation.

Members may differ in environment, representation, and decoding strategy, but they share at least one of these properties:

- action-conditioned world rollout
- real-time or near-real-time world-model inference
- explorable scene generation rather than fixed-view video only
- benchmark or demo surfaces centered on controllability and world continuity

## Current Members

### Core Series

- `matrix-game`: versioned interactive world-model series spanning Minecraft control, streaming rollout, and long-horizon memory

### Sibling Scene Generation

- `matrix-3d`: panoramic explorable 3D world generation with conditional video plus reconstruction

### Benchmark-Adjacent Peers

- `open-oasis`: public Oasis 500M inference release for action-conditional gameplay generation
- `mineworld`: Minecraft autoregressive world model with diagonal decoding and explicit action-following evaluation
- `gamefactory`: generative interactive video framework for creating new games with decoupled action control

### Upstream Generative Backbone Peers

- `wan-2-2`: Wan-based multimodal video backbone with MoE diffusion, prompt extension, and distributed inference patterns

## Relationship Map

- `matrix-game` and `mineworld` are the closest peers on Minecraft-like interactive world modeling.
- `matrix-game` and `open-oasis` are close on action-conditioned gameplay rollout, but `open-oasis` is a smaller public inference slice.
- `gamefactory` is an alternative and complementary peer to `matrix-game`: both care about controllability, but `gamefactory` leans harder into scene generalization and new-game creation.
- `matrix-3d` is adjacent by world-generation ambition, but its center of gravity is explorable panoramic 3D scene creation rather than keyboard-driven game rollout.
- `wan-2-2` is farther from direct gameplay interaction, but it is a strong upstream backbone peer for systems that inherit Wan-style video priors or deployment patterns.

## Reuse Rules

- Reuse action-conditioning, benchmark, and runtime-decoding techniques across `matrix-game`, `mineworld`, and `open-oasis` when the destination repository is interactive and control-sensitive.
- Reuse decoupled action-control and scene-generalization techniques from `gamefactory` when the destination repository aims to create or generalize new game worlds rather than only continue one established environment.
- Reuse explorable-scene and scene-reconstruction techniques from `matrix-3d` when the destination repository targets free-view exploration or scene materialization.
- Reuse prompt extension, multimodal task packaging, and distributed inference patterns from `wan-2-2` when the destination repository needs a stronger Wan-based generation substrate.
- Use `interactive-world-models-comparison.md` when you need a sharper distinction between continuation peers, benchmark peers, and creation peers around `matrix-game`.
- Keep first-level skills with their dedicated personas; this family note is only an archivist index and routing aid.

## Recommended Import Sequence

1. `matrix-3d`
2. `open-oasis`
3. `mineworld`
4. `gamefactory`
5. `wan-2-2`
6. `HunyuanVideo`
7. `SkyReels-V2`

## Why This Family Exists

- It prevents false one-to-one comparisons while still grouping repositories that share interactive world-generation constraints.
- It gives the archivist one place to route future imports related to world models, explorable scenes, and controllable game-like rollouts.