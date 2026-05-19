# matrix-game Skills 61-70

## Skill 61: Auto-Disable FSDP When Running on a Single GPU
- evidence: `Matrix-Game-3/generate.py`
- method: Turn off `t5_fsdp` and `dit_fsdp` automatically when `ulysses_size <= 1`.
- transfer: Runtime flags should self-heal when the environment obviously cannot support the distributed mode.

## Skill 62: Validate Prompt, Image, and Checkpoint Path Before Pipeline Creation
- evidence: `Matrix-Game-3/generate.py`
- method: Fail fast if the core conditioning assets are missing.
- transfer: Large inference jobs should reject incomplete launches before any model initialization happens.

## Skill 63: Pull Sampling Defaults From the Canonical Config When Users Omit Them
- evidence: `Matrix-Game-3/generate.py`
- method: Fill `sample_shift` and `sample_guide_scale` from `WAN_CONFIGS["matrix_game3"]`.
- transfer: Let the model config carry sane defaults instead of duplicating them in CLI parsing.

## Skill 64: Randomize Seeds Only When the User Explicitly Requests Non-Determinism
- evidence: `Matrix-Game-3/generate.py`
- method: Keep the provided seed unless it is negative, then sample a fresh one.
- transfer: Determinism should be the default posture for heavy generation jobs.

## Skill 65: Initialize NCCL Only When World Size Exceeds One
- evidence: `Matrix-Game-3/generate.py`
- method: Use plain single-device execution otherwise and assert that FSDP and sequence parallel are not enabled.
- transfer: Separate single-device and distributed code paths sharply to reduce operator confusion.

## Skill 66: Require Ulysses Size to Match World Size
- evidence: `Matrix-Game-3/generate.py`
- method: Assert that sequence-parallel degree equals the distributed world size before enabling Ulysses attention.
- transfer: Parallel attention topology should match the actual process topology exactly.

## Skill 67: Warn When Attention Head Count Does Not Divide Cleanly
- evidence: `Matrix-Game-3/generate.py`
- method: Emit a warning when `num_heads` is not divisible by `ulysses_size` and rely on internal padding plus trimming.
- transfer: When automatic repair is possible, warn loudly but keep the job runnable.

## Skill 68: Broadcast the Final Seed Across Ranks
- evidence: `Matrix-Game-3/generate.py`
- method: Share one seed from rank 0 to all other ranks after distributed setup.
- transfer: Deterministic distributed generation requires seed agreement, not just local seeding.

## Skill 69: Split Interactive and Non-Interactive Runtime Pipelines Explicitly
- evidence: `Matrix-Game-3/generate.py`
- method: Instantiate `MatrixGame3InteractivePipeline` only when `--interactive` is enabled; otherwise use the standard pipeline.
- transfer: Do not overload one class with incompatible operator lifecycles if a clean split exists.

## Skill 70: End Jobs With Explicit Synchronize, Barrier, and Process-Group Teardown
- evidence: `Matrix-Game-3/generate.py`
- method: Synchronize CUDA, barrier the ranks, and destroy the process group after generation.
- transfer: Research distributed inference should clean up like production code when it launches heavy jobs.