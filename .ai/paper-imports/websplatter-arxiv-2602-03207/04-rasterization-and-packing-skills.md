# WebSplatter Paper Skills 31-40

## Skill 31: Prefer Hardware Rasterization over Tile-Pair Expansion on the Web
- evidence: Section 3.4
- method: Use the standard vertex and fragment pipeline instead of generating and sorting large tile-splat pair buffers.
- transfer: Avoid tile-buffer memory traffic on bandwidth-limited laptop and mobile GPUs.

## Skill 32: Render Each Gaussian as One Instanced Quad
- evidence: Section 3.4
- method: Draw each visible gaussian with a quad made of two triangles through instancing.
- transfer: Keep the render stage simple when expensive work has already been folded into preprocessing.

## Skill 33: Derive Quad Bounds from Opacity Instead of Using a Fixed Radius
- evidence: Section 3.4, Table 5
- method: Compute quad size from the opacity cutoff rather than assigning a static bounding box.
- transfer: Use signal-dependent bounds to reduce overdraw in translucent splat renderers.

## Skill 34: Use the Quantization Threshold as the Cutoff Criterion
- evidence: Section 3.4
- method: Set the minimum effective contribution threshold at `1/255` and solve the radius from that cutoff.
- transfer: Tie geometry bounds directly to the precision floor of the output representation.

## Skill 35: Compute Radius from `ln(255 * sigma)` in the Vertex Shader
- evidence: Section 3.4
- method: Evaluate the opacity-aware scaling factor per splat in the vertex stage.
- transfer: Push lightweight bound reconstruction into the vertex shader to keep geometry tight and dynamic.

## Skill 36: Pass Local Coordinates for Free Interpolation
- evidence: Section 3.4
- method: Attach a local coordinate to each quad vertex and let hardware interpolation reconstruct per-fragment positions.
- transfer: Reuse built-in interpolation hardware for continuous local parameterization rather than rebuilding it manually.

## Skill 37: Recover Gaussian Distance with a Dot Product in the Fragment Shader
- evidence: Section 3.4
- method: Compute squared distance from the interpolated local coordinate by taking its dot product with itself.
- transfer: Reduce fragment cost by reconstructing the gaussian argument from minimal interpolated data.

## Skill 38: Treat Tight Bounding as a Render-Stage Throughput Optimization
- evidence: Table 5
- method: Attribute much of the render cost reduction to opacity-based tight bounds rather than only to sorting.
- transfer: Extract overdraw control as a separate optimization lever in splat renderers.

## Skill 39: Pack Derived Render Inputs Aggressively Between Stages
- evidence: Section 3.2, Section 3.4
- method: Pass compressed geometry and color payloads from preprocess to render rather than full-precision intermediates.
- transfer: Model inter-stage bandwidth as part of renderer design, not as an afterthought.

## Skill 40: Avoid Memory-Hungry Intermediate Structures on Constrained Devices
- evidence: Section 3.4, Section 4.5
- method: Favor representations and passes that reduce peak memory footprint on mobile and lower-end GPUs.
- transfer: Let memory risk shape pipeline design when browser crashes and context loss are part of the real performance envelope.
