# matrix-game Skills 71-80

## Skill 71: Model Interactive Control as Paired Camera and Movement Inputs
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`
- method: Ask separately for mouse-like camera motion and keyboard-like movement at each interaction step.
- transfer: First-person world models benefit from disentangling view control from locomotion.

## Skill 72: Map Human-Friendly Keys to Explicit Action Tensors
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`
- method: Convert `I/K/J/L/U` and `W/S/A/D/Q` into numeric mouse and keyboard tensors.
- transfer: Keep the operator surface mnemonic while making the model input fully explicit.

## Skill 73: Treat Camera Delta Magnitude as a Small, Tunable Primitive
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`
- method: Centralize the camera delta scale in one `CAM_VALUE` constant.
- transfer: Fine control over first-person rollout often depends on a single action scale more than on architectural changes.

## Skill 74: Move From Abstract Control to Pose-Aware Memory Selection
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/utils/cam_utils.py`
- method: Import relative-pose computation, memory-index selection by field of view, and camera intrinsics into the interactive pipeline.
- transfer: Long-horizon memory works better when memory retrieval is camera-aware rather than purely temporal.

## Skill 75: Build Plucker Geometry Features From Pose State
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/utils/utils.py`
- method: Construct Plucker-style representations from camera-to-world transforms and action-derived poses.
- transfer: Geometry-aware conditioning can stabilize world continuity across long rollouts.

## Skill 76: Reconstruct Pose History From Action History
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/utils/utils.py`
- method: Compute all poses from actions rather than treating actions as ephemeral one-step controls.
- transfer: World-memory systems should preserve control history as an evolving trajectory, not as isolated button presses.

## Skill 77: Interpolate Camera Poses With Handedness Handling
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/utils/cam_utils.py`
- method: Use explicit handedness-aware pose interpolation utilities for camera transitions.
- transfer: Cross-frame camera continuity deserves its own math utilities in first-person world models.

## Skill 78: Keep a Bench Action Generator Available Even in the Interactive Pipeline
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/utils/conditions.py`
- method: Import `Bench_actions_universal` as a fallback or standardized action source.
- transfer: Interactive systems still benefit from deterministic action programs for repeatable tests.

## Skill 79: Offload VAE Decode to a Worker Process When the Pipeline Supports It
- evidence: `Matrix-Game-3/pipeline/inference_interactive_pipeline.py`, `Matrix-Game-3/pipeline/vae_worker.py`
- method: Start a separate VAE worker process from the interactive pipeline.
- transfer: Decoding is often the easiest stage to decouple when interactive latency matters.

## Skill 80: Treat First-Person Unreal Scenes as a Distinct World Surface
- evidence: `Matrix-Game-3/README.md`, `Matrix-Game-3/demo_images`
- method: Package the release around first-person unreal-scene generation rather than Minecraft-only continuity.
- transfer: Later world-model versions can change environment family while preserving the control-and-memory abstraction.