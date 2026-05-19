# matrix-game Skills 81-90

## Skill 81: Expose Async VAE as an Operator-Level Switch
- evidence: `Matrix-Game-3/generate.py`
- method: Let users enable asynchronous VAE decoding with a dedicated CLI flag.
- transfer: Hot-path decode optimizations should be visible at the command surface when they materially change latency.

## Skill 82: Warm Up Async VAE With Forced Synchronous Iterations
- evidence: `Matrix-Game-3/generate.py`
- method: Support `async_vae_warmup_iters` so the runtime can stabilize before full async behavior.
- transfer: Hybrid warmup phases are useful when the fast path is not the safest cold-start path.

## Skill 83: Offer Compile-Time Optimization Specifically for the VAE Decoder
- evidence: `Matrix-Game-3/generate.py`
- method: Provide a dedicated `--compile_vae` flag rather than burying compilation behind generic optimization code.
- transfer: Isolate the compile knob to the component most likely to benefit.

## Skill 84: Treat LightVAE Pruning Rate as a Deployment Parameter
- evidence: `Matrix-Game-3/generate.py`
- method: Expose `lightvae_pruning_rate` and let it be inferred from the checkpoint when unset.
- transfer: Model compression settings should be first-class deployment controls, not hidden constants.

## Skill 85: Support Multiple VAE Families Under One Entry Script
- evidence: `Matrix-Game-3/generate.py`
- method: Allow `wan`, `mg_lightvae`, and `mg_lightvae_v2` as `vae_type` choices.
- transfer: Keep codec experimentation in one runtime surface when the surrounding pipeline is stable.

## Skill 86: Treat Int8 Quantization as Optional and Verifiable
- evidence: `Matrix-Game-3/generate.py`
- method: Offer `--use_int8` and a separate `--verify_quant` path for BF16 comparison.
- transfer: Quantization rollout should include an explicit correctness check mode.

## Skill 87: Surface Flash Attention Version as a Runtime Choice
- evidence: `Matrix-Game-3/generate.py`
- method: Accept `fa_version` values `0`, `2`, or `3` instead of hardwiring one kernel strategy.
- transfer: Fast attention backends evolve quickly; expose version choice where reproducibility matters.

## Skill 88: Preserve Base-Model Inference as a Supported Operating Mode
- evidence: `Matrix-Game-3/README.md`, `Matrix-Game-3/generate.py`
- method: Keep `--use_base_model` as a distinct pathway and document its recommended inference-step count.
- transfer: Fine-tuned and base-model paths should stay comparable when release users need baselines.

## Skill 89: Vendor Distributed Helpers With Their Provenance Intact
- evidence: `Matrix-Game-3/wan/distributed/*`
- method: Keep the notices that parts of the distributed stack are derived from `lingbot-world`.
- transfer: Performance-critical distributed code often travels across projects; keep lineage visible.

## Skill 90: Vendor Specialized Triton Kernels With Their Provenance Intact
- evidence: `Matrix-Game-3/wan/triton_kernels.py`
- method: Keep the note that portions are derived from `LightX2V`.
- transfer: Kernel-level optimizations should carry provenance because they are usually highly borrowed and highly consequential.