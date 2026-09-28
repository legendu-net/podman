#!/usr/bin/env -S uv run --script
#
# /// script
# requires-python = ">=3.14"
# ///
#
# Fails if a *_VERSION ARG default that's declared in more than one
# Containerfile (e.g. RUFF_VERSION in both lint/ and jupyterlab/) disagrees
# between them, so pinned lint-tool versions can't silently drift apart.

import re
import sys
from pathlib import Path

_ARG_VERSION_RE = re.compile(
    r"^ARG\s+([A-Za-z_][A-Za-z0-9_]*_VERSION)=(.+)$", re.IGNORECASE
)


def _parse_versions(containerfile: Path) -> dict[str, str]:
    versions: dict[str, str] = {}
    for line in containerfile.read_text().splitlines():
        m = _ARG_VERSION_RE.match(line.strip())
        if m:
            versions[m.group(1)] = m.group(2).strip().strip('"')
    return versions


def main() -> int:
    root = Path(__file__).resolve().parent
    by_name: dict[str, dict[Path, str]] = {}
    for containerfile in sorted(root.glob("*/Containerfile")):
        for name, value in _parse_versions(containerfile).items():
            by_name.setdefault(name, {})[containerfile] = value

    ok = True
    for name, locations in sorted(by_name.items()):
        if len(set(locations.values())) > 1:
            ok = False
            print(f"Version drift for {name}:", file=sys.stderr)
            for path, value in sorted(locations.items()):
                print(f"  {value}  {path.relative_to(root)}", file=sys.stderr)

    if not ok:
        return 1
    print("No version drift found.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
