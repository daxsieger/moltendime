# mineworld Technical Notes

## Summary

MineWorld is a real-time interactive world model on Minecraft built around a visual-action autoregressive transformer. Inside the interactive-world-model family, it is one of the clearest benchmark peers to Matrix-Game because it shares the Minecraft world surface, action-following focus, and explicit real-time inference claims.

## Key Role

- Minecraft-first world-model benchmark peer
- Diagonal decoding as the main fast-inference technique
- Public split between web demo interaction and local evaluation reproduction
- Scripted metrics workflow after batched video generation

## Code-Grounded Runtime Surface

- `mineworld.py` is the interactive demo shell that maps button selections and camera deltas into model action indices.
- The demo path explicitly manages context exhaustion by trimming old frames and actions, refreshing KV cache, and re-prefilling the transformer.
- `diagonal_decoding.py` contains the real decoding substrate for top-k, top-p, multi-token decoding, and the image-diagonal schedule that reinserts action tokens at image-token boundaries.
- `inference.py` is the evaluation runtime that switches between `naive` and `image_diagd`, measures token throughput, and converts generated pixel tokens back into MP4 video.
- `lvm.py` is the integration layer that imports diagonal decoding helpers into the Llama-based transformer runtime.

## Operational Notes

- MineWorld is not only a README-described benchmark; it is a repo with explicit cache-management and decoding-control techniques worth reusing.
- The strongest reusable code insight is that interactivity, decoding strategy, and cache refresh are all surfaced as normal runtime controls rather than buried in model internals.

## README Preview

<div align="center">

# MineWorld <br> <sub>A Real-time Interactive World Model on Minecraft</sub>

[![arXiv](https://img.shields.io/badge/arXiv-Paper-red?logo=arxiv&logoColor=white)](https://arxiv.org/pdf/2504.08388) &ensp; [![Project](https://img.shields.io/badge/Project-Page-blue?logo=homepage&logoColor=white)](https://aka.ms/mineworld) &ensp; [![HuggingFace](https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Models-yellow)](https://huggingface.co/microsoft/mineworld)
</div>

We introduce MineWorld, an interactive world model on Minecraft that brings several key advancements over existing approaches: 
* 🕹️ **High generation quality**. Built on a visual-action autoregressive Transformer, MineWorld generates coherent, high-fidelity frames conditioned on both visuals and actions. 
* 🕹️ **Strong controllability**. We propose benchmarks for the action-following capacity, where MineWorld shows precise and consistent behavior. 
* 🕹️ **Fast inference speed**. With Diagonal Decoding, MineWorld achieves a generation rate of 4 to 7 frames per second, enabling real-time interaction in open-ended game environments. 

https://github.com/user-attachments/assets/2f5b4740-badd-453c-970d-061abd367f82

## 🔥 News
* May, 2025: The model checkpoints in the [Huggingface repo](https://huggingface.co/microsoft/mineworld) have been temporally taken down.
* April, 2025: 🚀 [MineWorld](https://github.com/microsoft/mineworld) was released!
* March, 2025: 🚀 The paper of [Diagonal Decoding](https://arxiv.org/pdf/2503.14070) was released!

## 🔧 Setup
1. Clone this repository and navigate to MineWorld folder:
```bash
git clone https://github.com/microsoft/mineworld.git
cd mineworld
```
2. We provide an `requirements.txt` file for setting up a pip environment.
```bash
# 1. Prepare conda environment
conda create -n mineworld python=3.10
# 2. Activate the environment
conda activate mineworld
# 3. install our environment
pip3 install -r requirements.txt
```

We recommend using high-end GPU for inference. We have done all testing and development using A100 and H100 GPU. 


## 🎈 Checkpoints
Download pre-trained models [here](https://huggingface.co/microsoft/mineworld). Each checkpoint has a corresponding config file with the same name in the `configs` folder in this repository. All models share the same vae checkpoint and config. The data structure is as follows:
```
└── checkpoints
    ├── 300M_16f.ckpt
    ├── 700M_16f.ckpt
    ├── 700M_32f.ckpt
    ├── 1200M_16f.ckpt
    └── 1200M_32f.ckpt
    └── vae
        ├── config.json
        └── vae.ckpt
└── validation
    └── validation.zip
└── gradio_scene
    ├── scene.mp4
    └── scene.jsonl
```

## 🚀 Inference
We provide two ways to use our model: interacting with it in a web demo, and running locally to reproduce the evaluation results in our paper. In addition to download the checkpoints and place them in the `checkpoints` folder, it is also required to download `scene.mp4` and `scene.jsonl` when running the web demo. Make sure they are placed in the same directory.

### Run Web Demo

To launch the webpage game, run the following command:
```bash
python mineworld.py --scene "path/to/scene.mp4"    
    --model_ckpt "path/to/ckpt" 
    --config "path/to/config" 
```

![image](assets/demo.png)

Once the demo is running, you can access the website through the local URL or the public URL displayed in the command line. Initialization and the first action may take some time due to compilation.

You can specify a reference frame using the `--reference_frame` option, which should be larger than `4` and smaller than the context length of the model (i.e., `16` or `32` depending on the model utilized). A higher reference frame number generally corresponds to better visual quality. Once the initial state has been set, perform the game actions by selecting options in each chatbox.
The game progresses when pressing the "Run" button, displaying the last `8` frames and the most recent frame separately. Players can also set an action count to repeat an action multiple times.

Explanations to the buttons in the web demo are as follows:
```
Start frame: select a frame in scene.mp4 with its frame index
Jump to start frame: use the selected frame as the initial state
Camera `X` and `Y`: control the camera movements between `-90` and `90` degrees
Other action buttons: same as the actions in Minecraft 
Generate video: save previous game progress
```

### Run Local Inference

To run inference locally, use the following command:

```bash
python inference.py \
        --data_root "/path/to/validation/dataset" \
        --model_ckpt "path/to/ckpt" \
        --config "path/to/config" \
        --demo_num 1 \
        --frames 15 \
        --accelerate-algo 'naive' \
        --top_p 0.8 \
        --output_dir "path/to/output"
```

Check `scripts/inference_16f_models.sh` for examples. To switch between naive autoregressive decoding and diagonal decoding, change the command `--accelerate-algo` to `naive` and `image_diagd` correspondingly. 

After the inference of a set of videos, you can compute the metrics and reproduce the numerical results in our paper, check and run the following scripts:
```bash 
bash scripts/setup_metrics.sh # only required in the first time
bash scripts/compute_metrics.sh 
```

The evalution outputs will have the following structure: 
```
└── videos 
    ├── inference_setting1
        ├── clip_1.mp4
        └── clip_1.json
    ├── inference_setting2
        ├── clip_1.mp4
        └── clip_1.json
└── metrics_log
    ├── fvd_inference_setting1.json
