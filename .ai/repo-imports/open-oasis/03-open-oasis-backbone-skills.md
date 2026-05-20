# open-oasis Skills 11-15

## Skill 11: Split Attention Into Temporal and Spatial Axial Operators
- evidence: `attention.py`
- method: Implement separate temporal-causal and spatial-noncausal axial attention modules instead of one monolithic spatiotemporal attention block.
- transfer: Video backbones can reduce complexity and preserve inductive bias by decomposing time and space attention paths.

## Skill 12: Apply Rotary Embeddings Differently for Time and Pixel Axes
- evidence: `attention.py`, `vae.py`
- method: Rotate temporal queries and keys with one rotary policy and spatial pixel grids with axial frequencies derived from frame height and width.
- transfer: Mixed temporal and spatial representations benefit from axis-specific positional treatment instead of one shared embedding rule.

## Skill 13: Keep Attention in Native Tensor Layouts Until the Last Possible Moment
- evidence: `attention.py`
- method: Rearrange tensors into head-aware temporal or spatial layouts, run attention, then project back to the model channel space only after the focused operator completes.
- transfer: Explicit tensor layout control is often the difference between readable and brittle video-attention code.

## Skill 14: Use a Diagonal Gaussian Latent Interface for the VAE
- evidence: `vae.py`
- method: Encode VAE outputs as mean and log-variance pairs with clamped variance, then expose both `sample()` and `mode()` for downstream use.
- transfer: Public generative repos become easier to adapt when the latent distribution object is explicit and reusable.

## Skill 15: Build the VAE Around Patch Embedding Plus Attention Blocks
- evidence: `vae.py`
- method: Structure the autoencoder with patch embedding, attention blocks, and MLP blocks rather than a purely convolutional image stack.
- transfer: Patchified VAE design is a useful bridge when the generator side is already transformer-native.