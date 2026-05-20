# open-oasis Technical Notes

## Summary

Open Oasis is a narrow public inference repository for Oasis 500M. It is not the full product surface of Oasis; instead it exposes a compact action-conditional generation path that is useful as a benchmark-adjacent import inside the interactive-world-model family.

## Key Role

- Public 500M action-conditional inference slice of Oasis
- Keyboard-controlled gameplay generation
- Prompt-frame bootstrapping from video or image
- Minimal runtime surface built around one generation script and two checkpoints

## Code-Grounded Runtime Surface

- `generate.py` is the real controlling path for public inference.
- The runtime loads a DiT and a VAE separately, allowing `.pt` and `.safetensors` checkpoints.
- Prompt inputs are normalized through `utils.py` into a fixed `1 x t x c x h x w` tensor contract at `360x640` resolution.
- Action inputs are normalized through `utils.py` into a one-hot stream with an added initial no-op frame.
- The rollout uses a diffusion-forcing style loop that appends one latent frame at a time, stabilizes prior context frames, and crops the active context to the transformer's maximum frame window.

## Backbone Notes

- `attention.py` decomposes the backbone into temporal axial attention and spatial axial attention rather than one flat spatiotemporal block.
- Temporal attention is causal and uses rotary treatment for the time axis, while spatial attention applies axial rotary frequencies over the pixel grid.
- `vae.py` exposes a patchified transformer-style autoencoder with an explicit diagonal Gaussian latent interface.
- This means Open Oasis is not only a thin runtime wrapper; it also contains reusable backbone design choices for video attention and transformer-native VAE design.

## Architectural Notes

- `dit.py` exposes the timestep-conditioning and patch-embedding surface rather than a large application shell.
- This is why the repository stays operationally narrow even though the internal generation logic is nontrivial.

## README Preview

# Oasis 500M

![](./media/arch.png)

![](./media/thumb.png)

Oasis is an interactive world model developed by [Decart](https://www.decart.ai/) and [Etched](https://www.etched.com/). Based on diffusion transformers, Oasis takes in user keyboard input and generates gameplay in an autoregressive manner. We release the weights for Oasis 500M, a downscaled version of the model, along with inference code for action-conditional frame generation. 

For more details, see our [joint blog post](https://oasis-model.github.io/) to learn more.

And to use the most powerful version of the model, be sure to check out the [live demo](https://oasis.us.decart.ai/) as well!

## Setup
```
git clone https://github.com/etched-ai/open-oasis.git
cd open-oasis
# Install pytorch
pip install torch torchvision --index-url https://download.pytorch.org/whl/cu121
# Install other dependencies
pip install einops diffusers timm av
```

## Download the model weights
Inside the `open-oasis/` directory, run:
```
huggingface-cli login
huggingface-cli download Etched/oasis-500m oasis500m.safetensors # DiT checkpoint
huggingface-cli download Etched/oasis-500m vit-l-20.safetensors  # ViT VAE checkpoint
```

## Basic Usage
We include a basic inference script that loads a prompt frame from a video and generates additional frames conditioned on actions.
```
python generate.py
# Or specify path to checkpoints:
python generate.py --oasis-ckpt <path to oasis500m.safetensors> --vae-ckpt <path to vit-l-20.safetensors>
```
Use a custom image prompt:
```
python generate.py --prompt-path <path to .png, .jpg, or .jpeg>
```
The resulting video will be saved to `video.mp4`. Here's are some examples of a generation from this 500M model!

![](media/sample_0.gif)
![](media/sample_1.gif)
