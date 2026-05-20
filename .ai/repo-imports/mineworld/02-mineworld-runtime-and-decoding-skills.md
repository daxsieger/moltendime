# mineworld Skills 06-10

## Skill 06: Map Interactive Controls Into a Compact Action Vocabulary Before Generation
- evidence: `mineworld.py`
- method: Convert UI button state and camera deltas into an action dictionary, then into model action indices through `MCDataset` with an action-vocabulary offset.
- transfer: Interactive world-model demos work better when UI complexity is collapsed into a stable model-facing action codec.

## Skill 07: Refresh KV Cache by Re-Prefilling a Retained Context Slice
- evidence: `mineworld.py`
- method: Once the action history reaches context length, drop the oldest frames and actions, refresh the transformer's KV cache, and prefill again from the retained slice.
- transfer: Long-running interactive demos need explicit cache refresh logic instead of assuming infinite context.

## Skill 08: Inject Actions Into Pixel Decoding at Structured Token Boundaries
- evidence: `diagonal_decoding.py`
- method: Use explicit `pixnum` and `actnum` boundaries so action tokens are reinserted into the autoregressive stream at predictable image-generation intervals.
- transfer: Mixed image-token and action-token rollouts stay tractable when their boundaries are first-class decoding parameters.

## Skill 09: Keep Naive and Diagonal Decoding as Swappable Inference Backends
- evidence: `inference.py`, `lvm.py`
- method: Expose `naive_generate` and `img_diagd_generate` as sibling acceleration paths selected by an argument rather than by different scripts.
- transfer: Benchmark repos should make speed-quality decoding alternatives selectable without changing the rest of the evaluation pipeline.

## Skill 10: Measure Runtime in Tokens Per Second and Frames Per Second
- evidence: `inference.py`
- method: Compute token throughput and divide by `TOKEN_PER_PIX` to get the effective frame rate after generation.
- transfer: World-model performance reporting becomes more comparable when token throughput and visual frame throughput are both surfaced.