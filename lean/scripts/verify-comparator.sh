#!/usr/bin/env bash
# Judge each Solution module against its Challenge the way Palomar does: with the
# `lake comparator` of this project's toolchain, replaying the proofs through Lean's
# kernel and the toolchain's bundled independent kernels (NanoDa and con-ron).
#
# Usage, from the lean/ directory:
#   scripts/verify-comparator.sh                                  # every file in comparator/
#   scripts/verify-comparator.sh comparator/gyires-circulant5.json
# Requires Linux with bubblewrap (`bwrap`), Lean (via elan or on PATH), and Python 3.
set -euo pipefail

project_root=$(cd "$(dirname "$0")/.." && pwd)
cd "$project_root"

for required_command in bwrap lake lean python3; do
  if ! command -v "$required_command" >/dev/null 2>&1; then
    echo "error: $required_command is required to run lake comparator" >&2
    exit 1
  fi
done

toolchain=$(tr -d '[:space:]' < lean-toolchain)
prefix=$(lean --print-prefix)
for tool in lake leanexport leanchecker nanoda_bin con-ron; do
  if [ ! -x "$prefix/bin/$tool" ]; then
    echo "error: toolchain $toolchain does not bundle $tool" >&2
    echo "Palomar requires leanprover/lean4:v4.35.0-rc2 or later" >&2
    exit 1
  fi
done

configs=("$@")
if [ ${#configs[@]} -eq 0 ]; then
  configs=(comparator/*.json)
fi

for source in "${configs[@]}"; do
  config=$(mktemp "${TMPDIR:-/tmp}/comparator.XXXXXX.json")
  # Palomar ignores `enable_nanoda`, rejects `external_kernels` in a submitted
  # configuration, and registers the toolchain's bundled kernels itself.
  python3 - "$source" "$config" "$prefix" <<'PY'
import json
import pathlib
import sys

source, destination, prefix = sys.argv[1:]
config = json.loads(pathlib.Path(source).read_text(encoding="utf-8"))
if not isinstance(config, dict):
    raise SystemExit(f"error: {source} must contain one JSON object")
if "external_kernels" in config:
    raise SystemExit(f"error: {source}: external_kernels is not a submitter field")
config.pop("enable_nanoda", None)
config["external_kernels"] = {
    "nanoda": [f"{prefix}/bin/nanoda_bin"],
    "con-ron": [f"{prefix}/bin/con-ron"],
}
pathlib.Path(destination).write_text(json.dumps(config, indent=2) + "\n", encoding="utf-8")
PY
  echo "== $source"
  lake comparator --config "$config"
  rm -f "$config"
done
