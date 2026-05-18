# Visionary Technical Notes

## Overview

Visionary is a browser-native rendering platform centered on WebGPU Gaussian Splatting, mesh rendering, and ONNX-based per-frame inference. The repository packages both an application surface with demos and a reusable library surface exposed as `visionary-core`.

## Architecture Summary

- `src/index.ts` exposes the integration API used by external applications.
- `src/app/` contains the application layer, scene wiring, rendering context setup, and high-level model loading.
- `src/io/` normalizes loading across PLY, SPLAT, KSplat, SPZ, SOG, and other supported formats.
- `src/renderer/`, `src/shaders/`, `src/sort/`, and `src/preprocess/` implement the WebGPU rendering pipeline.
- `src/ONNX/` and `src/config/ort-config.ts` provide ONNX Runtime Web integration and runtime configuration.
- `src/three-integration/` and demo assets demonstrate how to embed the library into three.js scenes and showcase flows.

## Integration Model

The repository supports two main integration styles:

1. Run the repo as a demo/editor environment through Vite.
2. Consume the built library as `visionary-core` from another web application.

The public API exposes rendering, unified asset loading, camera abstractions, ONNX helpers, and manager classes. This makes the repository suitable both as a standalone viewer and as an embeddable engine.

## ONNX and Custom Algorithm Workflow

The most reusable technical pattern in this repository is the ONNX export and runtime contract:

- external pipelines should export a model that behaves like a Gaussian generator
- per-frame Gaussian attributes must be produced in a layout compatible with the runtime
- model graphs should favor stable shapes and WebGPU-friendly operators
- exporter examples for avatars, 4DGS, scaffold-style scenes, and general conversions act as reference implementations

This means Visionary can teach another project not just how to run the viewer, but how to structure model export and runtime assumptions for browser execution.

## Operational Constraints

- Browser execution assumes WebGPU support.
- Heavy workloads are tuned toward discrete-GPU environments.
- ONNX Runtime wasm assets and model files must be served from reachable paths.
- The build pipeline enforces a chunk-size limit in `vite.config.ts`, with explicit bypasses for selected outputs.
