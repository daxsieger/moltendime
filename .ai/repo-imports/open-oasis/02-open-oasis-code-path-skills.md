# open-oasis Skills 06-10

## Skill 06: Support Mixed Checkpoint Formats Without Forking the Runtime
- evidence: `generate.py`
- method: Load both `.pt` and `.safetensors` checkpoints for the DiT and VAE paths using one runtime entrypoint.
- transfer: Public inference repos stay easier to reuse when checkpoint format differences do not split the user workflow.

## Skill 07: Seed CPU and CUDA Together for Repeatable Generation
- evidence: `generate.py`
- method: Set both `torch.manual_seed(0)` and `torch.cuda.manual_seed(0)` before model loading and rollout.
- transfer: Lightweight public demos should lock both CPU and GPU randomness when reproducibility matters.

## Skill 08: Normalize Prompt Inputs Into a Fixed Video-Like Tensor Contract
- evidence: `utils.py`
- method: Accept either image or video prompts, resize them to `360x640`, and reshape them to `1 x t x c x h x w` so the rest of the pipeline stays uniform.
- transfer: Mixed image and video conditioning becomes much simpler when both paths converge into the same batched temporal tensor layout.

## Skill 09: Normalize Actions Into a One-Hot Stream With an Initial No-Op Slot
- evidence: `utils.py`
- method: Convert action dictionaries into a fixed action-key layout, prepend a zero-action frame, and reshape to `1 x t x d` before sampling.
- transfer: Autoregressive world-model rollouts get cleaner when action tensors always include an aligned initial context step.

## Skill 10: Use Sliding-Window Latent Rollout With Stabilized Context Frames
- evidence: `generate.py`
- method: Append one noisy latent chunk at a time, hold prior frames at a stabilization noise level, and crop the active context to `model.max_frames` during denoising.
- transfer: Long rollouts in diffusion-style world models benefit from stabilized context reuse and explicit active-window limits.