# Bundle: mineworld

- source_repo: https://github.com/microsoft/mineworld
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: inferred
- generated_for_persona: mineworld-minecraft-world-modeler
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- No repository workflow automation files were detected during import.

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `mineworld-minecraft-world-modeler` persona owns the first-level Minecraft world-model and diagonal-decoding skills extracted from MineWorld.

- No explicit repository skill files were found, so the repository persona relies on inferred first-level skills extracted from the public README, inference surface, and metrics workflow.

## Extracted Skill Pack

- `skills-index.md`: top-level index for the extracted MineWorld skill set
- `01-mineworld-core-skills.md`: autoregressive Minecraft world modeling, diagonal decoding, and evaluation workflow

## Family Placement

- `mineworld` belongs to the interactive-world-models family tracked in `../interactive-world-models-family.md`.
- Within that family, it is the Minecraft-centric autoregressive benchmark peer to Matrix-Game.

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
