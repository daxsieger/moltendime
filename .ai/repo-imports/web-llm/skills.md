# Bundle: web-llm

- source_repo: https://github.com/daxsieger/web-llm
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: mixed
- generated_for_persona: web-llm-runtime-architect
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- .github/workflows/build-site.yaml
- .github/workflows/build.yaml
- .github/workflows/linter.yaml
- .github/workflows/security.yaml
- .github/workflows/tests.yaml

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `web-llm-runtime-architect` persona owns the first-level runtime, API-compatibility, worker, and deployment skills extracted from this repository.

- No explicit repository skill files were found, so the repository persona relies on inferred first-level skills extracted from repository code, documentation, and examples.

## Extracted Skill Pack

- `skills-index.md`: top-level index for the extracted WebLLM skill set
- `01-browser-runtime-and-loading-skills.md`: browser-native runtime, model loading, and configuration boundaries
- `02-openai-api-and-generation-control-skills.md`: OpenAI-compatible API, generation controls, JSON mode, and multimodal config
- `03-worker-deployment-and-integration-skills.md`: worker isolation, deployment surfaces, extensions, and example-driven integration
- `04-engine-pipeline-and-runtime-control-skills.md`: code-grounded engine lifecycle, prefill/decode flow, service-worker handling, and runtime telemetry

## Family Placement

- `web-llm` belongs to the browser-AI and WebGPU runtime family tracked in `../browser-ai-webgpu-family.md`.
- This family groups browser-native inference, worker-hosted execution, and WebGPU-backed application runtimes without forcing them into the same application domain.

## External Reuse Bridge

- `external-bridge-skill.md` is the canonical bridge for external repositories that want to load and reuse the `web-llm` bundle.
- External consumers should load the bundle and family note before synthesizing repository-specific browser-AI guidance.

## Inferred Reusable Skills

### 1. Repository bootstrap

- Read the primary README first.
- Development command: not detected
- Build command: rollup -c && ./cleanup-index-js.sh
- Capture additional setup requirements from the listed documentation files.

### 2. Technical knowledge extraction

- Convert the documentation set into concise memory notes and operational summaries.
- Treat package metadata and public source entrypoints as stable anchors for inferred workflows.
- Mark all inferred content explicitly when explicit AI assets are missing.

### 3. Stack and workspace interpretation

- Detected project type: TypeScript Node/Web application or library
- Detected stack tags: node, typescript
- Monorepo/workspace detected: false

### 4. Persona ownership and archival tracking

- The repository-dedicated persona owns the imported and inferred first-level skills for this repository.
- The archivist persona keeps an index of imported AI assets and automation assets for cross-personality discovery and audit.
