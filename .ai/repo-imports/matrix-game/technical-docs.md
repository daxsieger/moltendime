# matrix-game Technical Notes

## Summary

Matrix-Game is a versioned world-model repository with three distinct releases that progressively move from controllable Minecraft world generation to real-time streaming inference and finally to long-horizon memory with first-person interactive generation. The repository is better understood as a series architecture than as one monolithic codebase.

## Version Architecture

- `Matrix-Game-1` is the foundational release: a 17B interactive world foundation model with explicit keyboard and mouse conditioning, a Minecraft-centric dataset posture, and a bundled GameWorld benchmark.
- `Matrix-Game-2` shifts the center of gravity toward causal inference and streaming runtime, with universal and scene-specialized modes for long interactive rollouts.
- `Matrix-Game-3` pushes further into long-horizon memory, distributed generation, async VAE support, quantization switches, and pose-aware interactive control.

## Core Technical Themes

- Action-conditioned image-to-world generation rather than plain text-to-video generation
- Dedicated evaluation of controllability and physical plausibility rather than perceptual quality alone
- Runtime evolution from heavy single-job inference toward streaming and distributed interactive generation
- Reuse of strong base-model families and diffusion stacks while making world control the primary product surface

## Code Surfaces That Matter

- `Matrix-Game-1/parallel_infer.py`: sequence parallelism, xFuser integration, component loading, and multi-GPU orchestration
- `Matrix-Game-1/matrixgame/sample/pipeline_matrixgame.py`: video pipeline surface adapted from Diffusers-style infrastructure
- `Matrix-Game-1/GameWorldScore/*`: bundled benchmark for Minecraft world models
- `Matrix-Game-2/inference.py` and `inference_streaming.py`: causal rollout and streaming entrypoints
- `Matrix-Game-2/pipeline/causal_inference.py`: core version-2 inference path
- `Matrix-Game-3/generate.py`: distributed generation entrypoint and runtime switches
- `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`: long-horizon memory, action input, pose utilities, and interactive rollout

## Lineage

- Explicit lineage exists in the repo for Diffusers, HunyuanVideo, Open-Sora-Plan, SkyReels-V2, Self-Forcing, Wan2.2, lingbot-world, and LightX2V.
- The world-surface lineage is also shaped by MineDojo, MineRL, Video-Pre-Training, and GameFactory.
- Oasis and MineWorld are better treated as benchmark-adjacent world-model peers than as explicit code ancestors.

## Procedural-World Interpretation

- Matrix-Game clearly belongs to the interactive world-generation family.
- The repository does not explicitly claim descent from classic procedural-terrain engines, so terrain/world-generation lineage should be documented as adjacent and inferred unless the repo says otherwise.
- The best adjacent import candidates are therefore action-grounded world models, world datasets, inverse-dynamics systems, and adjacent 3D scene generation repos rather than generic terrain libraries.

## README Preview

<p align="center">
<h1 align="center">Matrix-Game</h1>
<h3 align="center">Skywork AI</h3>
</p>

## 🔥🔥🔥 News!!
* March 27, 2026: 🔥 We released [Matrix-Game-3.0](https://github.com/SkyworkAI/Matrix-Game/tree/main/Matrix-Game-3). This  is a real-time and streaming interactive world model with long-horizon Memory.
* Aug 12, 2025: 🔥 We released [Matrix-Game-2.0](https://github.com/SkyworkAI/Matrix-Game/tree/main/Matrix-Game-2). This is an interactive world foundation model for real-time long video generation.
* May 12, 2025: 🔥 We released [Matrix-Game-1.0](https://github.com/SkyworkAI/Matrix-Game/tree/main/Matrix-Game-1). The first open-source release of Skywork AI's Matrix-Game series world models.


## 📝 Overview

**Matrix-Game** is a series of open-source world models launched by Skywork AI.

This repository provides the official implementations of Matrix-Game-1.0, Matrix-Game-2.0 and Matrix-Game-3.0

https://github.com/user-attachments/assets/f5387c64-1d18-414a-935f-00a1f6eec8de



## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
