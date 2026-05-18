# WebSplatter Paper Technical Notes

## Summary

The WebSplatter paper presents a browser-oriented 3D Gaussian Splatting system that rethinks the renderer around WebGPU's actual guarantees instead of porting native GPU assumptions directly. Its main technical story is the combination of a hybrid compute-render pipeline, a wait-free hierarchical radix sort, and opacity-aware geometry reduction for better cross-device behavior.

## Architecture Summary

- The pipeline is split into preprocess, sort, and rasterization stages.
- The preprocess stage transforms raw 3D gaussians into compact 2D screen-space primitives, computes depth, evaluates view-dependent color, and packs derived data aggressively.
- The sort stage uses a wait-free hierarchical Blelloch scan to avoid inter-workgroup spin waiting and preserve stable radix sorting across heterogeneous schedulers.
- The rasterization stage uses the hardware vertex and fragment pipeline with instanced quads and opacity-aware bounds instead of tile-pair expansion.

## Main Method Contributions

### Wait-Free Sorting

The paper's sorting design is targeted directly at a WebGPU limitation: workgroup scheduling order is not guaranteed across devices, so common spin-wait patterns are unsafe and slow. WebSplatter replaces them with a hierarchical scan structure executed as independent dispatches with only intra-workgroup barriers.

### Opacity-Aware Geometry Control

WebSplatter uses both screen-space culling and opacity-derived quad sizing. This reduces the number of live primitives entering later stages and limits fragment overdraw in the render pass. The ablation study shows that dynamic radius sizing is particularly important on render-bound devices.

### Bandwidth-Oriented Packing

The pipeline packs projected axes into f16-based words and color-plus-opacity into RGBA8. This makes the paper useful not only as a sorting reference but also as a cross-stage data-packing reference for browser GPU pipelines.

## Evaluation Takeaways

- The paper evaluates across desktops, laptops, Apple Silicon, integrated graphics, and mobile phones rather than only on one flagship GPU.
- WebSplatter outperforms WebGL and WebGPU baselines across tested devices and avoids some crashes that affect competing viewers.
- The system is rarely sort-bound in the reported experiments, which reinforces that the sort design is successful enough to expose preprocess or render as the practical bottlenecks.
- Memory footprint is treated as part of deployability because browser viewers can fail through context loss or out-of-memory behavior.

## Research-to-Persona Lessons

- University papers often contain reusable skills in the methods and ablation sections, not just in the abstract.
- Table-driven findings should become memory notes and prioritization hints, not only prose summary.
- The dedicated paper persona should own extracted skills, while the archivist catalogs the assets for later reuse.
