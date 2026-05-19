# matrix-3d Skills 01-05

## Skill 01: Use Panoramic Representation as the Core World Surface
- evidence: `README.md`
- method: Represent the scene panoramically to support wide-coverage omnidirectional world generation.
- transfer: If free exploration is a primary goal, choose a representation that naturally covers the full scene envelope.

## Skill 02: Couple Video Generation and 3D Reconstruction
- evidence: `README.md`
- method: Combine conditional panoramic video generation with panoramic 3D reconstruction instead of treating them as unrelated tasks.
- transfer: Explorable world generation improves when view synthesis and scene reconstruction are designed as one system.

## Skill 03: Optimize for 360-Degree Free Exploration
- evidence: `README.md`
- method: Define broader, more expansive scenes and full 360-degree exploration as first-class product goals.
- transfer: State the exploration target explicitly, because it changes both representation and evaluation priorities.

## Skill 04: Support Both Text and Image Inputs
- evidence: `README.md`
- method: Expose both image-to-scene and text-to-scene generation paths inside the same project.
- transfer: Multimodal conditioning broadens scene bootstrapping and lowers operator friction.

## Skill 05: Treat Trajectory Control as Part of Scene Generation
- evidence: `README.md`
- method: Support customizable trajectories and infinite extensibility rather than a fixed orbit path only.
- transfer: Explorable 3D worlds need path control as part of the generation contract.