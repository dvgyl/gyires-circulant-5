# Correspondence between the paper and the Lean declarations

Accompanying paper: [Gyires's permanent inequality for nonnegative circulant matrices of order five](../../preprints/Gyires-inequality-for-circulants-of-order-five/paper.pdf)

## Scope

The library is in [`Circulant5/`](../Circulant5/), in the namespace `Circulant5`. There `circ w` is the circulant with entries `circ w i j = w (j - i)` for a weight vector `w : Fin 5 → ℝ`, `P5 w` is the explicit polynomial of Lemma 2.2 of the paper, and `gram w`, `conv w` are the circular autocorrelation $`g(w)`$ and self-convolution $`h(w)`$. `strongDefect` and `gyiresDefect` are the defects $`D_s`$ and $`D_G`$. `Fin 5`, with its arithmetic modulo five, plays the role of $`\mathbb{Z}/5\mathbb{Z}`$.

The principal statements are restated with Mathlib's definitions only in [`Challenges/GyiresCirculant5.lean`](../Challenges/GyiresCirculant5.lean) (namespace `GyiresCirculant5`) and proved in [`Solutions/GyiresCirculant5.lean`](../Solutions/GyiresCirculant5.lean). There a circulant is `Matrix.circulant v`, with entries `v (i - j)`: the transpose of `circ v`, describing the same set of matrices.

Every declaration below depends only on Lean's standard axioms (`propext`, `Classical.choice`, `Quot.sound`). The remarks in the paper's Discussion section are not formalized, except for the two-point example.

## Statements

| Statement in the paper | Lean declaration(s) |
| --- | --- |
| Theorem 3.1 (strong inequality and equality case) | `GyiresCirculant5.strong_inequality`, `GyiresCirculant5.strong_inequality_eq_iff`; in the library `Circulant5.strong_matrix_inequality`, `Circulant5.strong_matrix_equality_iff` |
| Theorem 3.2 (margin and sharpness of 484) | `GyiresCirculant5.strong_margin`, `GyiresCirculant5.strong_margin_sharp`; in the library `Circulant5.strongDefect_margin`, `Circulant5.strongDefect_margin_sharp` |
| Corollary 3.3, homogeneous form and equality case | `GyiresCirculant5.gyires_homogeneous`, `GyiresCirculant5.gyires_homogeneous_eq_iff`; `Circulant5.gyires_matrix_inequality`, `Circulant5.gyires_matrix_equality_iff` |
| Corollary 3.3, ratio form, equality at $`J_5`$, positive denominator | `GyiresCirculant5.gyires_ratio`, `GyiresCirculant5.gyires_ratio_eq_iff`, `GyiresCirculant5.gyires_denominator_pos`; `Circulant5.normalizedGyiresRatio`, `Circulant5.normalizedGyiresRatio_eq_iff`, `Circulant5.positiveDenominator` |
| Lemma 2.1 (products of circulants) | `Circulant5.circ_mul_transpose`, `Circulant5.transpose_mul_circ`, `Circulant5.circ_mul_self` |
| Lemma 2.2 (the 26-term polynomial) | `Circulant5.permanent_circ` |
| Lemma 2.3, Corollary 2.4 (Gram comparison) | `Circulant5.PermanentGram.permanent_gram_add_ge`, `Circulant5.conv_permanent_le_gram` |
| Lemma 4.1 (affine symmetry) | `Circulant5.P5_affine`, `Circulant5.gram_affine`, `Circulant5.conv_affine`, `Circulant5.strongDefect_affine`, `Circulant5.gyiresDefect_affine` |
| Lemma 4.2 (six chambers) | `Circulant5.order_affine_cover`, `Circulant5.order_affine_cover_unique`, `Circulant5.canonical_chamber_of_monotone`, `Circulant5.exists_canonical_chamber` |
| Lemma 4.3 (chamber certificate: nonnegativity of $`R_\kappa`$) | `Circulant5.strong_chamber_0`, …, `Circulant5.strong_chamber_5`, `Circulant5.strong_chambers` |
| The expansion in the smallest weight (after Lemma 4.3) | `Circulant5.P5_add_constant`, `Circulant5.gram_add_constant`, `Circulant5.strongDefect_add_constant`, `Circulant5.chamberPoly0_eval`, …, `Circulant5.chamberPoly5_eval` |
| The two-point example $`w=(t,t,0,0,0)`$, all real $`t`$ | `Circulant5.P5_twoSupport`, `Circulant5.P5_gram_twoSupport`, `Circulant5.P5_conv_twoSupport`, `Circulant5.strongDefect_twoSupport`, `Circulant5.gyiresDefect_twoSupport`, `Circulant5.gyiresDenominator_twoSupport` |
| The example $`t=\tfrac12`$ (Discussion) | `Circulant5.permanent_twoSupport_half`, `Circulant5.permanent_gram_twoSupport_half`, `Circulant5.permanent_square_twoSupport_half`, `Circulant5.normalizedGyiresRatio_twoSupport_half` |

## Statements not formalized in Lean

The formal proof establishes $`R_\kappa(z)\ge0`$ for all $`z\ge0`$, which is the part of Lemma 4.3 that the theorems need. The finer statements of Lemma 4.3 (996 positive and 5 zero coefficients per chamber, the positions of the zeros, the pure-power coefficients 233296, 44209, 484, 601, and the least positive coefficient 484) are checked by the exact computation in [`verification/independent_checks.gp`](../../verification/independent_checks.gp), not in Lean.

The formal proof of Lemma 2.3 is a sum-of-squares argument over permutations, adapted from C. Ozols's formalization of the case $`n=4`$ ([`Circulant5/PermanentGram.lean`](../Circulant5/PermanentGram.lean)); the paper gives a different proof, through occupancy vectors.
