# matrix-3d Skills 11-15

## Skill 11: Require Recursive Clone for Dependency-Heavy Scene Repos
- evidence: `README.md`
- method: Instruct users to clone the repository with `--recursive` from the start.
- transfer: Repos with nested dependencies should state their clone contract explicitly before installation begins.

## Skill 12: Bundle Runtime Setup Behind an Install Script
- evidence: `README.md`
- method: Use `install.sh` as the main installation step after environment preparation.
- transfer: Scripted setup reduces drift when scene-generation repos depend on mixed native and Python components.

## Skill 13: Publish a Gradio Demo Early
- evidence: `README.md`
- method: Ship a Gradio demo as part of the public release to lower the barrier to interactive inspection.
- transfer: Demos help evaluate scene controllability and visual plausibility faster than raw scripts alone.

## Skill 14: State the Tested Runtime Envelope Clearly
- evidence: `README.md`
- method: Document Linux plus NVIDIA GPU as the tested environment.
- transfer: Scene-generation repos should state hardware expectations directly when the runtime is demanding.

## Skill 15: Link Matrix-Game as the Adjacent Interactive Long-Sequence Sibling
- evidence: `README.md`
- method: Point users to Matrix-Game-2.0 when they need real-time interactive long-sequence world models rather than explorable panoramic scenes.
- transfer: Related-project links are a clean way to separate sibling products by operational focus.