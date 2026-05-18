# WebSplatter Paper Skills 11-20

## Skill 11: Convert Raw 3D Gaussians into a Compacted View-Dependent Working Set
- evidence: Section 3.2
- method: Use preprocessing to turn raw gaussians into compact visible 2D primitives before sort and rasterization.
- transfer: Make preprocessing produce a reduced, downstream-friendly representation instead of passing full source data through the pipeline.

## Skill 12: Project Center and Covariance into Screen Space Early
- evidence: Section 3.2
- method: Project each gaussian's center and covariance into a 2D ellipse during the preprocess stage.
- transfer: Move projection and extent analysis ahead of rasterization when later stages only need screen-space primitives.

## Skill 13: Cull by Screen-Space Bounding Box Intersection
- evidence: Section 3.2, Table 5
- method: Drop gaussians whose projected AABB does not intersect the viewport.
- transfer: Use cheap screen-space rejection before sort and render to cut unnecessary downstream work.

## Skill 14: Compute Major and Minor Axes During the Same Culling Pass
- evidence: Section 3.2
- method: Reuse the culling pass to calculate the projected ellipse axes that later stages need.
- transfer: Fuse preprocessing substeps when they traverse the same data and camera state.

## Skill 15: Pack Projected Axes into Two 32-Bit Words via f16 Components
- evidence: Section 3.2
- method: Compress the two axis vectors into a pair of 32-bit unsigned integers using 16-bit floats.
- transfer: Reduce memory bandwidth by packing derived screen-space geometry as soon as precision requirements allow it.

## Skill 16: Emit Depth During Visibility Preparation
- evidence: Section 3.2
- method: Compute and store view-space depth for each alive primitive during preprocessing.
- transfer: Generate sort keys where visibility is determined so later stages avoid recomputation.

## Skill 17: Evaluate View-Dependent Color Before Rasterization
- evidence: Section 3.2
- method: Compute final RGB color from spherical harmonics in the preprocess stage based on current view direction.
- transfer: Shift expensive view-dependent shading out of the raster pass when the result can be cached per visible primitive.

## Skill 18: Pack Color and Opacity into RGBA8 for the Render Path
- evidence: Section 3.2
- method: Compress floating-point color plus opacity into one 32-bit RGBA8 value.
- transfer: Use aggressive packing between pipeline stages when the packed representation is sufficient for final blending.

## Skill 19: Combine Frustum and Screen-Space Culling Instead of Relying on Only One
- evidence: Section 3.2, Table 5
- method: Retain initial frustum culling but add AABB culling to shrink the working set further.
- transfer: Layer coarse and fine culling mechanisms to protect both preprocessing and rendering throughput.

## Skill 20: Encode Negligible-Opacity Primitives as Early Rejects
- evidence: Section 3.4, Table 5
- method: Prune gaussians whose opacity falls below the quantization threshold before they reach rasterization.
- transfer: Convert numerical insignificance thresholds into explicit culling rules to reduce overdraw and memory pressure.
