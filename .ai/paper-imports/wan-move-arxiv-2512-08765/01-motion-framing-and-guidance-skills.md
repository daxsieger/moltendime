# Wan-Move Paper Skills 01-10

## Skill 01: Frame Motion Control as a Guidance Representation Problem
- evidence: Section 1
- method: Reduce the motion-control challenge to two core decisions: how to represent motion guidance and how to inject it into generation.
- transfer: Start controllable-video research by isolating representation and fusion as separate design axes.

## Skill 02: Favor Dense Guidance When Local Motion Precision Matters
- evidence: Section 1
- method: Prefer dense representations over boxes or masks when local, articulated, or region-level control is required.
- transfer: Use dense control signals when coarse object steering is insufficient for practical editing tasks.

## Skill 03: Use Point Trajectories as a Fine-Grained but Editable Motion Interface
- evidence: Abstract, Section 1
- method: Represent object motion with dense point trajectories to support both local and global movement control.
- transfer: Choose guidance signals that are easy to author yet expressive enough for precise motion editing.

## Skill 04: Reject Auxiliary Motion Encoders When They Hurt Scalability
- evidence: Abstract, Section 1, Section 2
- method: Avoid separate motion encoders or ControlNet-style processing modules if the base model can be guided directly.
- transfer: Preserve training scalability by minimizing architecture growth around a strong foundation model.

## Skill 05: Make Existing Condition Features Motion-Aware Instead of Adding New Branches
- evidence: Abstract, Section 1
- method: Inject motion by editing the original condition features rather than introducing a standalone motion pathway.
- transfer: Reuse preexisting conditioning surfaces before designing new neural branches.

## Skill 06: Preserve Appearance Context While Injecting Motion
- evidence: Section 1, Section 3.2
- method: Propagate first-frame features so the guidance carries texture and local appearance context, not just coordinates.
- transfer: Couple motion cues to appearance-bearing features when controllability and visual coherence must both improve.

## Skill 07: Treat No-Architecture-Change Integration as a Contribution, Not a Convenience
- evidence: Abstract, Section 1, Section 6
- method: Position architecture preservation as a core reason the approach scales.
- transfer: When extracting paper skills, keep integration simplicity as a first-class systems property.

## Skill 08: Build on a Strong Open I2V Base Instead of Re-Training the Whole Stack
- evidence: Abstract, Section 2, Section 5.1
- method: Use Wan-I2V-14B as the backbone and fine-tune only the controllability layer of behavior.
- transfer: Piggyback on strong open video backbones when adding a specialized control capability.

## Skill 09: Tie Research Value to Creator-Facing Use Cases
- evidence: Section 1, Section 5.4
- method: Justify the method through controllable applications such as object control, camera motion, motion transfer, and 3D rotation.
- transfer: Preserve downstream user tasks as evidence anchors for research-persona extraction.

## Skill 10: Pair the Method with a Benchmark Contribution Early
- evidence: Abstract, Section 1
- method: Introduce MoveBench as part of the core contribution set rather than as a secondary appendix artifact.
- transfer: When a paper creates both a method and an evaluation asset, extract both as first-level skills.
