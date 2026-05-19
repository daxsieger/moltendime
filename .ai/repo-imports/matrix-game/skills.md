# Bundle: matrix-game

- source_repo: https://github.com/daxsieger/Matrix-Game
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: inferred
- generated_for_persona: matrix-game-world-model-architect
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- No repository workflow automation files were detected during import.

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `matrix-game-world-model-architect` persona owns the first-level skills extracted from Matrix-Game-1.0, 2.0, and 3.0.

- No explicit repository skill files were found, so the repository persona relies on inferred first-level skills extracted from repository documentation, pipeline code, condition builders, benchmark surfaces, and distributed runtime entrypoints.

## Version Surfaces

- `Matrix-Game-1`: 17B interactive world foundation model for controllable Minecraft video generation with GameWorld Score and Matrix-Game dataset surfaces
- `Matrix-Game-2`: real-time and streaming interactive world foundation model with scene-specialized inference modes and causal generation pipeline
- `Matrix-Game-3`: real-time and streaming interactive world model with long-horizon memory, distributed runtime controls, and interactive first-person generation in unreal scenes

## Extracted Skill Pack

- `skills-index.md`: top-level index for the 100 extracted Matrix-Game skills
- `01-mg1-world-foundation-and-controls-skills.md`: Matrix-Game-1 framing, control surfaces, dataset posture, and hardware assumptions
- `02-mg1-inference-and-parallelism-skills.md`: Matrix-Game-1 inference orchestration, sequence parallelism, and pipeline shaping
- `03-mg1-gameworld-benchmark-and-dataset-skills.md`: GameWorld benchmark design, evaluation slices, and action-grounded Minecraft measurement
- `04-mg2-causal-streaming-foundation-skills.md`: Matrix-Game-2 causal inference, real-time streaming posture, and mode-driven generation
- `05-mg2-conditioning-and-scene-specialization-skills.md`: Matrix-Game-2 conditioning assembly, scene specialization, and output post-processing
- `06-mg2-runtime-memory-and-wan-skills.md`: Matrix-Game-2 runtime wrappers, VAE paths, scheduler surface, and deployment ergonomics
- `07-mg3-distributed-generation-and-runtime-skills.md`: Matrix-Game-3 generation entrypoint, distributed runtime, and argument-level safety
- `08-mg3-interactive-memory-camera-skills.md`: Matrix-Game-3 long-horizon memory, camera/action handling, and pose-conditioned rollout
- `09-mg3-vae-quantization-and-performance-skills.md`: Matrix-Game-3 async VAE, quantization, Flash Attention, and performance controls
- `10-lineage-procedural-world-and-import-skills.md`: explicit lineage, procedural-world adjacency, and import-strategy skills

## Lineage And Import Planning

- `lineage-and-import-candidates.md` records what the repository states explicitly about derivation and what is only inferred as adjacent world-model or procedural-world lineage.
- `external-bridge-skill.md` is the canonical bridge for external repositories that want to load and adapt Matrix-Game skills.

## Inferred Reusable Skills

### 1. Repository bootstrap

- Read the primary README first.
- Development command: not detected
- Build command: not detected
- Capture additional setup requirements from the listed documentation files.

### 2. Technical knowledge extraction

- Convert the documentation set into concise memory notes and operational summaries.
- Treat package metadata and public source entrypoints as stable anchors for inferred workflows.
- Mark all inferred content explicitly when explicit AI assets are missing.

### 3. Stack and workspace interpretation

- Detected project type: repository with no recognized primary build stack
- Detected stack tags: none
- Monorepo/workspace detected: false

### 4. Persona ownership and archival tracking

- The repository-dedicated persona owns the imported and inferred first-level skills for this repository.
- The archivist persona keeps an index of imported AI assets and automation assets for cross-personality discovery and audit.
