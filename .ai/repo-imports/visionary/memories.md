# Visionary Memory Notes

- Repository URL: https://github.com/daxsieger/visionary
- Project type: TypeScript WebGPU rendering library and browser demos for Gaussian Splatting and mesh rendering.
- Main runtime stack: WebGPU, ONNX Runtime Web, three.js, gl-matrix, Vite, TypeScript.
- Package name: `visionary-core`.
- Default dev server port: `3000`.
- Main development command: `npm run dev`.
- Main build command: `npm run build`.
- Public package outputs: `dist/visionary-core.es.js`, `dist/visionary-core.umd.js`, `dist/index.d.ts`.
- Public API entrypoint: `src/index.ts`.
- Asset loading focus: static Gaussian formats, mesh formats, ONNX-based dynamic Gaussian and avatar formats.
- Technical constraint: a recent Chromium browser with WebGPU is required.
- Platform note: Ubuntu is documented as unsupported for the fp16 ONNX pipeline; macOS is documented as slower and not recommended for heavy workloads.
- Integration note: ORT wasm assets must stay reachable and correctly configured for ONNX features.
- Knowledge quality: this bundle is inferred from project docs and source layout because explicit AI assets were not found.
