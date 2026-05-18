# websplatter-arxiv-2602-03207 Memory Notes

- Paper URL: https://arxiv.org/abs/2602.03207
- HTML URL: https://arxiv.org/html/2602.03207v1
- Title: WebSplatter: Enabling Cross-Device Efficient Gaussian Splatting in Web Browsers via WebGPU
- Authors: Yudong Han, Chao Xu, Xiaodan Ye, Weichen Bi, Zilong Dong, Yun Ma
- Organizations: Peking University Institute for Artificial Intelligence and Alibaba Tongyi Lab
- Submission date: 2026-02-03
- Subjects: Graphics, Computer Vision and Pattern Recognition, Performance
- Implementation note: the paper reports an implementation in TypeScript and WGSL with about 6,600 lines of code.
- Core pipeline: preprocess, wait-free sort, rasterization.
- Core algorithmic contribution: wait-free hierarchical radix sort that avoids cross-workgroup spin waiting on WebGPU.
- Core culling contribution: opacity-aware geometry culling and dynamic quad sizing.
- Headline result: the abstract reports 1.2x to 4.5x speedups over state-of-the-art web viewers.
- Conclusion note: the conclusion emphasizes 1.06x to 2.26x speedups across representative devices.
- Stability note: the paper links wait-free sorting to lower jitter and better cross-device stability.
- Memory note: peak VRAM on the garden scene is reported near 1.20 GB, lower than competing WebGPU baselines.
- Device lesson: render-bound and preprocess-bound behavior shift by device tier and scene complexity.
- Ownership note: extracted paper skills belong operationally to the dedicated paper persona.
- Archivist note: system archivists should catalog the paper bundle and persona for discovery and audit.
