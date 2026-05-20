# wan-2-2 Skills 06-10

## Skill 06: Centralize Task Validation Before Any Generation Starts
- evidence: `generate.py`
- method: Validate task name, checkpoint directory, prompt defaults, per-task assets, supported sizes, and default sampler values through one `_validate_args` gate.
- transfer: Large multimodal generation repos stay operable when task-specific constraints are normalized before model construction.

## Skill 07: Treat Prompt Expansion as a First-Class Optional Inference Stage
- evidence: `generate.py`
- method: Expose prompt extension through one flag set and allow either DashScope or local Qwen expansion without changing the main generation entrypoint.
- transfer: Prompt enrichment becomes much easier to operationalize when it is wired into the base CLI rather than a parallel script.

## Skill 08: Let Placement Strategy Decide Whether Initialization Stays on CPU
- evidence: `wan/textimage2video.py`
- method: Disable CPU-first initialization whenever FSDP, distributed sharding, or sequence parallelism is enabled, and route placement through one shared configuration path.
- transfer: Large video backbones need explicit device-placement policy instead of ad hoc memory workarounds.

## Skill 09: Build the TI2V Stack From Three Explicit Components
- evidence: `wan/textimage2video.py`
- method: Construct TI2V from a text encoder, a dedicated Wan2.2 VAE, and a Wan model, then configure the transformer for sharding or dtype conversion as needed.
- transfer: Multimodal video runtimes stay easier to optimize when encoder, VAE, and generative backbone are assembled as named pieces.

## Skill 10: Patch Distributed Attention Behavior at Module Level Instead of Forking the Whole Runtime
- evidence: `wan/textimage2video.py`
- method: Replace attention forward methods and the model forward method directly when sequence parallel mode is enabled.
- transfer: Controlled method patching can integrate distributed inference strategies without duplicating the main model implementation.