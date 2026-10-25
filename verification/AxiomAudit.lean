/-
Axiom audit (independent check).

Run from the `lean/` folder after `lake build`:

    lake env lean ../verification/AxiomAudit.lean

Part 1 asks Lean, with `#print axioms`, for the axioms on which each theorem stated in the
paper or compared with the Challenge depends, transitively. Part 2 scans every theorem and
definition of the modules `Circulant5.*` and `Solutions.*`, including private and auxiliary
ones, with `Lean.collectAxioms`. The expected answer is a subset of
`[propext, Classical.choice, Quot.sound]`; anything else (in particular `sorryAx` or
`Lean.ofReduceBool`) would be a failure. `verification/check_axioms.py` checks the output.
-/
module

import Circulant5
import Solutions.GyiresCirculant5

-- The theorems compared with `Challenges/GyiresCirculant5.lean`
#print axioms GyiresCirculant5.gyires_ratio
#print axioms GyiresCirculant5.gyires_ratio_eq_iff
#print axioms GyiresCirculant5.gyires_denominator_pos
#print axioms GyiresCirculant5.gyires_homogeneous
#print axioms GyiresCirculant5.gyires_homogeneous_eq_iff
#print axioms GyiresCirculant5.strong_inequality
#print axioms GyiresCirculant5.strong_inequality_eq_iff
#print axioms GyiresCirculant5.strong_margin
#print axioms GyiresCirculant5.strong_margin_attained
#print axioms GyiresCirculant5.strong_margin_sharp

-- Section 2 of the paper: products, the permanent polynomial, the Gram comparison
#print axioms Circulant5.circ_mul_transpose
#print axioms Circulant5.transpose_mul_circ
#print axioms Circulant5.circ_mul_self
#print axioms Circulant5.permanent_succ
#print axioms Circulant5.permanent_circ
#print axioms Circulant5.PermanentGram.permanent_mul_transpose
#print axioms Circulant5.PermanentGram.permanent_gram_add_ge
#print axioms Circulant5.conv_permanent_le_gram

-- Section 4: affine symmetry and the chambers
#print axioms Circulant5.P5_affine
#print axioms Circulant5.gram_affine
#print axioms Circulant5.conv_affine
#print axioms Circulant5.strongDefect_affine
#print axioms Circulant5.gyiresDefect_affine
#print axioms Circulant5.affine_bijective
#print axioms Circulant5.order_affine_cover
#print axioms Circulant5.order_affine_cover_unique
#print axioms Circulant5.exists_canonical_chamber
#print axioms Circulant5.canonical_chamber_of_monotone
#print axioms Circulant5.sortedGaps_nonneg
#print axioms Circulant5.nonneg_of_canonical_chambers
#print axioms Circulant5.constant_of_zero_of_canonical_chambers

-- Section 4: the chamber certificate
#print axioms Circulant5.P5_add_constant
#print axioms Circulant5.gram_add_constant
#print axioms Circulant5.strongDefect_add_constant
#print axioms Circulant5.chamberPoly0_eval
#print axioms Circulant5.chamberPoly1_eval
#print axioms Circulant5.chamberPoly2_eval
#print axioms Circulant5.chamberPoly3_eval
#print axioms Circulant5.chamberPoly4_eval
#print axioms Circulant5.chamberPoly5_eval
#print axioms Circulant5.strong_chamber_0
#print axioms Circulant5.strong_chamber_1
#print axioms Circulant5.strong_chamber_2
#print axioms Circulant5.strong_chamber_3
#print axioms Circulant5.strong_chamber_4
#print axioms Circulant5.strong_chamber_5
#print axioms Circulant5.strong_chambers
#print axioms Circulant5.gyires_chambers

-- Sections 3 and 4: the main theorems in the library's notation
#print axioms Circulant5.strongDefect_nonneg
#print axioms Circulant5.gyiresDefect_nonneg
#print axioms Circulant5.strongDefect_eq_zero_iff
#print axioms Circulant5.gyiresDefect_eq_zero_iff
#print axioms Circulant5.strong_matrix_inequality
#print axioms Circulant5.gyires_matrix_inequality
#print axioms Circulant5.strong_matrix_equality_iff
#print axioms Circulant5.gyires_matrix_equality_iff
#print axioms Circulant5.strongDefect_margin
#print axioms Circulant5.strongDefect_margin_attained
#print axioms Circulant5.strongDefect_margin_sharp
#print axioms Circulant5.normalized_equality_weights
#print axioms Circulant5.circ_nonneg
#print axioms Circulant5.circ_row_sum
#print axioms Circulant5.circ_column_sum
#print axioms Circulant5.positiveDenominator
#print axioms Circulant5.normalizedGyiresRatio
#print axioms Circulant5.normalizedGyiresRatio_eq_iff

-- Translation to Mathlib's `Matrix.circulant`
#print axioms Circulant5.circulant_eq_transpose_circ
#print axioms Circulant5.permanent_circulant
#print axioms Circulant5.permanent_circulant_mul_transpose
#print axioms Circulant5.permanent_transpose_mul_circulant
#print axioms Circulant5.permanent_circulant_mul_self
#print axioms Circulant5.gyiresDenominator_circulant
#print axioms Circulant5.weights_nonneg_of_entries
#print axioms Circulant5.weights_of_doublyStochastic
#print axioms Circulant5.circulant_eq_const_iff

-- Section 4 and the Discussion: the two-point example and the sharpness of 484
#print axioms Circulant5.P5_twoSupport
#print axioms Circulant5.P5_gram_twoSupport
#print axioms Circulant5.P5_conv_twoSupport
#print axioms Circulant5.strongDefect_twoSupport
#print axioms Circulant5.gyiresDefect_twoSupport
#print axioms Circulant5.gyiresDenominator_twoSupport
#print axioms Circulant5.twoSupport_half_nonneg
#print axioms Circulant5.twoSupport_half_sum
#print axioms Circulant5.permanent_twoSupport_half
#print axioms Circulant5.permanent_gram_twoSupport_half
#print axioms Circulant5.permanent_square_twoSupport_half
#print axioms Circulant5.normalizedGyiresRatio_twoSupport_half
#print axioms Circulant5.gap_coefficient_optimal

-- Remarks of the paper (Sections 1 and 6)
#print axioms Circulant5.gyires_of_strong
#print axioms Circulant5.permanent_fin_two
#print axioms Circulant5.gyires_two
#print axioms Circulant5.circulant_mem_doublyStochastic_iff
#print axioms Circulant5.cyclicShift_pow
#print axioms Circulant5.circulant_eq_sum_pow

-- Every declaration of the library and of the Solution. Under the module system an importing
-- file sees an imported theorem without its proof (as an opaque constant), so the scan does not
-- filter by kind: `collectAxioms` reads the axiom list that Lean computed from the full proof when
-- the declaring module was compiled, and a genuine `axiom` declaration would list itself.
open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let standard : List Name := [``propext, ``Classical.choice, ``Quot.sound]
  let mut declarations : Nat := 0
  let mut used : NameSet := {}
  let mut bad : Array (Name × Array Name) := #[]
  for (name, _) in env.constants.map₁.toList do
    let some idx := env.getModuleIdxFor? name | continue
    let module := env.header.moduleNames[idx.toNat]!
    unless (`Circulant5).isPrefixOf module || (`Solutions).isPrefixOf module do continue
    declarations := declarations + 1
    let axioms ← liftCoreM <| collectAxioms name
    for a in axioms do used := used.insert a
    if axioms.any (fun a => !standard.contains a) then
      bad := bad.push (name, axioms)
  logInfo m!"declaration scan: {declarations} declarations in Circulant5.* and Solutions.*"
  logInfo m!"declaration scan: axioms used: {used.toList}"
  logInfo m!"declaration scan: declarations with non-standard axioms: {bad.size}"
  for (n, axioms) in bad do
    logInfo m!"NON-STANDARD AXIOMS: {n} {axioms}"
