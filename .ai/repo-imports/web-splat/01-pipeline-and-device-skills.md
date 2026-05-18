# web-splat Skills 01-10

## Skill 01: Native Feature-Gated Device Bring-Up
- evidence: `src/lib.rs`
- optimization: Request timestamp queries and 16-bit norm features only on native targets.
- transfer: Gate expensive or unsupported GPU features per platform instead of forcing one universal device profile.

## Skill 02: Performance-Oriented Memory Hints
- evidence: `src/lib.rs`
- optimization: Use `wgpu::MemoryHints::Performance` when requesting the device.
- transfer: Declare performance intent explicitly when a renderer is throughput-bound.

## Skill 03: Raise Limits Only Where the Renderer Needs Them
- evidence: `src/lib.rs`
- optimization: Override storage-buffer and workgroup-storage limits to match the sort and preprocess pipeline.
- transfer: Lift only the concrete GPU limits needed by the workload instead of requesting oversized defaults blindly.

## Skill 04: Keep Frame Latency Short
- evidence: `src/lib.rs`
- optimization: Configure `desired_maximum_frame_latency` to `2`.
- transfer: Cap queued frames to reduce interactive lag in high-FPS viewers.

## Skill 05: Separate Surface Format from Render Format
- evidence: `src/lib.rs`
- optimization: Keep the swapchain format independent from the internal render target so HDR and SDR paths can coexist.
- transfer: Decouple presentation compatibility from internal precision choices.

## Skill 06: Runtime V-Sync Strategy Switching
- evidence: `src/lib.rs`, `src/bin/viewer.rs`
- optimization: Toggle between `AutoVsync` and `AutoNoVsync` from runtime config.
- transfer: Make presentation strategy a user-facing performance knob instead of a compile-time constant.

## Skill 07: Lazy Sorter Allocation at Renderer Construction Time
- evidence: `src/renderer.rs`
- optimization: Build the GPU sorter once in renderer initialization and reuse it across frames.
- transfer: Hoist expensive pipeline creation out of the hot frame loop.

## Skill 08: Minimal Pipeline Layout for the Render Pass
- evidence: `src/renderer.rs`
- optimization: Bind only the point-cloud render buffers and sorted-index buffers in the render pipeline layout.
- transfer: Keep render-stage bind groups minimal and push heavy work into compute preprocessing.

## Skill 09: Persistent Indirect Draw Buffer Reuse
- evidence: `src/renderer.rs`
- optimization: Create one indirect draw buffer and reset only its counts each frame.
- transfer: Reuse control buffers instead of reallocating draw metadata every frame.

## Skill 10: Optional GPU Profiling by Target
- evidence: `src/lib.rs`, `src/utils.rs`
- optimization: Enable `GPUStopwatch` only when timestamp queries are available and useful.
- transfer: Make profiling infrastructure conditional so production and wasm builds stay lean.
