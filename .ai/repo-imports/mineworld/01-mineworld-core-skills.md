# mineworld Skills 01-05

## Skill 01: Use a Visual-Action Autoregressive Transformer for Minecraft
- evidence: `README.md`
- method: Build the world model around an autoregressive transformer conditioned on both visual state and action state.
- transfer: Minecraft world models benefit from explicit dual conditioning on state and player action.

## Skill 02: Treat Diagonal Decoding as the Main Inference Acceleration Lever
- evidence: `README.md`
- method: Offer diagonal decoding as the core acceleration algorithm and compare it directly with naive autoregressive decoding.
- transfer: Public world-model repos should highlight the exact decoding trick that changes runtime behavior most.

## Skill 03: Split Web Demo and Local Evaluation Workflows
- evidence: `README.md`
- method: Maintain one path for interactive demo play and another for reproducible local evaluation runs.
- transfer: Human-facing interaction and paper-grade evaluation should remain separate operating modes.

## Skill 04: Use Reference Frame Count as a Quality Control Knob
- evidence: `README.md`
- method: Let users choose a reference frame index above 4 and below context length, with higher values usually improving quality.
- transfer: Context anchoring is a practical quality lever in autoregressive world-model demos.

## Skill 05: Keep Metrics Reproduction as a Scripted Post-Inference Stage
- evidence: `README.md`
- method: Reproduce results through dedicated metric setup and compute scripts after generating video batches.
- transfer: Benchmark peers become more reusable when their metric path is part of the public repo contract.