# GameFactory Dataset Preprocessing Guide

## Purpose

This guide turns the public `detection.py` and `visualize.py` scripts into one reproducible dataset-auditing workflow.

It is not a training guide. It is the smallest reliable path for taking raw GF-Minecraft-style clips and producing derived action metadata plus visual control overlays.

## Expected Input Layout

Start from a dataset directory with this structure:

```text
<dir_name>/
  video/
    seed_1_part_1.mp4
    ...
  metadata/
    seed_1_part_1.json
    ...
```

The `video/` and `metadata/` basenames must match.

## Step 1: Preserve The Raw Metadata Directory

- Keep the original `metadata/` directory unchanged.
- Treat all motion-derived fields as build artifacts, not manual edits.
- The detection pipeline intentionally writes into a parallel `metadata-detection/` directory.

## Step 2: Rebuild Derived Action Metadata

Run the detection script on the dataset root:

```bash
python detection.py --dir_name /path/to/GF-Minecraft/data_2003
```

Optional thresholds:

```bash
python detection.py \
  --dir_name /path/to/GF-Minecraft/data_2003 \
  --threshold 0.01 \
  --height_threshold 0.01
```

What this step does:

- clears any previous `metadata-detection/` output
- loads each matching MP4 and JSON pair
- computes `delta_pos` between consecutive action frames
- flags low-displacement frames as `collision`
- flags low-height jumps as `jump_invalid`
- suppresses repeated jumps within one continuous jump sequence

## Step 3: Inspect The Derived Metadata Contract

After detection, each action frame in `metadata-detection/*.json` should expose these extra fields:

- `delta_pos`
- `collision`
- `jump_invalid`

The practical rule is simple: downstream consumers should read derived action quality from `metadata-detection/`, while provenance stays in the original `metadata/` folder.

## Step 4: Prepare A Compact Action Schedule For Visual Audit

`visualize.py` expects a compact configuration that describes control segments rather than one explicit record per frame.

Each segment contains:

- an end frame
- one action string with keyboard states and mouse deltas
- one trailing string that lists jump frames for `Space`

The built-in example uses:

```python
selected_config = [[25, "0 0 0 0 0 0 0 0 0.5"], [77, "1 0 0 0 0 0 0 0 0"], ""]
```

Operationally, the script expands that compact schedule into per-frame key states plus cumulative mouse coordinates.

## Step 5: Render Input Overlays On Top Of Video

Place the audit assets next to the script or adjust the hard-coded paths:

- `input.mp4`
- `mouse.png`

Then run:

```bash
python visualize.py
```

What this step does:

- converts compact segments into per-frame keyboard booleans
- integrates mouse deltas into an absolute cursor path
- draws pressed-key overlays directly on the frame
- composites the mouse icon with scaling, rotation, and bounds clipping
- writes a playable audit video to `output.mp4`

## Step 6: Review Failure Modes Before Reusing Clips

Inspect both artifacts together:

- `metadata-detection/*.json` for rule-based action quality flags
- `output.mp4` for human-visible control alignment

Reject or reprocess clips when:

- jump-heavy sequences accumulate invalid jumps
- collision flags stay high during intended movement segments
- mouse overlays drift away from the expected camera behavior
- the rendered key overlays do not match the intended control schedule

## Recommended Workflow

1. ingest raw `video/` and `metadata/`
2. rebuild `metadata-detection/`
3. spot-check derived JSON for motion flags
4. render overlay videos for representative clips
5. only then promote clips into downstream training or evaluation subsets

## Why This Matters

The reusable value in GameFactory's public code is not only the high-level idea of decoupled control.

It is also the discipline of turning action metadata into an auditable artifact: first by deterministic rule-based enrichment, then by rendering the controls back onto the video for human inspection.