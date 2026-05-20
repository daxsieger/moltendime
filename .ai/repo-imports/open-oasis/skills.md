# Bundle: open-oasis

- source_repo: https://github.com/etched-ai/open-oasis
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: inferred
- generated_for_persona: open-oasis-world-modeler
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- No repository workflow automation files were detected during import.

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `open-oasis-world-modeler` persona owns the first-level action-conditional inference skills extracted from the public Oasis 500M repository.

- No explicit repository skill files were found, so the repository persona relies on inferred first-level skills extracted from the public README and inference surface.

## Extracted Skill Pack

- `skills-index.md`: top-level index for the extracted Open Oasis skill set
- `01-open-oasis-core-skills.md`: public 500M inference, action conditioning, and prompt-frame generation
- `02-open-oasis-code-path-skills.md`: checkpoint loading, latent rollout, prompt normalization, and action tensor shaping extracted from code

## Family Placement

- `open-oasis` belongs to the interactive-world-models family tracked in `../interactive-world-models-family.md`.
- Within that family, it is the lightweight public inference release for Oasis rather than a full large repository stack.

## Code-Grounded Extraction Surface

- Primary code anchors: `generate.py`, `utils.py`, and `dit.py`
- These files control checkpoint loading, prompt and action normalization, the latent diffusion-forcing rollout, and the transformer-side timestep conditioning surface.

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
