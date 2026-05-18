# WebSplatter Paper Skills 41-50

## Skill 41: Benchmark Across Device Classes, Not Just GPU Tiers
- evidence: Section 4.1
- method: Evaluate on desktops, laptops, and mobile devices spanning high-end, integrated, Apple Silicon, and smartphone GPUs.
- transfer: Build research personas that preserve the deployment diversity used by the paper's own evaluation.

## Skill 42: Compare Against De Facto Open-Source Baselines When Formal Baselines Are Missing
- evidence: Section 4.1, Appendix B
- method: Select widely used community viewers as practical state-of-the-art baselines.
- transfer: Do not block evaluation extraction just because the subfield lacks canonical published baselines.

## Skill 43: Measure Median Total Frame Time Across Pipeline Stages
- evidence: Table 1, Table 2, Table 3
- method: Report total frame time and stage breakdown instead of only FPS.
- transfer: Preserve stage-level timings so future personas can reason about bottlenecks, not just headline speed.

## Skill 44: Preserve Latency Stability, Not Only Average Performance
- evidence: Section 4.2
- method: Include standard deviation and P99 latency to show that wait-free sorting reduces micro-stutter.
- transfer: Treat variance reduction as evidence-backed value for interactive systems research.

## Skill 45: Treat Browser Bugs and Blocklists as Evaluation Results
- evidence: Section 4.2
- method: Record Firefox instability, timestamp-query anomalies, and WebGPU blocklist behavior as part of the findings.
- transfer: Keep platform quirks in the persona because web deployment quality depends on them.

## Skill 46: Use Bottleneck Shifts to Prioritize Device-Specific Work
- evidence: Table 2, Section 4.2, Section 4.3
- method: Distinguish render-bound devices from preprocess-bound devices and explain why the dominant cost moves.
- transfer: Drive optimization planning from workload-stage proportions rather than generic advice.

## Skill 47: Use Ablation to Separate Culling Benefits from Radius-Bounding Benefits
- evidence: Table 5, Section 4.4
- method: Disable `-CULL` and `-RADIUS` independently to isolate which optimization pays off where.
- transfer: Extract optimization skills from deltas, not only from the full system description.

## Skill 48: Treat Peak Memory Footprint as a Compatibility Metric
- evidence: Section 4.5
- method: Measure VRAM usage and connect lower footprint to crash avoidance on constrained hardware.
- transfer: Teach browser-rendering personas that memory efficiency is part of portability, not only of raw performance.

## Skill 49: Preserve Visual Correctness Checks Alongside Performance Gains
- evidence: Figure 3
- method: Compare rendered output against the native CUDA reference to verify fidelity.
- transfer: Keep correctness checks adjacent to optimization claims so the persona does not overfit to speed alone.

## Skill 50: Convert Research Papers into Persona-Owned Skill Packs with Archivist Indexing
- evidence: user workflow requirement, bundle ownership model
- method: Turn validated methods and results into first-level skills owned by a dedicated paper persona while the archivist catalogs the persona, bundle, and loader assets.
- transfer: Reuse this pattern for future university papers so research knowledge stays attributable, queryable, and operationally distinct from the archivist.
