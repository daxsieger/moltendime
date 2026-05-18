# web-splat Skills 31-40

## Skill 31: Store Core Gaussian Data in Half Precision
- evidence: `src/pointcloud.rs`
- optimization: Represent opacity and covariance in `f16` inside the main gaussian struct.
- transfer: Push static point-cloud payloads to half precision when the visual error is acceptable.

## Skill 32: Use Indirection for Compressed Geometry and SH Data
- evidence: `src/pointcloud.rs`
- optimization: Split compressed gaussians into position-plus-index records that point to shared geometry and SH data.
- transfer: De-duplicate repeated payloads by storing lightweight point records and shared backing tables.

## Skill 33: Pack SH Coefficients as 4x8 SNORM and Dequantize on GPU
- evidence: `src/shaders/preprocess_compressed.wgsl`
- optimization: Read packed signed-normalized SH bytes and dequantize them in the preprocess shader.
- transfer: Trade a small amount of ALU for a large reduction in bandwidth and storage.

## Skill 34: Support Optional Scaling-Factor Compression Paths
- evidence: `src/io/npz.rs`, `src/shaders/preprocess_compressed.wgsl`
- optimization: Handle a dedicated `scaling_factor` channel when scale direction and scale magnitude are stored separately.
- transfer: Keep loader and shader paths flexible enough to absorb alternate compression layouts.

## Skill 35: Precompute Covariance Once for Compressed Assets
- evidence: `src/io/npz.rs`, `src/utils.rs`
- optimization: Rebuild covariance matrices on CPU during load and upload them as a compact buffer.
- transfer: Move repeated geometric reconstruction out of the frame loop when the input is static.

## Skill 36: De-Duplicate Feature and Gaussian Indices
- evidence: `src/io/npz.rs`
- optimization: Support optional `feature_indices` and `gaussian_indices` arrays so repeated attributes can be shared.
- transfer: Normalize compressed datasets around shared index tables when repetition is high.

## Skill 37: Reorder Channel-First SH Storage While Reading PLY
- evidence: `src/io/ply.rs`
- optimization: Convert higher-order SH coefficients from channel-first layout to per-coefficient RGB triplets during load.
- transfer: Normalize upstream storage quirks at ingestion time so shaders stay simple.

## Skill 38: Read and Discard Normals Instead of Seeking Past Them
- evidence: `src/io/ply.rs`
- optimization: Consume normal data directly because sequential reads outperformed seeking.
- transfer: Prefer linear reads over fine-grained seeking in binary asset parsers when I/O locality wins.

## Skill 39: Use a Numerically Stable Sigmoid
- evidence: `src/utils.rs`, `src/io/ply.rs`
- optimization: Apply a branch-stable sigmoid implementation when reconstructing opacity from logits.
- transfer: Harden numerically sensitive transforms in the ingestion path so bad values do not poison the renderer.

## Skill 40: Carry Rendering Metadata Through Asset Comments and Arrays
- evidence: `src/io/ply.rs`, `src/io/npz.rs`
- optimization: Load `kernel_size`, `mip_splatting`, and `background_color` metadata directly from the asset.
- transfer: Make assets self-describing enough to reproduce the intended renderer configuration automatically.
