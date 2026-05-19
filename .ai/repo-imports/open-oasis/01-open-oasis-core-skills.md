# open-oasis Skills 01-05

## Skill 01: Treat Oasis 500M as a Public Inference Slice
- evidence: `README.md`
- method: Frame the repository as the public 500M inference release rather than the full strongest Oasis deployment.
- transfer: Some repos are best treated as public evaluation slices of a larger system.

## Skill 02: Use Keyboard Input as the Main Control Channel
- evidence: `README.md`
- method: Condition gameplay generation directly on user keyboard input.
- transfer: Lightweight world-model demos can still preserve real player control semantics.

## Skill 03: Combine Diffusion Transformers With Autoregressive Rollout
- evidence: `README.md`
- method: Use diffusion transformers while generating frames autoregressively over time.
- transfer: Hybrid diffusion-plus-autoregressive framing is a recurring world-model pattern worth reusing.

## Skill 04: Support Prompt Frames From Video or Custom Images
- evidence: `README.md`
- method: Allow the run to start from a prompt frame extracted from video or from a user-provided image.
- transfer: Flexible prompt-state bootstrapping increases the range of evaluable initial conditions.

## Skill 05: Keep the Public Interface Extremely Narrow
- evidence: `README.md`
- method: Center the release around one generation script, two checkpoints, and a single output video artifact.
- transfer: Small public inference repos benefit from very narrow operational surfaces.