# WebSplatter Paper Skills 01-10

## Skill 01: Treat Browser Heterogeneity as a First-Class Constraint
- evidence: Abstract, Section 1
- method: Frame the target environment as a heterogeneous execution surface spanning desktop, laptop, and mobile GPUs.
- transfer: Design the system around portability and scheduler variance instead of tuning only for a single high-end GPU.

## Skill 02: Start from the Web Deployment Advantage, Not Just the GPU Gap
- evidence: Section 1
- method: Justify the work through zero-install deployment, accessibility, and cross-platform sharing rather than raw rendering speed alone.
- transfer: Anchor a browser research persona in product-distribution value as well as systems performance.

## Skill 03: Explicitly Contrast Fixed-Function WebGL with Compute-Capable WebGPU
- evidence: Section 1, Section 2.2
- method: Position WebGPU as the enabling API because it adds compute shaders, storage buffers, and finer resource control.
- transfer: When extracting skills from web graphics papers, preserve the API-capability delta that motivates the design.

## Skill 04: Use a Hybrid Compute-Render Pipeline for 3DGS on the Web
- evidence: Figure 1, Section 3.1
- method: Split the pipeline into preprocess, sort, and rasterization stages.
- transfer: Separate view-dependent data preparation from final drawing when the workload mixes compute-heavy and raster-heavy phases.

## Skill 05: Design for Vendor-Neutral Execution Instead of Porting Native Assumptions
- evidence: Section 1, Section 3.3.1
- method: Avoid direct CUDA or Vulkan assumptions that depend on low-level thread interlocks or scheduler guarantees.
- transfer: Rework native algorithms around the web platform's actual execution guarantees rather than forcing a literal port.

## Skill 06: Keep the CPU Out of the Per-Frame Critical Path
- evidence: Section 1, Section 2.2, Section 3.1
- method: Push sorting and shading-related work into GPU compute to avoid CPU-GPU synchronization overheads.
- transfer: Use the paper as evidence that browser renderers benefit strongly from full-GPU frame pipelines.

## Skill 07: State Contributions as Design, Optimization, and Evaluation Separately
- evidence: Section 1
- method: Separate system contribution, cross-platform optimization contribution, and evaluation contribution into explicit bullets.
- transfer: Extract skills more reliably when the paper's claims are decomposed into architecture, algorithm, and evidence layers.

## Skill 08: Treat Deadlock Freedom as a Performance Feature
- evidence: Abstract, Section 1, Section 3.3.1
- method: Make synchronization safety part of the optimization story, not just a correctness footnote.
- transfer: Preserve execution guarantees as reusable skill material when browser backends can differ in scheduling behavior.

## Skill 09: Preserve the Paper's Bottleneck Model in the Persona
- evidence: Section 4.2, Section 4.3
- method: Model the system as shifting between preprocess-bound and render-bound depending on device class and scene size.
- transfer: Teach the persona to reason about bottlenecks per hardware tier instead of assuming one dominant stage.

## Skill 10: Keep Figures and Tables as Evidence Anchors for Skill Extraction
- evidence: Figure 1, Tables 1-5
- method: Treat diagrams and measurement tables as primary extraction inputs alongside prose.
- transfer: Build paper personas from validated artifacts, not from narrative summary alone.
