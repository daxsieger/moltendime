# Comparative Taxonomy For Paper Personas

## Scope

This taxonomy compares currently imported university-paper personas so the archivist can index reusable patterns without taking ownership of the first-level paper skills.

## Imported Papers

- `websplatter-arxiv-2602-03207`: WebGPU Gaussian splatting systems paper
- `wan-move-arxiv-2512-08765`: motion-controllable image-to-video generation paper

## Taxonomy Axes

### 1. Primary Research Surface

- WebSplatter: browser GPU systems, scheduling safety, rendering throughput, memory footprint
- Wan-Move: controllable video generation, latent conditioning, training scalability, benchmark design

### 2. Core Constraint Style

- WebSplatter: heterogeneous hardware and WebGPU scheduling semantics
- Wan-Move: fine-grained motion control without auxiliary motion modules

### 3. Main Reuse Pattern

- WebSplatter: extract optimization primitives from method plus evaluation
- Wan-Move: extract control, data, benchmark, and failure-analysis primitives from method plus evaluation

### 4. Dominant Skill Families

- WebSplatter: compute-render decomposition, wait-free sort, opacity-aware culling, browser benchmarking
- Wan-Move: latent trajectory guidance, scalable fine-tuning, benchmark construction, motion stress testing

### 5. Evaluation Signature

- WebSplatter: cross-device frame time, bottleneck shifts, ablation, VRAM efficiency, crash avoidance
- Wan-Move: fidelity metrics, motion EPE, human preference studies, latency tradeoffs, OOD motion stress tests

### 6. Persona Ownership Rule

- Both: first-level skills belong to the dedicated paper persona
- Both: the archivist catalogs persona, bundle, and automation assets only

## Reusable Meta-Skills For Future University Papers

- Distinguish method skills from benchmark skills instead of collapsing them into one summary.
- Extract explicit failure cases and limitations as persona knowledge, not only success patterns.
- Preserve table-level numbers when they drive prioritization decisions.
- Keep supplementary implementation details in scope when they materially affect transferability.
- Let archivist personas track bundle provenance, comparability, and discovery across papers.
