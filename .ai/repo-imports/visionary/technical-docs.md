# Visionary Technical Notes

## Overview

Visionary is a browser-native rendering platform centered on WebGPU Gaussian Splatting, mesh rendering, and ONNX-based per-frame inference. The repository packages both an application surface with demos and a reusable library surface exposed as `visionary-core`.

## Architecture Summary

- `src/index.ts` exposes the integration API used by external applications.
- `src/app/` contains the application layer, scene wiring, rendering context setup, and high-level model loading.
- `src/app/unified-model-loader.ts` is the key control boundary for deciding whether an input goes through Gaussian or standard 3D model loading.
- `src/io/` normalizes loading across PLY, SPLAT, KSplat, SPZ, SOG, and other supported formats.
- `src/renderer/`, `src/shaders/`, `src/sort/`, and `src/preprocess/` implement the WebGPU rendering pipeline.
- `src/ONNX/` and `src/config/ort-config.ts` provide ONNX Runtime Web integration and runtime configuration.
- `src/three-integration/` and demo assets demonstrate how to embed the library into three.js scenes and showcase flows.

## Loader Decision Model

`UnifiedModelLoader` uses file suffixes and Gaussian-specific checks to route assets:

- explicit Gaussian assets: `.compressed.ply`, `.onnx`, `.sog`, `.ksplat`, `.splat`, `.spz`
- ambiguous asset: `.ply`, which is reclassified after inspection
- dedicated path: `.fbx`, routed through an FBX loader manager
- fallback path: other mesh formats are handled by the universal loader and adapted into Three.js objects

This makes the loader boundary one of the most reusable abstractions to teach another repository.

## Integration Model

The repository supports two main integration styles:

1. Run the repo as a demo/editor environment through Vite.
2. Consume the built library as `visionary-core` from another web application.

The public API exposes rendering, unified asset loading, camera abstractions, ONNX helpers, and manager classes. This makes the repository suitable both as a standalone viewer and as an embeddable engine.

The ONNX runtime configuration layer is also notable: `initOrtEnvironment` can apply wasm paths immediately when `window.ort` is already loaded, or keep retrying until the runtime appears. That pattern matters when another project lazily loads ONNX Runtime Web.

## ONNX and Custom Algorithm Workflow

The most reusable technical pattern in this repository is the ONNX export and runtime contract:

- external pipelines should export a model that behaves like a Gaussian generator
- per-frame Gaussian attributes must be produced in a layout compatible with the runtime
- model graphs should favor stable shapes and WebGPU-friendly operators
- exporter examples for avatars, 4DGS, scaffold-style scenes, and general conversions act as reference implementations

For the 4DGS exporter specifically, the repository documentation expects a source patch in the upstream 4DGaussians training code so the deformation AABB is saved before ONNX export. That is an operational prerequisite, not just a conversion command.

This means Visionary can teach another project not just how to run the viewer, but how to structure model export and runtime assumptions for browser execution.

## Operational Constraints

- Browser execution assumes WebGPU support.
- Heavy workloads are tuned toward discrete-GPU environments.
- ONNX Runtime wasm assets and model files must be served from reachable paths.
- The build pipeline enforces a chunk-size limit in `vite.config.ts`, with explicit bypasses for selected outputs.
- `tsconfig.json` keeps the source tree under strict TypeScript compilation settings even though declaration files are emitted in a separate build step.
- `GaussianRenderer` is optimized for cached GPU pipelines, preprocessors, sort resources, and global splat-capacity reuse across renders.
