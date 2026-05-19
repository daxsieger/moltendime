# matrix-game Skills 21-30

## Skill 21: Benchmark World Models Across Four Distinct Evaluation Dimensions
- evidence: `Matrix-Game-1/GameWorldScore/README.md`
- method: Measure visual quality, temporal quality, action controllability, and physical rule understanding together.
- transfer: Interactive world-model evaluation needs more axes than standard text-to-video benchmarks.

## Skill 22: Use Mirror Actions for Scenario Consistency Tests
- evidence: `Matrix-Game-1/GameWorldScore/README.md`
- method: Generate videos from the same initial images under mirrored actions to stress-test scenario retention.
- transfer: Control-sensitive evaluation should include paired trajectories that are symmetric but behaviorally distinct.

## Skill 23: Reuse VBench-Style Perceptual Dimensions Without Reusing Its Whole Problem Frame
- evidence: `Matrix-Game-1/GameWorldScore/README.md`
- method: Borrow perceptual evaluation structure where useful while extending it for action grounding and physical plausibility.
- transfer: Extend strong benchmarks; do not restart benchmark design from zero unless the old frame fundamentally fails.

## Skill 24: Reuse VPT for Inverse Dynamics Rather Than Re-Learning Actions Blindly
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/GameWorldScore/README.md`
- method: Credit and integrate Video-Pre-Training style inverse dynamics as part of action understanding.
- transfer: Action-grounded world models should lean on proven inverse dynamics machinery when possible.

## Skill 25: Separate Global Evaluation From Per-Action Evaluation
- evidence: `Matrix-Game-1/GameWorldScore/evaluate.py`, `Matrix-Game-1/GameWorldScore/evaluate_per_action.py`
- method: Keep overall scores and action-specific analyses as separate scripts.
- transfer: Aggregate benchmarks hide control failure pockets; preserve the action-level slice.

## Skill 26: Separate Global Evaluation From Per-Scene Evaluation
- evidence: `Matrix-Game-1/GameWorldScore/evaluate.py`, `Matrix-Game-1/GameWorldScore/evaluate_per_scene.py`
- method: Evaluate by scene as well as overall so environment-dependent brittleness remains visible.
- transfer: World models often overfit scene regime; scene-sliced metrics expose that quickly.

## Skill 27: Use Static Filtering Before Expensive Benchmark Runs
- evidence: `Matrix-Game-1/GameWorldScore/GameWorld/cli/static_filter.py`
- method: Filter clips for temporal flickering and related issues before deeper metric passes.
- transfer: Put cheap quality gates before heavy evaluation pipelines to save time and compute.

## Skill 28: Keep the IDM Stack Vendored Inside the Benchmark When It Is Semantically Core
- evidence: `Matrix-Game-1/GameWorldScore/GameWorld/third_party/IDM`
- method: Vendor the inverse-dynamics stack because action prediction is part of the benchmark contract, not just tooling.
- transfer: Some third-party components are infrastructure; others are part of the measurement definition itself.

## Skill 29: Use DROID-SLAM and Related Geometry Tooling Where Physical Plausibility Matters
- evidence: `Matrix-Game-1/GameWorldScore/GameWorld/third_party/DROID-SLAM`
- method: Pull in geometry-aware tooling when the benchmark claims to say something about physical world consistency.
- transfer: Physical-rule evaluation often needs geometry cues that pure video metrics cannot supply.

## Skill 30: Make Benchmark Reuse and Provenance Explicit
- evidence: `Matrix-Game-1/GameWorldScore/README.md`, `Matrix-Game-1/NOTICE`
- method: State what parts are based on VBench, VPT, Diffusers, HunyuanVideo, and Open-Sora-Plan.
- transfer: Provenance matters more, not less, when a benchmark becomes part of a model release story.