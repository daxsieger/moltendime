# web-llm Technical Notes

## Summary

WebLLM is a browser-native LLM runtime that exposes local model execution through a WebGPU-accelerated engine and an OpenAI-compatible API surface. The repository is organized as a TypeScript package with a broad example matrix that shows how to embed the engine in ordinary web pages, workers, service workers, and browser extensions.

## Runtime Architecture

- The runtime centers around typed configuration layers in `src/config.ts`.
- `ChatConfig` anchors tokenizer files, conversation templates, context limits, penalties, and model-specific metadata.
- `MLCEngineConfig` isolates engine bootstrap concerns such as app config, initialization progress callbacks, log level, and a logit processor registry.
- `GenerationConfig` isolates request-scoped controls such as penalties, stop conditions, response formats, JSON mode, and optional latency breakdown.

## Engine Pipeline

- `src/engine.ts` treats model load as an explicit `reload()` phase and exposes `CreateMLCEngine()` as a convenience wrapper around that lifecycle.
- Runtime execution is split into a prefill stage and repeated decode stages, and the engine exports telemetry for both phases.
- `src/llm_chat.ts` resolves runtime ABI variants dynamically, choosing between single-step and batch prefill/decode kernel pairs.
- Prompt and embedding paths are guarded by `prefillChunkSize`, making internal chunking limits part of the engine contract.
- Some startup work is intentionally overlapped with prefill so the first visible token arrives sooner.

## Integration Model

- The repository deliberately mirrors OpenAI-style chat APIs so existing application code can be reused against local models.
- Delivery works through both package-manager installation and direct CDN import.
- The example set is part of the technical surface, not just sample code: each example captures one operational concern such as worker isolation, cache usage, structured output, or multimodal behavior.

## Deployment Surfaces

- Ordinary browser pages
- Web workers for UI-responsive inference
- Service workers for lifecycle-managed browser tasks
- Chrome extensions, including WebGPU service-worker variants

## Lifecycle-Specific Runtime Layers

- `src/service_worker.ts` does not treat service workers as a trivial alias of web workers; it introduces dedicated handler and engine types for browser background execution.
- Keep-alive messaging is part of the service-worker strategy, which matters when inference sessions need to survive browser lifecycle churn.
- The example set acts as the operational contract for abort/reload, cache reuse, worker orchestration, multi-model control, and runtime instrumentation.

## Thematic Family Placement

- WebLLM belongs to a browser-AI and WebGPU runtime family rather than a generic LLM-only bucket.
- The relevant neighbors for future comparisons are browser-native inference SDKs, WebGPU application runtimes, extension-hosted AI systems, and adjacent local-model integration repositories.

## Design Implications For Skill Extraction

- Treat WebLLM as a runtime and integration repository, not only as a model wrapper.
- Keep API-compatibility skills separate from worker/deployment skills.
- Preserve configuration-boundary skills because the repository uses typed config as a core architectural tool.
- Prefer example-backed operational guidance when extracting reusable skills from the project.

## README Preview

<div align="center" id="top">

# WebLLM

[![NPM Package](https://img.shields.io/badge/NPM_Package-Published-cc3534)](https://www.npmjs.com/package/@mlc-ai/web-llm)
[!["WebLLM Chat Deployed"](https://img.shields.io/badge/WebLLM_Chat-Deployed-%2332a852)](https://chat.webllm.ai/)
[![Join Discord](https://img.shields.io/badge/Join-Discord-7289DA?logo=discord&logoColor=white)](https://discord.gg/9Xpy2HGBuD)
[![Related Repository: WebLLM Chat](https://img.shields.io/badge/Related_Repo-WebLLM_Chat-fafbfc?logo=github)](https://github.com/mlc-ai/web-llm-chat/)
[![Related Repository: MLC LLM](https://img.shields.io/badge/Related_Repo-MLC_LLM-fafbfc?logo=github)](https://github.com/mlc-ai/mlc-llm/)

**High-Performance In-Browser LLM Inference Engine.**

[Documentation](https://webllm.mlc.ai/docs/) | [Blogpost](https://blog.mlc.ai/2024/06/13/webllm-a-high-performance-in-browser-llm-inference-engine) | [Paper](https://arxiv.org/abs/2412.15803) | [Examples](examples)

</div>

## Overview

WebLLM is a high-performance in-browser LLM inference engine that brings language model inference directly onto web browsers with hardware acceleration.
Everything runs inside the browser with no server support and is accelerated with WebGPU.

WebLLM is **fully compatible with [OpenAI API](https://platform.openai.com/docs/api-reference/chat).**
That is, you can use the same OpenAI API on **any open source models** locally, with functionalities
including streaming, JSON-mode, function-calling (WIP), etc.

We can bring a lot of fun opportunities to build AI assistants for everyone and enable privacy while enjoying GPU acceleration.

You can use WebLLM as a base [npm package](https://www.npmjs.com/package/@mlc-ai/web-llm) and build your own web application on top of it by following the examples below. This project is a companion project of [MLC LLM](https://github.com/mlc-ai/mlc-llm), which enables universal deployment of LLM across hardware environments.

<div align="center">

**[Check out WebLLM Chat to try it out!](https://chat.webllm.ai/)**

</div>

## Key Features

- **In-Browser Inference**: WebLLM is a high-performance, in-browser language model inference engine that leverages WebGPU for hardware acceleration, enabling powerful LLM operations directly within web browsers without server-side processing.

- [**Full OpenAI API Compatibility**](#full-openai-compatibility): Seamlessly integrate your app with WebLLM using OpenAI API with functionalities such as streaming, JSON-mode, logit-level control, seeding, and more.

- **Structured JSON Generation**: WebLLM supports state-of-the-art JSON mode structured generation, implemented in the WebAssembly portion of the model library for optimal performance. Check [WebLLM JSON Playground](https://huggingface.co/spaces/mlc-ai/WebLLM-JSON-Playground) on HuggingFace to try generating JSON output with custom JSON schema.

- [**Extensive Model Support**](#built-in-models): WebLLM natively supports a range of models including Llama 3, Phi 3, Gemma, Mistral, Qwen(通义千问), and many others, making it versatile for various AI tasks. For the complete supported model list, check [MLC Models](https://mlc.ai/models).

- [**Custom Model Integration**](#custom-models): Easily integrate and deploy custom models in MLC format, allowing you to adapt WebLLM to specific needs and scenarios, enhancing flexibility in model deployment.

- **Plug-and-Play Integration**: Easily integrate WebLLM into your projects using package managers like NPM and Yarn, or directly via CDN, complete with comprehensive [examples](./examples/) and a modular design for connecting with UI components.

- **Streaming & Real-Time Interactions**: Supports streaming chat completions, allowing real-time output generation which enhances interactive applications like chatbots and virtual assistants.

- **Web Worker & Service Worker Support**: Optimize UI performance and manage the lifecycle of models efficiently by offloading computations to separate worker threads or service workers.

- **Chrome Extension Support**: Extend the functionality of web browsers through custom Chrome extensions using WebLLM, with examples available for building both basic and advanced extensions.

## Built-in Models

Check the complete list of available models on [MLC Models](https://mlc.ai/models). WebLLM supports a subset of these available models and the list can be accessed at [`prebuiltAppConfig.model_list`](https://github.com/mlc-ai/web-llm/blob/main/src/config.ts#L293).

Here are the primary families of models currently supported:

- **Llama**: Llama 3, Llama 2, Hermes-2-Pro-Llama-3
- **Phi**: Phi 3, Phi 2, Phi 1.5
- **Gemma**: Gemma-2B
- **Mistral**: Mistral-7B-v0.3, Hermes-2-Pro-Mistral-7B, NeuralHermes-2.5-Mistral-7B, OpenHermes-2.5-Mistral-7B
- **Qwen (通义千问)**: Qwen2 0.5B, 1.5B, 7B

If you need more models, [request a new model via opening an issue](https://github.com/mlc-ai/web-llm/issues/new/choose) or check [Custom Models](#custom-models) for how to compile and use your own models with WebLLM.

## Jumpstart with Examples

Learn how to use WebLLM to integrate large language models into your application and generate chat completions through this simple Chatbot example:

[![Example Chatbot on JSFiddle](https://img.shields.io/badge/Example-JSFiddle-blue?logo=jsfiddle&logoColor=white)](https://jsfiddle.net/neetnestor/4nmgvsa2/)
[![Example Chatbot on Codepen](https://img.shields.io/badge/Example-Codepen-gainsboro?logo=codepen)](https://codepen.io/neetnestor/pen/vYwgZaG)

For an advanced example of a larger, more complicated project, check [WebLLM Chat](https://github.com/mlc-ai/web-llm-chat/blob/main/app/client/webllm.ts).

More examples for different use cases are available in the [examples](./examples/) folder.

## Get Started

WebLLM offers a minimalist and modular interface to access the chatbot in the browser.
The package is designed in a modular way to hook to any of the UI components.

### Installation

#### Package Manager

```sh
# npm
npm install @mlc-ai/web-llm
# yarn
yarn add @mlc-ai/web-llm
# or pnpm
pnpm install @mlc-ai/web-llm
```

Then import the module in your code.

```typescript
// Import everything
import * as webllm from "@mlc-ai/web-llm";
// Or only import what you need
import { CreateMLCEngine } from "@mlc-ai/web-llm";
```

#### CDN Delivery

Thanks to [jsdelivr.com](https://www.jsdelivr.com/package/npm/@mlc-ai/web-llm), WebLLM can be imported directly through URL and work out-of-the-box on cloud development platforms like [jsfiddle.net](https://jsfiddle.net/), [Codepen.io](https://codepen.io/), and [Scribbler](https://scribbler.live):

```javascript
import * as webllm from "https://esm.run/@mlc-ai/web-llm";
```

It can also be dynamically imported as:

```javascript
const webllm = await import("https://esm.run/@mlc-ai/web-llm");
```
