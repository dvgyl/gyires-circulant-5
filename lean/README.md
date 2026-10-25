# Lean formalization

This directory is a single Lean 4 project containing a formal proof of the results of the paper in [`../preprints/`](../preprints/). The few statements of the paper that are checked only by computation are listed under `status.scope` in [`formalization.yaml`](formalization.yaml) and in [`docs/GyiresCirculant5.md`](docs/GyiresCirculant5.md).

- **Toolchain:** Lean 4.35.0 ([`lean-toolchain`](lean-toolchain)). Every source file uses Lean's module system.
- **Library:** Mathlib v4.35.0 (commit `56a005855ea17e0b0958f73ec801ae140b0a1679`); all dependency versions are pinned in [`lake-manifest.json`](lake-manifest.json).
- **Metadata:** [`formalization.yaml`](formalization.yaml), in the v0.4 format used by Palomar, a registry of Lean-verified results, records the sources, the scope, the authorship and, for each theorem compared by Comparator, the statement of the paper it corresponds to.
- **Formalization notes:** [`docs/GyiresCirculant5.md`](docs/GyiresCirculant5.md) maps each statement in the paper to its Lean declarations.

The library `Circulant5` was written by ChatGPT (OpenAI, GPT-6 with Pro reasoning) for Lean 4.19. Claude Opus 5.5 later ported it to Lean 4.35 and the module system, replaced its comments by module documentation, and wrote [`Circulant5/MathlibStatements.lean`](Circulant5/MathlibStatements.lean) and the Challenge and Solution modules; see [`../AUTHORSHIP.md`](../AUTHORSHIP.md). [`Circulant5/PermanentGram.lean`](Circulant5/PermanentGram.lean) is adapted, with attribution, from the formalization of the case $`n=4`$ by C. Ozols.

## Layout

| Path | Contents |
|---|---|
| [`Challenges/GyiresCirculant5.lean`](Challenges/GyiresCirculant5.lean) | The principal theorems, stated with Mathlib's definitions only (`Matrix.permanent`, `Matrix.circulant`, `doublyStochastic`), with a docstring explaining each statement and its source, and with the proofs left as `sorry`. These are the statements a reader needs to audit. |
| [`Solutions/GyiresCirculant5.lean`](Solutions/GyiresCirculant5.lean) | The same theorems, word for word, proved from the library. |
| [`comparator/gyires-circulant5.json`](comparator/gyires-circulant5.json) | The Comparator configuration naming the ten theorems that must match. |
| [`Circulant5/Definitions.lean`](Circulant5/Definitions.lean), [`MatrixProducts.lean`](Circulant5/MatrixProducts.lean), [`MatrixBridge.lean`](Circulant5/MatrixBridge.lean), [`Defects.lean`](Circulant5/Defects.lean) | The circulant `circ w`, the polynomial `P5`, the vectors `gram` and `conv`, the products of circulants, the identification of `P5` with the permanent, and the two defects. |
| [`Circulant5/PermanentGram.lean`](Circulant5/PermanentGram.lean) | The comparison `2 per(M Nᵀ) ≤ per(M Mᵀ) + per(N Nᵀ)` and its consequence `P5 (conv w) ≤ P5 (gram w)`. |
| [`Circulant5/OrderCover.lean`](Circulant5/OrderCover.lean), [`Symmetry.lean`](Circulant5/Symmetry.lean) | The affine maps of `ZMod 5`, the six canonical orderings, the reduction of every weight vector to a chamber, and the affine invariance of the defects. |
| [`Circulant5/ListPolynomial.lean`](Circulant5/ListPolynomial.lean) to [`ChamberPolynomials.lean`](Circulant5/ChamberPolynomials.lean) | Polynomials as coefficient lists, the expansion of the defect in the smallest weight $`z_0`$ and the first gap $`z_1`$, and the six chamber polynomials. |
| [`Circulant5/CompactInputs/`](Circulant5/CompactInputs/), [`Circulant5/Coefficients/`](Circulant5/Coefficients/) | Generated certificate files (138 in all): for each chamber, the explicit coefficients of the chamber polynomial, each proved equal to the corresponding expansion coefficient by `ring` and nonnegative by `positivity`. |
| [`Circulant5/Strong0.lean`](Circulant5/Strong0.lean) to [`Strong5.lean`](Circulant5/Strong5.lean) | The margin `484 (z₁¹⁰ + ⋯ + z₄¹⁰)` in each of the six chambers. |
| [`Circulant5/Theorems.lean`](Circulant5/Theorems.lean), [`Normalization.lean`](Circulant5/Normalization.lean), [`Corollaries.lean`](Circulant5/Corollaries.lean) | The strong inequality, Gyires's inequality, their equality cases, the positive denominator and the normalized ratio. |
| [`Circulant5/Examples.lean`](Circulant5/Examples.lean) | The two-point example $`w=(t,t,0,0,0)`$ and the sharpness of `484` in the canonical chambers. |
| [`Circulant5/MathlibStatements.lean`](Circulant5/MathlibStatements.lean) | The translation to Mathlib's `Matrix.circulant` and `doublyStochastic`; the margin for an arbitrary weight vector sorted by an arbitrary permutation, with its attainment and sharpness; the uniqueness of the reduction to a canonical ordering. |
| [`Circulant5/Remarks.lean`](Circulant5/Remarks.lean) | Remarks of the paper: the reduction of Gyires's inequality to the strong inequality for matrices of every size, the case $`n=2`$ of the conjecture, and the description of the doubly stochastic circulants of order five. |
| [`scripts/`](scripts/) | [`verify-comparator.sh`](scripts/verify-comparator.sh), which runs Comparator on the configuration. |

## The statements checked by Comparator

[Comparator](https://github.com/leanprover/comparator), shipped with Lean as `lake comparator`, builds the Challenge module and its Solution module in a sandbox. It checks that every listed theorem of the Solution has exactly the statement of the Challenge, that it uses no axiom beyond `propext`, `Classical.choice` and `Quot.sound`, and that Lean's kernel accepts the proofs. The script described under [Running Comparator](#running-comparator) also replays the proofs through the independent NanoDa and con-ron kernels.

| Configuration | Theorems | Content |
|---|---|---|
| [`gyires-circulant5.json`](comparator/gyires-circulant5.json) | 10 | Gyires's inequality, its equality case and the positive denominator for doubly stochastic circulants of order five; the homogeneous and the strong inequalities with their equality cases for nonnegative circulants; the margin in sorted-gap coordinates, its attainment and the sharpness of its constant `484`. |

The configuration is accepted by Lean's kernel, NanoDa and con-ron; the output is in [`../verification/results/comparator.log`](../verification/results/comparator.log).

## Building

Install [elan](https://github.com/leanprover/elan), which selects the pinned Lean version. Then, from this directory:

```sh
lake exe cache get   # optional: download prebuilt Mathlib instead of compiling it
lake build           # the library, the Challenge and the Solution
```

A full build of the library compiles 170 modules; the 138 generated certificate files take most of the time.

## Running Comparator

On Linux with [bubblewrap](https://github.com/containers/bubblewrap) installed, from this directory:

```sh
scripts/verify-comparator.sh
```

## Axiom audit

[`../verification/AxiomAudit.lean`](../verification/AxiomAudit.lean) asks Lean for the axioms behind each theorem cited in the paper and each theorem compared with the Challenge, and then scans every declaration of the library and of the Solution; [`../verification/ScanControl.lean`](../verification/ScanControl.lean) checks that the same scan detects the `sorry` placeholders of the Challenge:

```sh
lake env lean ../verification/AxiomAudit.lean > ../verification/results/axiom_audit.txt
python3 ../verification/check_axioms.py ../verification/results/axiom_audit.txt
lake env lean ../verification/ScanControl.lean
```

Every theorem depends only on `propext`, `Classical.choice` and `Quot.sound`. Apart from the deliberate placeholders in `Challenges/`, the sources contain no `sorry`, and no `axiom`, `admit`, `native_decide`, `implemented_by` or `extern`.

## Key definitions

- `Circulant5.circ w` is the circulant with entries `w (j - i)`; Mathlib's `Matrix.circulant v`, used in the Challenge, has entries `v (i - j)`, and `Circulant5.circulant_eq_transpose_circ` identifies `Matrix.circulant v` with the transpose of `circ v`.
- `Circulant5.P5 w` is the permanent of `circ w` written out as a polynomial (`Circulant5.permanent_circ`).
- `Circulant5.gram w k = ∑ i, w i * w (i + k)` and `Circulant5.conv w k = ∑ i, w i * w (k - i)`.
- `Circulant5.strongDefect w = 625 P(w)² - 24 P(g(w))` and `Circulant5.gyiresDefect w = 625 P(w)² - 12 (P(g(w)) + P(h(w)))`.
- `Circulant5.affine a b` is the affine map `i ↦ (a + 1) i + b` of `ZMod 5` (for `a : Fin 4`, `b : Fin 5`), and `Circulant5.canonicalWeights k z` is the weight vector whose entry at position `canonicalOrders k j` is `z 0 + ⋯ + z j`.
