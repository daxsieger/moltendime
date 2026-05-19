# matrix-game Skills 01-10

## Skill 01: Frame Matrix-Game-1 as an Image-to-World Model
- evidence: `Matrix-Game-1/README.md`
- method: Present the system as a diffusion-based image-to-world model instead of a generic video generator.
- transfer: When the output is an explorable game-like rollout, define the model around world evolution rather than plain video synthesis.

## Skill 02: Treat Keyboard and Mouse as First-Class Conditions
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/condtions.py`
- method: Build the generation contract around both keyboard and mouse actions for fine-grained controllability.
- transfer: World models need input channels that map to actual player control semantics, not only text prompts.

## Skill 03: Use Minecraft as a Physically Grounded World Surface
- evidence: `Matrix-Game-1/README.md`
- method: Anchor the first release in Minecraft so action alignment and rule plausibility can be evaluated in a structured environment.
- transfer: Start with a world that has clear rules and rich player traces before generalizing to broader environments.

## Skill 04: Pair Model Release With a Dedicated Dataset Story
- evidence: `Matrix-Game-1/README.md`
- method: Release the world model together with a named dataset posture that emphasizes fine-grained action annotations.
- transfer: Action-conditioned world generation is easier to scale when the data narrative is explicit from day one.

## Skill 05: Pair Model Release With a Dedicated Benchmark Story
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/GameWorldScore/README.md`
- method: Release a benchmark next to the model so quality, controllability, and physical plausibility can be discussed in one frame.
- transfer: If a model claims interactive control, ship the measurement surface with it.

## Skill 06: Track Action Accuracy Separately for Keyboard and Mouse
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/GameWorldScore/README.md`
- method: Split controllability metrics into keyboard and mouse accuracy instead of compressing both into one score.
- transfer: Separate discrete movement intent from camera-control fidelity when evaluating game-world generation.

## Skill 07: Keep Object Consistency Separate From Scenario Consistency
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/GameWorldScore/README.md`
- method: Evaluate local object stability and global scenario continuity as different failure modes.
- transfer: World models break at both geometry and scene-story levels; do not collapse them into one temporal metric.

## Skill 08: Publish Hardware Reality Early
- evidence: `Matrix-Game-1/README.md`
- method: State that single 65-frame inference expects A100 or H100 class hardware with at least 80 GB VRAM.
- transfer: World-model releases need blunt runtime disclosures so downstream users do not confuse research code with commodity deployment.

## Skill 09: Build on a Strong Video Base but Recast It Around Interactive Worlds
- evidence: `Matrix-Game-1/README.md`, `Matrix-Game-1/NOTICE`
- method: Acknowledge HunyuanVideo and Diffusers as foundations, then adapt them around world control and action conditioning.
- transfer: Treat base video models as substrate, not as the final problem framing.

## Skill 10: Explicitly Import Action-Control Ideas From Adjacent World-Model Work
- evidence: `Matrix-Game-1/README.md`
- method: Credit GameFactory for the action control module idea instead of pretending the control formulation emerged in isolation.
- transfer: Interactive world-model progress often comes from recombining control, video, and benchmark ideas across projects.