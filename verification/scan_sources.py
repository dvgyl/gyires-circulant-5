"""Search the Lean sources for escape hatches.

Usage (from the repository root):

    python3 verification/scan_sources.py > verification/results/source_scan.txt

Every `.lean` file of the repository (outside `.lake`) is searched, after removing comments and
string literals, for `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by` and `extern`.
The only permitted occurrences are the `sorry` placeholders of `lean/Challenges/`, whose proofs
are supplied by `lean/Solutions/` and checked by Comparator. Exits nonzero otherwise.
"""
import pathlib
import re
import sys

root = pathlib.Path(__file__).resolve().parents[1]
TOKENS = ["sorry", "admit", "axiom", "native_decide", "implemented_by", "extern"]
pattern = re.compile(r"(?<![\w.'])(" + "|".join(TOKENS) + r")(?![\w'])")


def strip_comments_and_strings(text: str) -> str:
    out = []
    i, depth, n = 0, 0, len(text)
    while i < n:
        if depth == 0 and text.startswith("--", i):
            j = text.find("\n", i)
            i = n if j < 0 else j
        elif text.startswith("/-", i):
            depth += 1
            i += 2
        elif depth > 0 and text.startswith("-/", i):
            depth -= 1
            i += 2
        elif depth > 0:
            out.append("\n" if text[i] == "\n" else " ")
            i += 1
        elif text[i] == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            i = j + 1
        else:
            out.append(text[i])
            i += 1
    return "".join(out)


files = sorted(p for p in root.rglob("*.lean") if ".lake" not in p.parts and ".git" not in p.parts)
problems, permitted = [], []
for path in files:
    code = strip_comments_and_strings(path.read_text(encoding="utf-8"))
    for lineno, line in enumerate(code.splitlines(), 1):
        for match in pattern.finditer(line):
            rel = path.relative_to(root).as_posix()
            entry = f"{rel}:{lineno}: {match.group(1)}"
            if match.group(1) == "sorry" and rel.startswith("lean/Challenges/"):
                permitted.append(entry)
            else:
                problems.append(entry)

print(f"Lean files searched: {len(files)}")
print(f"tokens searched for: {', '.join(TOKENS)}")
print(f"permitted occurrences (Challenge placeholders): {len(permitted)}")
for entry in permitted:
    print("  ", entry)
print(f"other occurrences: {len(problems)}")
for entry in problems:
    print("  ", entry)
print("RESULT:", "PASS" if not problems else "FAIL")
sys.exit(0 if not problems else 1)
