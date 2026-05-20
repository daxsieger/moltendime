# wan-2-2 Technical Notes

## Summary

Wan2.2 is a large-scale multimodal video-generation repository that sits upstream of the more directly interactive world-model peers. Inside the interactive-world-model family it matters less as a benchmark peer and more as a reusable video backbone, especially for Matrix-Game descendants that already reference Wan-based runtime components.

## Key Role

- Upstream Wan-based video backbone peer
- MoE video diffusion architecture
- Unified task family spanning T2V, I2V, TI2V, S2V, and animation
- Explicit single-GPU and distributed inference posture

## Code-Grounded Runtime Surface

- `generate.py` is the controlling CLI surface for all public tasks.
- The repo centralizes per-task validation, default prompt selection, sampling defaults, and supported-size checks before model initialization.
- Prompt extension is wired into the same runtime surface through either DashScope or local Qwen models.
- `wan/textimage2video.py` shows how Wan2.2 actually composes TI2V from T5, Wan2.2-VAE, and WanModel, then applies FSDP or sequence-parallel adaptations.
- The code also makes device placement and dtype conversion explicit policy choices rather than incidental details.

## Backbone Surface

- `wan/modules/attention.py` keeps the backbone portable by preferring varlen flash-attention kernels but retaining a native scaled-dot-product fallback.
- `wan/modules/model.py` shows that WanModel is not a generic transformer wrapper: it patchifies video with Conv3d, tracks `grid_sizes` and `seq_lens`, and applies axis-factorized RoPE over time, height, and width.
- The same module uses six-way timestep modulation inside each attention block, so conditioning reaches self-attention, cross-attention, and FFN residual paths directly.
- `wan/modules/vae2_2.py` reveals a causal 3D VAE with temporal cache reuse during upsampling, downsampling, and residual processing, which matters for chunked video serving.

## Family Relevance

- Wan2.2 is not a gameplay-world-model repo in the way MineWorld or Open Oasis are.
- It still belongs in the family because it is a likely upstream substrate for controllable world-generation systems that need stronger video priors, prompt extension, or distributed inference patterns.
- The code confirms that this relevance is operational, not only conceptual: the repo exposes reusable strategies for task multiplexing, prompt expansion, distributed model execution, and the internal design of a deployable video backbone.

## README Preview

# Wan2.2

<p align="center">
    <img src="assets/logo.png" width="400"/>
<p>

<p align="center">
    💜 <a href="https://wan.video"><b>Wan</b></a> &nbsp&nbsp ｜ &nbsp&nbsp 🖥️ <a href="https://github.com/Wan-Video/Wan2.2">GitHub</a> &nbsp&nbsp  | &nbsp&nbsp🤗 <a href="https://huggingface.co/Wan-AI/">Hugging Face</a>&nbsp&nbsp | &nbsp&nbsp🤖 <a href="https://modelscope.cn/organization/Wan-AI">ModelScope</a>&nbsp&nbsp | &nbsp&nbsp 📑 <a href="https://arxiv.org/abs/2503.20314">Paper</a> &nbsp&nbsp | &nbsp&nbsp 📑 <a href="https://wan.video/welcome?spm=a2ty_o02.30011076.0.0.6c9ee41eCcluqg">Blog</a> &nbsp&nbsp |  &nbsp&nbsp 💬  <a href="https://discord.gg/AKNgpMK4Yj">Discord</a>&nbsp&nbsp
    <br>
    📕 <a href="https://alidocs.dingtalk.com/i/nodes/jb9Y4gmKWrx9eo4dCql9LlbYJGXn6lpz">使用指南(中文)</a>&nbsp&nbsp | &nbsp&nbsp 📘 <a href="https://alidocs.dingtalk.com/i/nodes/EpGBa2Lm8aZxe5myC99MelA2WgN7R35y">User Guide(English)</a>&nbsp&nbsp | &nbsp&nbsp💬 <a href="https://gw.alicdn.com/imgextra/i2/O1CN01tqjWFi1ByuyehkTSB_!!6000000000015-0-tps-611-1279.jpg">WeChat(微信)</a>&nbsp&nbsp
<br>

-----

[**Wan: Open and Advanced Large-Scale Video Generative Models**](https://arxiv.org/abs/2503.20314) <be>


We are excited to introduce **Wan2.2**, a major upgrade to our foundational video models. With **Wan2.2**, we have focused on incorporating the following innovations:

- 👍 **Effective MoE Architecture**: Wan2.2 introduces a Mixture-of-Experts (MoE) architecture into video diffusion models. By separating the denoising process cross timesteps with specialized powerful expert models, this enlarges the overall model capacity while maintaining the same computational cost.

- 👍 **Cinematic-level Aesthetics**: Wan2.2 incorporates meticulously curated aesthetic data, complete with detailed labels for lighting, composition, contrast, color tone, and more. This allows for more precise and controllable cinematic style generation, facilitating the creation of videos with customizable aesthetic preferences.

- 👍 **Complex Motion Generation**: Compared to Wan2.1, Wan2.2 is trained on a significantly larger data, with +65.6% more images and +83.2% more videos. This expansion notably enhances the model's generalization across multiple dimensions such as motions,  semantics, and aesthetics, achieving TOP performance among all open-sourced and closed-sourced models. 

- 👍 **Efficient High-Definition Hybrid TI2V**:  Wan2.2 open-sources a 5B model built with our advanced Wan2.2-VAE that achieves a compression ratio of **16×16×4**. This model supports both text-to-video and image-to-video generation at 720P resolution with 24fps and can also run on consumer-grade graphics cards like 4090. It is one of the fastest **720P@24fps** models currently available, capable of serving both the industrial and academic sectors simultaneously.


## Video Demos

<div align="center">
  <video src="https://github.com/user-attachments/assets/b63bfa58-d5d7-4de6-a1a2-98970b06d9a7" width="70%" poster=""> </video>
</div>

## 🔥 Latest News!!
* Nov 13, 2025: 👋 Wan2.2-Animate-14B has been integrated into Diffusers ([PR](https://github.com/huggingface/diffusers/pull/12526),[Weights](https://huggingface.co/Wan-AI/Wan2.2-Animate-14B-Diffusers)). Thanks to all community contributors. Enjoy!

* Sep 19, 2025: 💃 We introduct **[Wan2.2-Animate-14B](https://humanaigc.github.io/wan-animate)**, an unified model for character animation and replacement with holistic movement and expression replication. We released the [model weights](#model-download) and [inference code](#run-wan-animate). And you can try it on [wan.video](https://wan.video/), [ModelScope Studio](https://www.modelscope.cn/studios/Wan-AI/Wan2.2-Animate) or [HuggingFace Space](https://huggingface.co/spaces/Wan-AI/Wan2.2-Animate)!
* Aug 26, 2025: 🎵 We introduce **[Wan2.2-S2V-14B](https://humanaigc.github.io/wan-s2v-webpage)**, an audio-driven cinematic video generation model, including [inference code](#run-speech-to-video-generation), [model weights](#model-download), and [technical report](https://humanaigc.github.io/wan-s2v-webpage/content/wan-s2v.pdf)! Now you can try it on [wan.video](https://wan.video/),  [ModelScope Gradio](https://www.modelscope.cn/studios/Wan-AI/Wan2.2-S2V) or [HuggingFace Gradio](https://huggingface.co/spaces/Wan-AI/Wan2.2-S2V)!
* Jul 28, 2025: 👋 We have open a [HF space](https://huggingface.co/spaces/Wan-AI/Wan-2.2-5B) using the TI2V-5B model. Enjoy!
* Jul 28, 2025: 👋 Wan2.2 has been integrated into ComfyUI ([CN](https://docs.comfy.org/zh-CN/tutorials/video/wan/wan2_2) | [EN](https://docs.comfy.org/tutorials/video/wan/wan2_2)). Enjoy!
* Jul 28, 2025: 👋 Wan2.2's T2V, I2V and TI2V have been integrated into Diffusers ([T2V-A14B](https://huggingface.co/Wan-AI/Wan2.2-T2V-A14B-Diffusers) | [I2V-A14B](https://huggingface.co/Wan-AI/Wan2.2-I2V-A14B-Diffusers) | [TI2V-5B](https://huggingface.co/Wan-AI/Wan2.2-TI2V-5B-Diffusers)). Feel free to give it a try!
* Jul 28, 2025: 👋 We've released the inference code and model weights of **Wan2.2**.
* Sep 5, 2025: 👋 We add text-to-speech synthesis support with [CosyVoice](https://github.com/FunAudioLLM/CosyVoice) for Speech-to-Video generation task.


## Community Works
If your research or project builds upon [**Wan2.1**](https://github.com/Wan-Video/Wan2.1) or [**Wan2.2**](https://github.com/Wan-Video/Wan2.2), and you would like more people to see it, please inform us.

- [Prompt Relay](https://github.com/GordonChen19/Prompt-Relay), a plug-and-play, inference-time method for temporal control in video generation. Prompt Relay improves video quality and gives users precise control over what happens at each moment in the video. Visit their [webpage](https://gordonchen19.github.io/Prompt-Relay/) for more details.
- [Helios](https://github.com/PKU-YuanGroup/Helios), a breakthrough video generation model base on **Wan2.1** that achieves minute-scale, high-quality video synthesis at 19.5 FPS on a single H100 GPU (about 10 FPS on a single Ascend NPU) —without relying on conventional long video anti-drifting strategies or standard video acceleration techniques. Visit their [webpage](https://pku-yuangroup.github.io/Helios-Page/) for more details.
- [LightX2V](https://github.com/ModelTC/LightX2V), a lightweight and efficient video generation framework that integrates **Wan2.1** and **Wan2.2**, supporting multiple engineering acceleration techniques for fast inference. [LightX2V-HuggingFace](https://huggingface.co/lightx2v), offers a variety of Wan-based step-distillation models, quantized models, and lightweight VAE models.
- [HuMo](https://github.com/Phantom-video/HuMo) proposed a unified, human-centric framework based on **Wan** to produce high-quality, fine-grained, and controllable human videos from multimodal inputs—including text, images, and audio. Visit their [webpage](https://phantom-video.github.io/HuMo/) for more details.
- [FastVideo](https://github.com/hao-ai-lab/FastVideo) includes distilled **Wan** models with sparse attention that significanly speed up the inference time. 
- [Cache-dit](https://github.com/vipshop/cache-dit) offers Fully Cache Acceleration support for **Wan2.2** MoE with DBCache, TaylorSeer and Cache CFG. Visit their [example](https://github.com/vipshop/cache-dit/blob/main/examples/pipeline/run_wan_2.2.py) for more details.
- [Kijai's ComfyUI WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper) is an alternative implementation of **Wan** models for ComfyUI. Thanks to its Wan-only focus, it's on the frontline of getting cutting edge optimizations and hot research features, which are often hard to integrate into ComfyUI quickly due to its more rigid structure.
- [DiffSynth-Studio](https://github.com/modelscope/DiffSynth-Studio) provides comprehensive support for **Wan 2.2**, including low-GPU-memory layer-by-layer offload, FP8 quantization, sequence parallelism, LoRA training, full training.


## 📑 Todo List
- Wan2.2 Text-to-Video
    - [x] Multi-GPU Inference code of the A14B and 14B models
    - [x] Checkpoints of the A14B and 14B models
    - [x] ComfyUI integration
    - [x] Diffusers integration
- Wan2.2 Image-to-Video
    - [x] Multi-GPU Inference code of the A14B model
    - [x] Checkpoints of the A14B model
    - [x] ComfyUI integration
    - [x] Diffusers integration
- Wan2.2 Text-Image-to-Video
    - [x] Multi-GPU Inference code of the 5B model
    - [x] Checkpoints of the 5B model
    - [x] ComfyUI integration
    - [x] Diffusers integration
- Wan2.2-S2V Speech-to-Video
    - [x] Inference code of Wan2.2-S2V
    - [x] Checkpoints of Wan2.2-S2V-14B
    - [x] ComfyUI integration
    - [x] Diffusers integration
- Wan2.2-Animate Character Animation and Replacement
    - [x] Inference code of Wan2.2-Animate
    - [x] Checkpoints of Wan2.2-Animate
    - [x] ComfyUI integration
    - [x] Diffusers integration

## Run Wan2.2

#### Installation
Clone the repo:
```sh
git clone https://github.com/Wan-Video/Wan2.2.git
cd Wan2.2
```

Install dependencies:
```sh
# Ensure torch >= 2.4.0
# If the installation of `flash_attn` fails, try installing the other packages first and install `flash_attn` last
pip install -r requirements.txt
# If you want to use CosyVoice to synthesize speech for Speech-to-Video Generation, please install requirements_s2v.txt additionally
pip install -r requirements_s2v.txt
```


#### Model Download

| Models              | Download Links                                                                                                                              | Description |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| T2V-A14B    | 🤗 [Huggingface](https://huggingface.co/Wan-AI/Wan2.2-T2V-A14B)    🤖 [ModelScope](https://modelscope.cn/models/Wan-AI/Wan2.2-T2V-A14B)    | Text-to-Video MoE model, supports 480P & 720P |
| I2V-A14B    | 🤗 [Huggingface](https://huggingface.co/Wan-AI/Wan2.2-I2V-A14B)    🤖 [ModelScope](https://modelscope.cn/models/Wan-AI/Wan2.2-I2V-A14B)    | Image-to-Video MoE model, supports 480P & 720P |
| TI2V-5B     | 🤗 [Huggingface](https://huggingface.co/Wan-AI/Wan2.2-TI2V-5B)     🤖 [ModelScope](https://modelscope.cn/models/Wan-AI/Wan2.2-TI2V-5B)     | High-compression VAE, T2V+I2V, supports 720P |
| S2V-14B     | 🤗 [Huggingface](https://huggingface.co/Wan-AI/Wan2.2-S2V-14B)     🤖 [ModelScope](https://modelscope.cn/models/Wan-AI/Wan2.2-S2V-14B)     | Speech-to-Video model, supports 480P & 720P |
| Animate-14B | 🤗 [Huggingface](https://huggingface.co/Wan-AI/Wan2.2-Animate-14B) 🤖 [ModelScope](https://www.modelscope.cn/models/Wan-AI/Wan2.2-Animate-14B)  | Character animation and replacement | |



> 💡Note: 
> The TI2V-5B model supports 720P video generation at **24 FPS**.
