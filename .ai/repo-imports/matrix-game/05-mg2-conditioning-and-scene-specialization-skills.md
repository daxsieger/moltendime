# matrix-game Skills 41-50

## Skill 41: Normalize Input Frames to a Fixed 352x640 Viewport
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/inference_streaming.py`
- method: Resize and crop the input image to a fixed 352x640 frame before encoding.
- transfer: Action-conditioned world generation needs a stable camera canvas before latent rollout begins.

## Skill 42: Build Rollout Latents by Padding Beyond the First Conditioned Frame
- evidence: `Matrix-Game-2/inference.py`
- method: Concatenate the first encoded frame with zero padding for the remaining latent horizon.
- transfer: Image-conditioned rollout pipelines benefit from an explicit latent bootstrap rather than hidden warm starts.

## Skill 43: Concatenate Mask and Image Latents Into One Conditioning Block
- evidence: `Matrix-Game-2/inference.py`
- method: Create a mask that preserves only the first latent frame and concatenate it with the encoded image condition.
- transfer: Separate visibility and content roles inside the condition tensor when only part of the rollout is observed.

## Skill 44: Keep Visual Context Separate From Latent Concatenation
- evidence: `Matrix-Game-2/inference.py`
- method: Use the VAE clip encoder to produce `visual_context` alongside the concatenated latent condition.
- transfer: Some context is best carried as semantic embeddings rather than packed into the latent tensor itself.

## Skill 45: Use Scene-Specific Action Builders Instead of One Universal Control Template
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/utils/conditions.py`
- method: Choose among `Bench_actions_universal`, `Bench_actions_gta_drive`, and `Bench_actions_templerun`.
- transfer: Control programs should reflect scene semantics when gameplay regimes differ materially.

## Skill 46: Treat Mouse Conditioning as Optional by Scene
- evidence: `Matrix-Game-2/inference.py`
- method: Add mouse conditioning for universal and GTA-driving scenes, but let TempleRun rely on keyboard-only control.
- transfer: Do not force every environment to use the same control modality if the game loop differs.

## Skill 47: Keep Keyboard Conditioning Mandatory Across Scene Modes
- evidence: `Matrix-Game-2/inference.py`
- method: Always include keyboard condition tensors even when other controls are scene-specific.
- transfer: Preserve one common action backbone across variants while letting optional channels vary.

## Skill 48: Sample Noise in the Target Latent Shape Up Front
- evidence: `Matrix-Game-2/inference.py`
- method: Initialize noise directly in `[1, 16, frames, 44, 80]` latent shape.
- transfer: Make the rollout tensor geometry explicit where control, VAE tiling, and scheduler logic meet.

## Skill 49: Post-Process Output With Control Overlay Modes
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/utils/visualize.py`
- method: Render one output with icon overlays and one without, using the same control configuration.
- transfer: Keep operator-visible debugging overlays separate from clean demo output.

## Skill 50: Preserve Output as Contiguous Uint8 Video Before Visualization
- evidence: `Matrix-Game-2/inference.py`
- method: Rearrange to `B T H W C`, clamp to `[0,255]`, cast to `uint8`, and make the array contiguous.
- transfer: Standardize the final memory layout before handing generated video to visualization or export code.