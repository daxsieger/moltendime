# Bundle: wan-move-arxiv-2512-08765

- source_paper: https://huggingface.co/papers/2512.08765
- source_html: https://arxiv.org/html/2512.08765v1
- title: Wan-Move: Motion-controllable Video Generation via Latent Trajectory Guidance
- generated_for_persona: wan-move-paper-learner
- tracked_by_persona: ai-rule-learner
- bundle_type: academic-paper

## Imported Research Assets

- https://huggingface.co/papers/2512.08765
- https://arxiv.org/abs/2512.08765
- https://arxiv.org/html/2512.08765v1

## First-Level Persona Skills

- The dedicated paper persona is the receptacle for paper-specific first-level research skills.
- System personas such as `ai-rule-learner` should index and track these skills, not replace the paper persona as their runtime owner.
- The `wan-move-paper-learner` persona owns 50 extracted skills derived from the paper's motion guidance design, training strategy, MoveBench benchmark, and evaluation results.

## Extracted Skill Pack

- `skills-index.md`: top-level index for all 50 extracted skills
- `01-motion-framing-and-guidance-skills.md`: motion-control framing, guidance representations, and architecture-preserving integration
- `02-latent-trajectory-guidance-skills.md`: latent-space mapping, feature replication, and trajectory overlap handling
- `03-training-data-and-scaling-skills.md`: data filtering, track sampling, flow matching, and distributed scaling
- `04-movebench-and-evaluation-skills.md`: benchmark construction, annotation design, and metric selection
- `05-applications-ablation-and-failure-skills.md`: latency tradeoffs, stress tests, applications, and failure taxonomy

## Inferred Reusable Skills

### 1. Academic import workflow

- Read abstract, methods, evaluation, ablations, and appendices before extracting skills.
- Keep claims, mechanisms, and implementation-transfer lessons in separate sections.
- Use the paper-dedicated persona as the runtime owner of the extracted skills.

### 2. Research-to-engineering transfer

- Convert latent guidance, data curation, and benchmark design into separate reusable skills instead of merging them into one summary.
- Preserve table-level numeric evidence for motion quality, fidelity, latency, and generalization.
- Mark inferred implementation guidance clearly when it extends beyond explicit paper text.

### 3. Archivist tracking

- The archivist persona should catalog the paper persona, paper bundle, and loader skill.
- The archivist should not absorb the paper-specific first-level skills into itself.
