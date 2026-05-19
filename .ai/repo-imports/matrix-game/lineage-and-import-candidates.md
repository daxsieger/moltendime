# Matrix-Game Lineage And Import Candidates

## Scope

This note separates what the Matrix-Game repository states explicitly about its lineage from what is only inferred as adjacent work in interactive world modeling, procedural world generation, and terrain-like environment synthesis.

## Explicit Lineage In The Repository

### Matrix-Game-1

- Diffusers: explicit code derivation in `Matrix-Game-1/NOTICE`
- HunyuanVideo: explicit code derivation in `Matrix-Game-1/NOTICE` and base-model acknowledgement in `Matrix-Game-1/README.md`
- Open-Sora-Plan: explicit code derivation in `Matrix-Game-1/NOTICE`
- MineDojo: acknowledged as Minecraft video-data source in `Matrix-Game-1/README.md`
- MineRL: acknowledged as game-environment framework in `Matrix-Game-1/README.md`
- Video-Pre-Training: acknowledged as inverse-dynamics source in `Matrix-Game-1/README.md`
- GameFactory: acknowledged as the source of the action-control-module idea in `Matrix-Game-1/README.md`

### Matrix-Game-2

- SkyReels-V2: acknowledged as the strong base model in `Matrix-Game-2/README.md`
- Self-Forcing: acknowledged in `Matrix-Game-2/README.md`
- GameFactory: action-control-module acknowledgement continues in `Matrix-Game-2/README.md`
- MineRL: acknowledged again in `Matrix-Game-2/README.md`
- Video-Pre-Training: acknowledged again in `Matrix-Game-2/README.md`
- Matrix-3D: linked as a related project for explorable 3D scene creation in `Matrix-Game-2/README.md`

### Matrix-Game-3

- Wan2.2: acknowledged as the strong base model in `Matrix-Game-3/README.md`
- lingbot-world: explicit provenance note in `Matrix-Game-3/wan/distributed/*`
- LightX2V: explicit provenance note in `Matrix-Game-3/wan/triton_kernels.py`

## Inferred But Not Explicitly Claimed As Derivation

- Oasis: benchmark peer in `Matrix-Game-1/README.md` and `GameWorldScore/README.md`
- MineWorld: benchmark peer in `Matrix-Game-1/README.md` and `GameWorldScore/README.md`
- Procedural terrain engines in the classical sense are not explicitly cited.
- Matrix-Game clearly overlaps with procedural world generation, but the repo frames itself as an interactive world-model system, not as a terrain-engine repository.

## What This Means For Procedural World And Terrain Lineage

- The strongest evidence-backed roots are world-model video backbones, action-conditioned control modules, Minecraft data ecosystems, and inverse-dynamics systems.
- The repo does not explicitly say it descends from classic terrain-synthesis projects such as voxel terrain engines or standalone procedural-noise toolkits.
- A safe interpretation is that Matrix-Game sits at the intersection of world models, game-interaction conditioning, and environment-grounded generative video, with procedural-world adjacency rather than explicit terrain-engine descent.

## Recommended Projects To Import Next

### Highest Priority

- `SkyworkAI/Matrix-3D`: direct adjacent project for explorable large-scale 3D scenes
- `KwaiVGI/GameFactory`: explicit action-control inspiration
- `SkyworkAI/SkyReels-V2`: explicit Matrix-Game-2 base-model lineage
- `Wan-Video/Wan2.2`: explicit Matrix-Game-3 base-model lineage
- `Tencent/HunyuanVideo`: explicit Matrix-Game-1 base-model lineage

### Strong World-Model And Benchmark Adjacency

- `PKU-YuanGroup/Open-Sora-Plan`: explicit Matrix-Game-1 code lineage
- `huggingface/diffusers`: explicit Matrix-Game-1 code lineage and pipeline substrate
- `minerllabs/minerl`: world-surface and control-data adjacency
- `openai/Video-Pre-Training`: inverse-dynamics and action-recovery adjacency
- `MineDojo`: Minecraft-world data adjacency

### Good Candidate Imports For Procedural World / Terrain Context

- `etched-ai/open-oasis`: confirmed public Oasis 500M inference repository; benchmark-adjacent world-model peer
- `microsoft/mineworld`: confirmed public MineWorld repository; benchmark-adjacent world-model peer
- `SkyworkAI/Matrix-3D`: best explicit bridge from world-model video to explorable scene construction
- a high-quality voxel or terrain-oriented Minecraft generation project once identified: useful to complement Matrix-Game with classic procedural-world mechanics the repo itself does not own

## Import Order Recommendation

1. `Matrix-3D`
2. `GameFactory`
3. `Wan2.2`
4. `HunyuanVideo`
5. `SkyReels-V2`
6. `Open-Sora-Plan`
7. `MineDojo`
8. `MineRL`
9. `Video-Pre-Training`
10. `etched-ai/open-oasis`
11. `microsoft/mineworld`