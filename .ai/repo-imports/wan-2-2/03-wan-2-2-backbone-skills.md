# wan-2-2 Skills 11-15

## Skill 11: Prefer Varlen Flash Attention But Keep A Native Fallback Path
- evidence: `wan/modules/attention.py`
- method: Route attention through Flash Attention 3 when available, fall back to Flash Attention 2 otherwise, and preserve a final scaled-dot-product-attention path when flash kernels are unavailable.
- transfer: Large video backbones stay portable when high-performance attention is optional infrastructure rather than a hard runtime dependency.

## Skill 12: Encode Video Position With Factorized Rotary Frequencies Across Time, Height, And Width
- evidence: `wan/modules/model.py`
- method: Build RoPE frequencies separately for temporal, vertical, and horizontal axes, then compose them per sample from `grid_sizes` before applying them to Q and K.
- transfer: Video transformers handle variable spatiotemporal grids more cleanly when positional structure is expressed as axis-aware factors instead of one flattened sequence embedding.

## Skill 13: Modulate Every Transformer Block With Six-Way Time Conditioning Gates
- evidence: `wan/modules/model.py`
- method: Project diffusion timestep embeddings into six modulation streams that scale and shift self-attention, cross-attention, and FFN subpaths inside each attention block.
- transfer: Diffusion backbones gain finer control over denoising dynamics when timestep conditioning gates the internal residual paths rather than only the input tokens.

## Skill 14: Carry Variable-Length Video Through The Backbone With Explicit Patch Grids And Sequence Lengths
- evidence: `wan/modules/model.py`
- method: Patchify video clips with a 3D convolution, track per-sample `grid_sizes` and `seq_lens`, pad only to the shared maximum sequence length, then unpatchify explicitly back into video tensors.
- transfer: Backbone code stays reusable across mixed resolutions and clip lengths when shape bookkeeping is treated as part of the model contract.

## Skill 15: Build The VAE As A Causal 3D Hierarchy With Temporal Cache Reuse
- evidence: `wan/modules/vae2_2.py`
- method: Combine causal 3D convolutions, temporal-aware up/downsampling, patchify or unpatchify helpers, and feature caches so encoding or decoding can reuse recent frames across chunk boundaries.
- transfer: High-compression video VAEs become more deployment-friendly when temporal causality and chunk reuse are native architecture features instead of external serving tricks.