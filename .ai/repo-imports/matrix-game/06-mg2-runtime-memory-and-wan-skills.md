# matrix-game Skills 51-60

## Skill 51: Wrap the Diffusion Backbone Behind a Versioned Adapter
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/utils/wan_wrapper.py`
- method: Hide the underlying generator behind `WanDiffusionWrapper` rather than exposing raw model internals to the entry script.
- transfer: Use adapters when a release rides on top of a fast-moving base model family.

## Skill 52: Declare Causality at Wrapper Construction Time
- evidence: `Matrix-Game-2/inference.py`
- method: Construct `WanDiffusionWrapper(..., is_causal=True)` so the runtime contract is explicit from startup.
- transfer: Push core temporal assumptions into object construction rather than scattered flags later in the call chain.

## Skill 53: Load Only the Decoder-Relevant Slice From a Shared VAE Checkpoint
- evidence: `Matrix-Game-2/inference.py`
- method: Filter checkpoint keys to `decoder.` and `conv2` when populating the fast decoder wrapper.
- transfer: Partial checkpoint loading is a practical way to slim runtime components without forking upstream weights.

## Skill 54: Keep a Fast Decoder and a Full VAE Wrapper Side by Side
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/demo_utils/vae_block3.py`, `Matrix-Game-2/wan/vae`
- method: Use a lightweight decoder for rollout speed while retaining a fuller VAE wrapper for encoding support.
- transfer: Split encode and decode responsibilities if their performance needs differ.

## Skill 55: Compile the Runtime Decoder Aggressively
- evidence: `Matrix-Game-2/inference.py`
- method: Call `compile(mode="max-autotune-no-cudagraphs")` on the decoder path.
- transfer: If the decode path is hot and stable, compile it as a standalone optimization target.

## Skill 56: Load Fine-Tuned Weights Into the Generator Only
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/inference_streaming.py`
- method: Use `load_file()` and apply the resulting state dict to `pipeline.generator`.
- transfer: Keep fine-tuning deltas scoped to the component that actually changes.

## Skill 57: Separate Pipeline Objects for Batch and Streaming Lifecycles
- evidence: `Matrix-Game-2/inference.py`, `Matrix-Game-2/inference_streaming.py`, `Matrix-Game-2/pipeline/causal_inference.py`
- method: Instantiate `CausalInferencePipeline` for ordinary inference and `CausalInferenceStreamingPipeline` for ongoing interaction.
- transfer: Runtime lifetime is a design axis, not just a boolean option.

## Skill 58: Keep Streaming Sessions Open-Ended Until the Operator Provides the World Seed
- evidence: `Matrix-Game-2/inference_streaming.py`
- method: Prompt repeatedly for an image path until a valid starting image is supplied.
- transfer: Interactive world models need resilient input acquisition rather than one-shot CLI assumptions.

## Skill 59: Reserve Dedicated Demo Utilities for Performance Plumbing
- evidence: `Matrix-Game-2/demo_utils`
- method: Isolate decoder, TensorRT, constants, and memory helpers under `demo_utils` instead of mixing them with the generation API.
- transfer: Demo-time acceleration and memory plumbing deserve their own namespace.

## Skill 60: Keep WAN-Specific Modules Nested Under a Versioned Subtree
- evidence: `Matrix-Game-2/wan`
- method: Vendor the WAN-specific configs, modules, utils, and VAE components under an explicit `wan` subtree.
- transfer: When a repository adapts a base model family heavily, keep that lineage visible in the directory layout.