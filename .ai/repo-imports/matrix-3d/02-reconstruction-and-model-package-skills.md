# matrix-3d Skills 06-10

## Skill 06: Separate Fast and Detailed Reconstruction Modes
- evidence: `README.md`
- method: Provide two panoramic 3D reconstruction methods so users can choose between rapid output and higher detail.
- transfer: Reconstruction systems should expose speed-quality tradeoffs directly rather than bury them in hidden configs.

## Skill 07: Build on Internal 3D Data and Video Priors
- evidence: `README.md`
- method: Attribute scene quality and generalization to self-developed 3D data and video priors.
- transfer: Explorable scene generation often needs priors that span both geometry and video dynamics.

## Skill 08: Package the System as Named Model Components
- evidence: `README.md`
- method: Publish discrete assets such as `Text2PanoImage`, `PanoVideoGen`, and `PanoLRM` instead of one opaque checkpoint.
- transfer: Multi-stage world-generation pipelines are easier to understand and adapt when each stage has a named artifact.

## Skill 09: Publish VRAM Envelopes Per Component
- evidence: `README.md`
- method: Document VRAM requirements per model and include low-VRAM alternatives where possible.
- transfer: World-generation stacks should expose component-level memory cost, not only a single maximum number.

## Skill 10: Treat Low-VRAM Modes as Product Features
- evidence: `README.md`
- method: Call out that a 5B model can run at 12G VRAM and that 720p generation can be driven in a reduced-memory mode.
- transfer: Memory-aware operating modes can materially expand who can evaluate a research system.