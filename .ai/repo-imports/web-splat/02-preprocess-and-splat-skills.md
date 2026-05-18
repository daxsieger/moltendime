# web-splat Skills 11-20

## Skill 11: Convert 3D Gaussians to 2D Splats on GPU
- evidence: `src/renderer.rs`, `src/shaders/preprocess.wgsl`
- optimization: Run a compute preprocess pass that projects 3D gaussians into packed 2D splat instances before rendering.
- transfer: Move view-dependent splat expansion into compute so the render pass stays simple.

## Skill 12: Clip Before Expensive Math
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Reject splats outside the clipping box before covariance projection and SH evaluation.
- transfer: Put cheap spatial rejection ahead of all expensive per-point math.

## Skill 13: Frustum-Cull Before Sort Enqueue
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Return early when depth or projected bounds fall outside the clip volume.
- transfer: Keep invisible points out of sort buffers entirely.

## Skill 14: GPU-Side Visible Count Accumulation
- evidence: `src/shaders/preprocess.wgsl`, `src/renderer.rs`
- optimization: Use `atomicAdd` to accumulate visible splats and dispatch counts directly on GPU.
- transfer: Let compute passes produce draw counts instead of round-tripping visibility to the CPU.

## Skill 15: Project Covariance Through the Camera Jacobian
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Build screen-space covariance via `J`, `W`, and transformed 3D covariance.
- transfer: Preserve anisotropic splat quality by projecting covariance analytically.

## Skill 16: Mip-Splatting Opacity Compensation
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Correct opacity using determinant ratios when mip splatting is enabled.
- transfer: Compensate blur growth analytically instead of relying on heuristic alpha tweaks.

## Skill 17: Kernel-Size Regularization in Screen Space
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Add kernel size to diagonal covariance terms before eigen analysis.
- transfer: Stabilize projected splats by regularizing the screen-space ellipse.

## Skill 18: Front-to-Back Blending for 8-Bit Targets
- evidence: `src/renderer.rs`
- optimization: Use front-to-back style blending for better visual quality on 8-bit render targets.
- transfer: Match blend direction to target precision when translucent accumulation artifacts matter.

## Skill 19: Pack Screen Axes and Colors into f16 Pairs
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Pack 2D axes, center, and RG/BA color channels into half-precision pairs.
- transfer: Compress splat payloads aggressively once they are in screen space.

## Skill 20: Scene-Relative Scale Modulation
- evidence: `src/shaders/preprocess.wgsl`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Modulate gaussian scale from `walltime`, scene center, and scene extent.
- transfer: Tie progressive reveal or temporal emphasis to scene-relative distance instead of absolute coordinates.
