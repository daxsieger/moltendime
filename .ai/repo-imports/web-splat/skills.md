# Bundle: web-splat

- source_repo: https://github.com/daxsieger/web-splat
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: mixed
- generated_for_persona: web-splat-optimizer
- tracked_by_persona: ai-rule-learner

## Imported Repository AI Assets

- No explicit AI customization files were detected during import.

## Imported Automation Assets

- .github/workflows/viewer.yml

## First-Level Persona Skills

- The dedicated repository persona is the receptacle for imported repository skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the repository persona as their runtime owner.
- The `web-splat-optimizer` persona owns 50 extracted optimization skills derived from renderer, shader, I/O, wasm, and workflow code.

- No explicit repository skill files were found, so the repository persona relies on extracted optimization skills and inferred repository skills.

## Extracted Optimization Skill Pack

- `skills-index.md`: top-level index for all 50 skills
- `01-pipeline-and-device-skills.md`: GPU device bring-up, limits, formats, latency, and profiling
- `02-preprocess-and-splat-skills.md`: compute preprocessing, culling, covariance, mip splatting, and packing
- `03-sorting-and-dispatch-skills.md`: radix sort, workgroup tuning, bind groups, and indirect dispatch
- `04-data-packing-and-io-skills.md`: compressed asset layout, quantization, covariance build, and metadata ingestion
- `05-runtime-build-and-workflow-skills.md`: release paths, wasm, CI, measurement, UI, and scene/runtime ergonomics

## Inferred Reusable Skills

### 1. Repository bootstrap

- Read the primary README first.
- Development command: cargo run --release --bin viewer point_cloud.ply cameras.json
- Build command: cargo build --release --bin viewer
- Capture additional setup requirements from the listed documentation files.
- Optional compressed-input command: cargo run --release --features npz --bin viewer point_cloud.npz cameras.json
- Optional wasm build command: bash build_wasm.sh

### 2. Technical knowledge extraction

- Convert Rust renderer, WGSL preprocess, radix sort, loader, and wasm build details into transferable optimization skills.
- Treat the code paths in `src/renderer.rs`, `src/gpu_rs.rs`, `src/pointcloud.rs`, `src/io/`, and `src/shaders/` as primary extraction anchors.
- Keep extracted skills short enough to be reused by the dedicated persona.

### 3. Stack and workspace interpretation

- Detected project type: Rust project
- Detected stack tags: rust
- Monorepo/workspace detected: false

### 4. Persona ownership and archival tracking

- The repository-dedicated persona owns the imported and inferred first-level skills for this repository.
- The archivist persona keeps an index of imported AI assets and automation assets for cross-personality discovery and audit.
- The `web-splat-optimizer` persona is the runtime owner of the 50 optimization skills extracted from this repository.

