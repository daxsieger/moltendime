# gamefactory Skills 06-10

## Skill 06: Rebuild Derived Metadata From Scratch Before Each Detection Pass
- evidence: `detection.py`
- method: Clear the output metadata directory at the start of processing so collision and jump annotations are always regenerated from the source videos and metadata JSON files.
- transfer: Derived action annotations stay trustworthy when post-processing is explicitly treated as a reproducible rebuild step rather than an incremental patch.

## Skill 07: Enrich Per-Frame Action Records With Motion Deltas and Validity Flags
- evidence: `detection.py`
- method: Walk aligned video and metadata pairs frame by frame, then attach `delta_pos`, `collision`, and `jump_invalid` fields directly onto each action record before writing a parallel metadata bundle.
- transfer: Dataset-side action processing becomes much easier to reuse when physics-adjacent flags are written back into the same per-frame action structure consumed downstream.

## Skill 08: Use A Two-Pass Rule System For Jump And Collision Detection
- evidence: `detection.py`
- method: First mark candidate collisions from low horizontal displacement and invalid jumps from insufficient height change, then run a second pass that suppresses repeated jumps within one held-jump sequence.
- transfer: Simple motion heuristics become more reliable when event detection separates raw thresholding from sequence-level cleanup.

## Skill 09: Expand Segment-Level Control Configurations Into Per-Frame Key And Mouse Streams
- evidence: `visualize.py`
- method: Convert compact control segments into framewise keyboard booleans and cumulative mouse positions, including a default initial cursor origin and scaled motion deltas.
- transfer: Visualization and replay tools stay interoperable when compressed action schedules are normalized into explicit per-frame control traces first.

## Skill 10: Render Action Debug Overlays Directly On Gameplay Video
- evidence: `visualize.py`
- method: Draw rounded keyboard widgets with pressed-state alpha changes and composite a rotated, scaled mouse icon into each frame while clipping the icon region to valid image bounds.
- transfer: Interactive-video datasets become easier to audit when input state is rendered back onto the generated or recorded video instead of inspected only as sidecar metadata.