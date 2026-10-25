/-
Negative control for the declaration scan of `AxiomAudit.lean`.

Run from the `lean/` folder after `lake build`:

    lake env lean ../verification/ScanControl.lean

The Challenge module leaves every proof as `sorry`. The same scan as in `AxiomAudit.lean`,
applied to it, must report that each of its declarations depends on `sorryAx`; this shows that
the scan sees the axioms of imported proofs, which under the module system are hidden from the
importing file.
-/
module

import Challenges.GyiresCirculant5

open Lean Elab Command in
#eval show CommandElabM Unit from do
  let env ← getEnv
  let mut total : Nat := 0
  let mut withSorry : Nat := 0
  for (name, _) in env.constants.map₁.toList do
    let some idx := env.getModuleIdxFor? name | continue
    unless (`Challenges).isPrefixOf env.header.moduleNames[idx.toNat]! do continue
    total := total + 1
    let axioms ← liftCoreM <| collectAxioms name
    if axioms.contains ``sorryAx then withSorry := withSorry + 1
  logInfo m!"scan control: {total} declarations in Challenges.*, of which {withSorry} depend on sorryAx"
