# web-splat Skills 21-30

## Skill 21: Rebuild Sort Buffers Only on Point-Count Changes
- evidence: `src/renderer.rs`
- optimization: Recreate sort resources only when the active point cloud size changes.
- transfer: Key scratch-buffer reuse to structural changes, not to frames.

## Skill 22: GPU-Side Indirect Reset and Draw-Count Handoff
- evidence: `src/renderer.rs`, `src/gpu_rs.rs`
- optimization: Reset sort and draw metadata on GPU, then copy the final visible-count value into the indirect draw args.
- transfer: Chain compute visibility and rendering without CPU synchronization.

## Skill 23: Port a Proven GPU Radix Sort Instead of Re-Inventing One
- evidence: `src/gpu_rs.rs`, `src/shaders/radix_sort.wgsl`
- optimization: Reimplement the Fuchsia radix sort design in WGPU rather than designing a new sorter from scratch.
- transfer: Start from a field-tested parallel primitive when GPU sorting is business-critical.

## Skill 24: Probe the Largest Safe Subgroup Size Empirically
- evidence: `src/gpu_rs.rs`
- optimization: Run test sorts to find the maximum subgroup size when the backend cannot expose it reliably.
- transfer: Benchmark feature envelopes when the API does not provide the hardware detail directly.

## Skill 25: Inject Sort Constants into WGSL at Pipeline Build Time
- evidence: `src/gpu_rs.rs`
- optimization: Specialize the radix-sort shader by prepending constant definitions before module creation.
- transfer: Generate shader variants from runtime-known constants when those constants shape shared-memory layout.

## Skill 26: Zero Histograms and Pad Keys in a Dedicated Kernel
- evidence: `src/shaders/radix_sort.wgsl`
- optimization: Reset histogram memory and pad trailing keys with sentinel values before sorting.
- transfer: Put sort hygiene in its own kernel so the hot passes can assume valid state.

## Skill 27: Load Multiple Key Rows per Workgroup Thread
- evidence: `src/shaders/radix_sort.wgsl`
- optimization: Process `rs_histogram_block_rows` keys per invocation to amortize memory traffic.
- transfer: Batch per-thread key loads when histogram passes are bandwidth bound.

## Skill 28: Prefix Histograms with Two Prefixes per Workgroup Thread
- evidence: `src/shaders/radix_sort.wgsl`
- optimization: Let one prefix workgroup process two histogram positions per thread through shared memory.
- transfer: Halve workgroup count for prefix phases when the reduction structure allows it.

## Skill 29: Use Even/Odd Scatter Pipelines for Double Buffering
- evidence: `src/gpu_rs.rs`
- optimization: Alternate scatter passes between two key and payload buffers.
- transfer: Double-buffer permutation stages to avoid in-place scatter hazards.

## Skill 30: Fuse Preprocess and Sort Metadata into a Dedicated Bind Group
- evidence: `src/gpu_rs.rs`
- optimization: Expose sorter uniform, dispatch, and output buffers through a preprocess-specific bind group.
- transfer: Build bind groups around stage-local access patterns to stay within binding-slot budgets.
