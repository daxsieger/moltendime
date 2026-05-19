# matrix-game Skills 31-40

## Skill 31: Recast the Second Version Around Real-Time Long Video
- evidence: `Matrix-Game-2/README.md`
- method: Move from the first release's controllable world framing to an explicit real-time long-video framing.
- transfer: Versioned world-model repos should let later releases tighten the runtime goal rather than only scale parameter count.

## Skill 32: Name the Core Architecture as Auto-Regressive Diffusion-Based Image-to-World
- evidence: `Matrix-Game-2/README.md`
- method: State that Matrix-Game-2 is built upon an auto-regressive diffusion-based image-to-world framework.
- transfer: When sequence extension is central, make the causal or autoregressive shift part of the public contract.

## Skill 33: Expose Real-Time Claims as Concrete FPS
- evidence: `Matrix-Game-2/README.md`
- method: Tie the real-time claim to 25 fps rather than leaving it as a vague marketing statement.
- transfer: Runtime claims should carry operational numbers whenever possible.

## Skill 34: Release Scene-Specific Weights Alongside a Universal Model
- evidence: `Matrix-Game-2/README.md`
- method: Package universal, GTA-driving, and TempleRun checkpoints under one version family.
- transfer: Specialized scene variants can coexist with a general model if their roles are explicit.

## Skill 35: Use Config Files as the Main Mode Selector
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/inference_streaming.py`
- method: Let the YAML config choose whether the run is `universal`, `gta_drive`, or `templerun`.
- transfer: Keep scenario selection in config assets so the Python entrypoints stay thin.

## Skill 36: Separate Standard Inference From Streaming Inference
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/inference_streaming.py`
- method: Maintain one script for batch-style generation and one for user-driven streaming sessions.
- transfer: Streaming introduces its own lifecycle and should have its own operator surface.

## Skill 37: Use the Input Image as the First Latent Anchor
- evidence: `Matrix-Game-2/inference.py`
- method: Encode the input image as the first latent frame before extending the rollout.
- transfer: Image-to-world systems should make the initial world state explicit in latent space.

## Skill 38: Publish Known Rendering Failure Modes as Operator Tips
- evidence: `Matrix-Game-2/README.md`
- method: Document that upward camera movement can cause brief glitches or black screens.
- transfer: Small failure notes save users time and build trust faster than pretending the runtime is flawless.

## Skill 39: Keep the Deployment Contract Linux-and-GPU Explicit
- evidence: `Matrix-Game-2/README.md`
- method: Document the tested setup as Linux, 24 GB+ NVIDIA GPU, and 64 GB RAM.
- transfer: Research inference code should publish the tested envelope, not just the theory.

## Skill 40: Link Adjacent 3D Scene Work Instead of Overloading the Main Repo
- evidence: `Matrix-Game-2/README.md`
- method: Point large-scale explorable 3D scene generation users toward Matrix-3D rather than cramming that goal into Matrix-Game-2.
- transfer: Use related-project links to keep adjacent but distinct product surfaces separated.