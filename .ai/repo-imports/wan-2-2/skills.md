# Bundle: wan-2-2

- source_repo: https://github.com/Wan-Video/Wan2.2
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: inferred
- generated_for_persona: wan-2-2-video-systems-architect
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- No repository workflow automation files were detected during import.

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `wan-2-2-video-systems-architect` persona owns the first-level multimodal video-generation and deployment skills extracted from Wan2.2.

- No explicit repository skill files were found, so the repository persona relies on inferred first-level skills extracted from the public README, task matrix, deployment guidance, and the repository code paths under `wan/modules`.

## Extracted Skill Pack

- `skills-index.md`: top-level index for the extracted Wan2.2 skill set
- `01-wan-2-2-core-skills.md`: MoE video generation, multimodal task coverage, and deployment posture
- `02-wan-2-2-code-path-skills.md`: argument validation, prompt expansion, model sharding, and TI2V runtime extracted from code
- `03-wan-2-2-backbone-skills.md`: backbone attention, rotary geometry, modulation, and VAE design extracted from `wan/modules`
- `04-wan-2-2-task-specialized-skills.md`: text stack, animate branch, and speech-to-video branch patterns extracted from `wan/modules`

## Family Placement

- `wan-2-2` belongs to the interactive-world-models family tracked in `../interactive-world-models-family.md`.
- Within that family, it is an upstream generative backbone peer rather than a direct gameplay-world-model benchmark.

## Code-Grounded Extraction Surface

- Primary code anchors: `generate.py` and `wan/textimage2video.py`
- These files control task validation, prompt extension, model placement, distributed strategy, and TI2V generation runtime.
- Backbone anchors: `wan/modules/attention.py`, `wan/modules/model.py`, and `wan/modules/vae2_2.py`
- These modules control the internal attention fallback tree, 3-axis rotary structure, transformer modulation, patchified video backbone, and causal VAE design.
- Task-specialized anchors: `wan/modules/t5.py`, `wan/modules/animate/*`, and `wan/modules/s2v/*`
- These modules separate reusable text conditioning from task-specific animation and speech-driven branches.

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

- Detected project type: Python project
- Detected stack tags: python
- Monorepo/workspace detected: false

### 4. Persona ownership and archival tracking

- The repository-dedicated persona owns the imported and inferred first-level skills for this repository.
- The archivist persona keeps an index of imported AI assets and automation assets for cross-personality discovery and audit.
