# Bundle: visionary

- source_repo: https://github.com/daxsieger/visionary
- knowledge_host_repo: https://github.com/daxsieger/moltendime
- bundle_type: inferred
- generated_for_persona: repo-skill-learner

## Imported Explicit AI Assets

- No explicit AI customization files were found in the target repository root or documentation surface checked during import.

## Inferred Reusable Skills

### 1. Bootstrap the local Visionary workspace

- Install Node.js 18+.
- Run `npm install` in the repository root.
- Start the development server with `npm run dev`.
- Open `http://localhost:3000/demo/simple/index.html` or another demo under `demo/`.

### 2. Build and ship the browser library

- Use `npm run build` to produce the `dist/` library bundles.
- The package publishes `visionary-core.es.js`, `visionary-core.umd.js`, and TypeScript declarations from `dist/`.
- Treat `three`, `gl-matrix`, and `onnxruntime-web` as key runtime dependencies when integrating Visionary into another application.

### 3. Integrate VisionaryCore into an existing web app

- Import the public API from `src/index.ts`.
- Use `initThreeContext` to initialize the rendering context.
- Use `loadUnifiedModel` or `UnifiedModelLoader` for mixed asset loading.
- Configure ONNX Runtime Web through `initOrtEnvironment`, `setOrtWasmPaths`, and related helpers before loading ONNX-based models.

### 4. Prepare custom Gaussian algorithms for runtime execution

- Follow the `Gaussian Generator` contract documented in `onnx-export/README.md`.
- Export models to ONNX with stable graph shapes and WebGPU-friendly indexing.
- Avoid problematic normalization operators and very large `Concat` or `Split` nodes.
- Use the provided avatar, 4DGS, and scaffold examples as reference pipelines.

### 5. Validate showcase and demo deployments

- Use `demo/showcase/README.md` as the deployment recipe for local showcase pages.
- Keep model assets and ORT wasm files reachable from the served site.
- When deploying via CDN/importmap, provide `three` and `onnxruntime-web/webgpu` as external dependencies.
