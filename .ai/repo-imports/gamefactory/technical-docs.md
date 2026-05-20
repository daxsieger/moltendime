# gamefactory Technical Notes

## Summary

GameFactory is an interactive-video framework for creating new games with generative video models. Inside the interactive-world-models family, it is an alternative and complementary peer to Matrix-Game: both care about controllability and game-like rollout, but GameFactory emphasizes scene generalization and new-game creation through decoupled action control.

## Key Role

- Alternative interactive-video peer for new-game creation
- Decoupled action-control module over a pre-trained large video model
- Multi-phase training for preserving open-domain generalization
- GF-Minecraft dataset as the control-learning substrate

## Code-Grounded Operational Surface

- `detection.py` is the dataset-cleaning and metadata-enrichment path, not just a helper script.
- The script rewrites action JSON into a derived `metadata-detection` directory with extra motion-derived flags such as `collision`, `jump_invalid`, and `delta_pos`.
- Its event logic is intentionally two-pass: threshold-based detection first, sequence cleanup second.
- `visualize.py` is the control-debug surface for turning compact action schedules into per-frame keyboard and mouse overlays on rendered video.

## Practical Reuse

- GameFactory currently exposes more operational value in dataset/action-processing and audit tooling than in public model-training code.
- The reusable insight is not only conceptual decoupling; it is also that action quality can be improved with deterministic metadata post-processing and direct visual playback of controls.

## Family Relevance

- GameFactory is closer to `matrix-game` and `open-oasis` than to `wan-2-2` because it treats action-controllable video as a world-model-like interaction problem.
- It is complementary rather than redundant: its strongest distinct signal is scene generalization and game creation beyond one fixed environment style.

## Comparison Posture

- Relative to `matrix-game`, GameFactory is a creation peer rather than a continuation peer.
- Relative to `mineworld` and `open-oasis`, it contributes dataset curation and action-auditing patterns more than public rollout/runtime patterns.

## README Preview

## ___***GameFactory: Creating New Games with Generative Interactive Videos***___
<div align="center">
<img src='./imgs/logo.png' style="height:120px"></img>

 <a href='https://yujiwen.github.io/gamefactory/'><img src='https://img.shields.io/badge/Project-Page-Green'></a> &nbsp;
 <a href='https://arxiv.org/abs/2501.08325'><img src='https://img.shields.io/badge/arXiv-2501.08325-b31b1b.svg'></a> &nbsp;
 <a href='https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset'><img src='https://img.shields.io/badge/%F0%9F%A4%97%20Hugging%20Face-Dataset-blue'></a> &nbsp;

**[Jiwen Yu<sup>1*&dagger;</sup>](https://yujiwen.github.io/), 
[Yiran Qin<sup>1*</sup>](https://github.com/IranQin), <br>
[Xintao Wang<sup>2&ddagger;</sup>](https://xinntao.github.io/), 
[Pengfei Wan<sup>2</sup>](https://scholar.google.com/citations?user=P6MraaYAAAAJ&hl=en),
[Di Zhang<sup>2</sup>](https://openreview.net/profile?id=~Di_ZHANG3),
[Xihui Liu<sup>1&ddagger;</sup>](https://xh-liu.github.io/)** 
<br>
<sup>1</sup>The University of Hong Kong
<sup>2</sup>Kuaishou Technology
<br>
&dagger;: Intern at KwaiVGI, Kuaishou Technology, *: Equal Contribution, &ddagger;: Corresponding Authors

</div>

## 📖 Introduction

<div align="center">
    <img src="./imgs/concept.jpg" alt="Annotation process using MiniCPM-V" width="600"/>
    <p><i>Schematic of our GameFactory creating new games based on pre-trained large video generation models.</i></p>
</div>


GameFactory is a novel framework designed to tackle the challenge of scene generalization in game video generation. Existing methods often struggle with fixed styles and environments, limiting their ability to create diverse and novel games. As shown in the schematic, GameFactory achieves this by combining the open-domain generative power of pre-trained large video generation models with an action control module learned from a small, high-quality dataset, [**GF-Minecraft**](https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset). This decoupling of game style learning and action control, implemented through a multi-phase training strategy, allows the framework to retain its open-domain generalization capabilities while enabling action-controllable video generation.

GameFactory also has the potential to serve as a **<span style="color:red;">generalizable world model</span>**, capable of generalizing actions within games and potentially extending to other domains, such as autonomous driving and embodied AI. While these broader applications remain an exciting avenue for future exploration, our framework lays the foundation for such possibilities by demonstrating strong generalization capabilities within the context of game development.

## 🔥 Release News
- `[2025/1/14]` Release [paper](https://arxiv.org/pdf/xxxx.xxxxx), [project page](https://vvictoryuki.github.io/gamefactory), [dataset](https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset).

## 🚀 GF-Minecraft Dataset
### 1. Dataset Introduction

The [**GF-Minecraft Dataset**](https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset) is designed to meet three key requirements for action-controllable video generation: 
1. **Customizable actions** for cost-effective, large-scale data collection.
2. **Unbiased action sequences** to ensure diverse and low-probability action combinations.
3. **Diverse scenes** with textual descriptions to capture scene-specific physical dynamics.

We use [**Minecraft**](https://minedojo.org/) as the data collection platform due to its comprehensive API, diverse open-world environment, and extensive action space. By executing predefined, randomized action sequences, we collected **70 hours of gameplay video** with action annotations.

To enhance diversity, we preconfigured three biomes (forest, plains, desert), three weather conditions (clear, rain, thunder), and six times of day (e.g., sunrise, noon, midnight), resulting in more than **2,000 video clips**. Each clip contains **2,000 frames** and is paired with textual descriptions generated by the multimodal language model [**MiniCPM-V**](https://github.com/OpenBMB/MiniCPM-V) (examples shown below). This dataset provides a strong foundation for training action-controllable and generalizable game video generation models.

<div align="center">
    <img src="./imgs/annotation.jpg" alt="Annotation process using MiniCPM-V" width="600"/>
    <p><i>An example of video clip annotation, where words describing scenes and objects are highlighted in red and bolded.</i></p>
</div>


### 2. File Structure
The **GF-Minecraft Dataset** can be downloaded from [**HuggingFace**](https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset). Upon download, the dataset will be organized as follows:
```
GF-Minecraft
├── data_2003
│   ├── part_aa
│   ├── part_ab
│   ├── part_ac
│   ├── part_ad
│   ├── part_ae
│   └── part_af
└── data_269.zip
```
To prepare the dataset for use, navigate to the `data_2003` folder and merge the parts into a single zip file using the following command:
```bash
cat part_* > data_2003.zip
```
After extracting `data_2003.zip` and `data_269.zip`, the dataset will be organized as follows:
```
GF-Minecraft
├── data_2003
│   ├── annotation.csv
│   ├── metadata
│   │   ├── seed_1_part_1.json
│   │   ├── seed_2_part_2.json
│   │   ├── seed_3_part_3.json
│   │   └── ...
│   └── video
│       ├── seed_1_part_1.mp4
│       ├── seed_2_part_2.mp4
│       ├── seed_3_part_3.mp4
│       └── ...
└── data_269
    ├── annotation.csv
    ├── metadata
    │   ├── seed_1_part_1.json
    │   ├── seed_2_part_2.json
    │   ├── seed_3_part_3.json
    │   └── ...
    └── video
        ├── seed_1_part_1.mp4
        ├── seed_2_part_2.mp4
        ├── seed_3_part_3.mp4
        └── ...
```
We have also placed a file `sample-10.zip`([link](https://huggingface.co/datasets/KwaiVGI/GameFactory-Dataset/blob/main/GF-Minecraft/sample-10.zip)) in the `GF-Minecraft/` directory, which contains 5 video files and their corresponding metadata from both `data_2003/` and `data_269/` folders. This can be used for quick reference of the file format.

#### Directory Details

1. **`annotation.csv`**: A CSV file containing the textual descriptions for all video clips. Each row corresponds to a video clip and includes the following columns:
   - **Original video name**: The name of the original video from which the clip is extracted.
   - **Start frame index**: The starting frame of the clip within the original video.
   - **End frame index**: The ending frame of the clip within the original video.
   - **Prompt**: The textual description associated with the clip.

2. **`metadata/`**: A folder containing JSON files with detailed metadata for each video clip.

3. **`video/`**: A folder containing the video files in `.mp4` format. The filenames (e.g., `seed_1_part_1.mp4`) correspond to their associated metadata and annotation records.

#### Explanation of Dataset Parts

- **`data_2003/`**: Contains the first part of the dataset, including both mouse movement actions and keyboard actions.

- **`data_269/`**: Contains the second part of the dataset, similarly structured to `data_2003/`, but includes only keyboard actions.
