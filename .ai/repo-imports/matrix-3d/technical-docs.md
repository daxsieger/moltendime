# matrix-3d Technical Notes

## Summary

Matrix-3D is an explorable-scene generation system that couples panoramic video synthesis with panoramic 3D reconstruction. Its core distinction from Matrix-Game is that it targets omnidirectional scene coverage and free exploration rather than action-conditioned interactive gameplay rollouts.

## Core Framing

- Panoramic representation is the central scene abstraction.
- The system combines conditional video generation and 3D reconstruction instead of treating one as post-processing for the other.
- The repo supports both image-to-scene and text-to-scene workflows.

## Operational Posture

- The model package is broken into named stages such as text-to-panorama, panoramic video generation, and panoramic reconstruction.
- The repo emphasizes speed-quality tradeoffs with multiple reconstruction modes.
- The release also emphasizes memory-aware deployment, including low-VRAM options for some variants.

## Adjacency

- Matrix-3D is the natural scene-generation sibling of Matrix-Game inside the interactive-world-model family.
- Matrix-Game is the stronger reference when the target is interactive long-sequence control.
- Matrix-3D is the stronger reference when the target is explorable panoramic 3D scene creation.

## README Preview

<h1 align="center">
    Matrix-3D: Omnidirectional Explorable <br>3D World Generation
</h1>
<div align="center">
  <img src="./asset/logo.PNG" alt="logo" width="800" style="margin-bottom: 5px;"/>  
</div>


<div align="center">

[![📄 Project Page](https://img.shields.io/badge/📄-Project_Page-orange)](https://matrix-3d.github.io/)
[![Hugging Face Model](https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-blue?style=flat)](https://huggingface.co/Skywork/Matrix-3D)
![Badge](https://img.shields.io/badge/version-v0.1.0-green)
[![Technical report](https://img.shields.io/badge/arXiv-Report-b31b1b?style=flat&logo=arxiv&logoColor=white)](https://arxiv.org/pdf/2508.08086)

</div>



## 🌟 Introduction
**Matrix-3D** utilizes panoramic representation for wide-coverage omnidirectional explorable 3D world generation that combines conditional video generation and panoramic 3D reconstruction.  
- **Large-Scale Scene Generation** : Compared to existing scene generation approaches, Matrix-3D supports the generation of broader, more expansive scenes that allow for complete 360-degree free exploration.
- **High Controllability** : Matrix-3D supports both text and image inputs, with customizable trajectories and infinite extensibility.
- **Strong Generalization Capability** : Built upon self-developed 3D data and video model priors, Matrix-3D enables the generation of diverse and high-quality 3D scenes.
- **Speed-Quality Balance**: Two types of panoramic 3D reconstruction methods are proposed to achieve rapid and detailed 3D reconstruction respectively.


## 🗞️ News
- Sep 02, 2025: 🎉 We provide a 5B model with low-VRAM mode which only requires 12G VRAM! 
- Aug 29, 2025: 🎉 We provide a [gradio demo](https://github.com/SkyworkAI/Matrix-3D/tree/main?tab=readme-ov-file#%EF%B8%8F-gradio-demo) for Matrix-3D!
- Aug 25, 2025: 🎉 We provide a  [script](#lowvram) for running the generation process with 19G VRAM!
- Aug 12, 2025: 🎉 We release the code, technical report and project page of Matrix-3D!


## Image-to-Scene Generation
<table border="1">

<tr>
  <th>Image</th>
  <th>Panoramic Video</th>
  <th>3D Scene</th>
</tr>
<tr>
<tr>
  <td width="210" height="150" style="
  padding: 15px;
  border: 1px solid rgba(168,237,234,0.5);
  border-radius: 8px;
  background-color: rgba(10,20,30,0.7);
  position: relative;
  text-align: center;
  vertical-align: top;
  font-family: 'Palatino', 'Georgia', serif;">
  
  <img src="asset/i2p/i2p_2.png" style="width: 200px; border-radius: 6px;"><br>

</td>
  <td><img src="asset/i2p/i2p_2.gif"  height="150" width="300"></td>
  <td><img src="asset/i2p/i2p_2_3D.gif" height="150"></td>
</tr>

<tr>
  <th>Image</th>
  <th>Panoramic Video</th>
  <th>3D Scene</th>
</tr>
<tr>
  <td width="210" height="150" style="
  padding: 15px;
  border: 1px solid rgba(168,237,234,0.5);
  border-radius: 8px;
  background-color: rgba(10,20,30,0.7);
  position: relative;
  text-align: center;
  vertical-align: top;
  font-family: 'Palatino', 'Georgia', serif;">
  
  <img src="asset/i2p/i2p_1.png" style="width: 200px; border-radius: 6px;"><br>
</td>
  <td><img src="asset/i2p/i2p_1.gif"  height="150" width="300"></td>
  <td><img src="asset/i2p/i2p_1_3D.gif" height="150"></td>
</tr>
</table>


## Text-to-Scene Generation

<table border="1">
<tr>
  <th>Text</th>
  <th>Panoramic Video</th>
  <th>3D Scene</th>
</tr>
<tr>
  <th width="200" style="
  font-family: 'Palatino', 'Georgia', serif;
  font-size: 1.3em;
  color: transparent;
  background: 
    linear-gradient(45deg, 
      #a8edea 0%, 
      #fed6e3 50%, 
      #a8edea 100%);
  -webkit-background-clip: text;
  background-clip: text;
  text-shadow: 
    0 0 5px rgba(168,237,234,0.3),
    0 0 10px rgba(254,214,227,0.3);
  padding: 15px;
  border: 1px solid rgba(168,237,234,0.5);
  border-radius: 8px;
  background-color: rgba(10,20,30,0.7);
  position: relative;
  overflow: hidden;
">
  <div style="
    position: absolute;
    top: -10px;
    left: -10px;
    right: -10px;
