# web-splat Skills 41-50

## Skill 41: Bias Native Usage Toward Release Viewer Builds
- evidence: `README.md`
- optimization: Document the release viewer binary as the default native build path.
- transfer: Align the documented happy path with the performance envelope users should actually expect.

## Skill 42: Feature-Gate Compressed Input Support at Runtime Entry
- evidence: `README.md`
- optimization: Require the `npz` feature only when compressed input formats are needed.
- transfer: Keep optional format support off the critical build by default.

## Skill 43: Use a Slim Web Release Profile
- evidence: `Cargo.toml`
- optimization: Define `profile.web-release` with `opt-level = "s"` and `strip = "debuginfo"`.
- transfer: Maintain a separate wasm-oriented optimization profile instead of reusing the native release defaults blindly.

## Skill 44: Build Wasm Without Unneeded Default Features
- evidence: `build_wasm.sh`
- optimization: Compile wasm with `--no-default-features`, `--lib`, and only the features required for the browser payload.
- transfer: Trim web artifacts by making the wasm build surface explicit.

## Skill 45: Automate GitHub Pages Deployment Around the Wasm Toolchain
- evidence: `.github/workflows/viewer.yml`
- optimization: Provision the wasm target, run the build script, and publish `public/` through Pages in one workflow.
- transfer: Treat static wasm deployment as a first-class CI path, not an afterthought.

## Skill 46: Warm the Renderer Before Measuring Throughput
- evidence: `src/bin/measure.rs`
- optimization: Execute an initial render to force lazy sorter and pipeline setup before timing repeated renders.
- transfer: Separate warmup from steady-state performance measurement.

## Skill 47: Auto-Discover Nearby Scene Files
- evidence: `src/bin/viewer.rs`
- optimization: Search parent directories for `cameras.json` when the user omits a scene file.
- transfer: Remove manual path friction for common dataset layouts.

## Skill 48: Encode a Default Train/Test Split in Scene Loading
- evidence: `src/scene.rs`
- optimization: Mark every eighth camera as test and the rest as train when importing scene JSON.
- transfer: Carry evaluation semantics alongside viewing data so downstream tooling can reuse them.

## Skill 49: Update Egui Textures Incrementally
- evidence: `src/ui_renderer.rs`
- optimization: Apply only texture deltas and free them after use instead of rebuilding all UI textures every frame.
- transfer: Keep UI composition incremental when the main workload is already GPU-heavy.

## Skill 50: Scale Camera Motion by Scene Distance and Damp Touch Input
- evidence: `src/controller.rs`
- optimization: Use logarithmic zoom, distance-aware panning, and reduced touch sensitivity for precise control on large scenes.
- transfer: Tie navigation speed to scene scale so interactive viewers stay controllable across datasets.
