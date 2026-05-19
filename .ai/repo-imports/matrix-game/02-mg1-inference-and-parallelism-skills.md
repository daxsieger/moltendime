# matrix-game Skills 11-20

## Skill 11: Normalize Precision Flags Through a Small Type Mapper
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Convert short runtime strings such as `bf16` and `fp16` into concrete torch dtypes in one helper.
- transfer: Put dtype policy in one place when inference scripts expose precision as CLI state.

## Skill 12: Use Explicit Alignment Helpers Around Video Geometry
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Round tensor dimensions up to an alignment boundary before pipeline work proceeds.
- transfer: Video diffusion code benefits from tiny geometry helpers that make downstream partitioning less brittle.

## Skill 13: Split Sequence Parallelism Along Whatever Spatial Axis Divides Cleanly
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Decide dynamically whether to shard hidden states along height or width depending on which dimension divides evenly.
- transfer: Parallel video inference should adapt to tensor shape instead of hardcoding one split dimension.

## Skill 14: Shard Rotary Frequencies With the Same Layout Logic as Hidden States
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Reshape and chunk `freqs_cos` and `freqs_sin` consistently with the hidden-state partition.
- transfer: Any positional representation used in partitioned attention must follow the same slicing contract as activations.

## Skill 15: Inject Long-Context Attention at the Transformer Block Level
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Patch each double and single block with `xFuserLongContextAttention` when sequence parallelism is enabled.
- transfer: If long-context support is optional, install it as a block-level runtime adaptation rather than forking the entire model class.

## Skill 16: Gather Partitioned Samples Only After the Forward Pass
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Let each partition compute locally and all-gather the final sample tensor afterward.
- transfer: Keep parallel attention local during compute and synchronize only the artifact that must be globally visible.

## Skill 17: Gate Distributed Initialization on Explicit Ulysses and Ring Degrees
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Assert that world size equals `ring_degree * ulysses_degree` before distributed model parallel setup.
- transfer: Express multi-axis parallelism as an explicit runtime contract, not as an implicit cluster assumption.

## Skill 18: Keep Model, VAE, and Text Encoder Initialization Distinct
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Load DiT, VAE, and text encoder separately and assign offload policy per component.
- transfer: World-model inference benefits from modular initialization because the memory profile of each component differs.

## Skill 19: Allow CPU Offload for the VAE Without Redesigning the Whole Pipeline
- evidence: `Matrix-Game-1/parallel_infer.py`
- method: Move the VAE to CPU when requested while keeping the rest of the stack on device.
- transfer: Offload the component with the best latency tolerance before attempting broader system rewrites.

## Skill 20: Build the Video Pipeline Around a Dedicated Flow-Matching Scheduler
- evidence: `Matrix-Game-1/parallel_infer.py`, `Matrix-Game-1/matrixgame/sample/pipeline_matrixgame.py`
- method: Make the pipeline entrypoint explicit about flow matching and video-specific scheduling.
- transfer: Name the scheduler choice in the inference surface when it materially shapes generation behavior.