#!/usr/bin/env python3
"""Update the "(NNNK .ctl file)" size mentions in README.md.

For each "## Title" section, finds its "Browse: .../<dir>/<slug>/" line,
derives the control file as <dir>/<slug>.ctl, and rewrites the
"(NNNK .ctl file)" text in that section's "Status:" line to match the
control file's current size on disk.

Run from the repository root:
    python update_ctl_sizes.py [--check]

--check: don't modify README.md, just report what would change and exit
         with a non-zero status if anything is out of date.
"""
import re
import sys
from pathlib import Path

README = Path(__file__).resolve().parent / 'README.md'
BROWSE_RE = re.compile(r'^Browse:\s*\S*?/([^/]+)/([^/]+)/\s*$')
STATUS_RE = re.compile(r'^(Status:.*\()(\d+)(K \.ctl file\)\.?)$')


def find_ctl_size(directory: str, slug: str) -> int | None:
    ctl_path = README.parent / directory / f'{slug}.ctl'
    if not ctl_path.is_file():
        return None
    return ctl_path.stat().st_size


def main() -> int:
    check_only = '--check' in sys.argv
    text = README.read_text(encoding='utf-8')
    lines = text.splitlines()

    directory = None
    slug = None
    changed = 0
    missing = []

    for i, line in enumerate(lines):
        if line.startswith('## '):
            directory = slug = None
            continue
        m = BROWSE_RE.match(line)
        if m:
            directory, slug = m.group(1), m.group(2)
            continue
        m = STATUS_RE.match(line)
        if m and directory and slug:
            size = find_ctl_size(directory, slug)
            if size is None:
                missing.append(f'{directory}/{slug}.ctl (referenced near line {i + 1})')
                continue
            new_kb = round(size / 1024)
            old_kb = int(m.group(2))
            if new_kb != old_kb:
                print(f'{directory}/{slug}.ctl: {old_kb}K -> {new_kb}K')
                lines[i] = f'{m.group(1)}{new_kb}{m.group(3)}'
                changed += 1
            # a Status line ends this section's relevant block; keep
            # directory/slug in case of further lines, no reset needed

    if missing:
        print('WARNING: could not find these .ctl files:', file=sys.stderr)
        for m in missing:
            print(f'  {m}', file=sys.stderr)

    if changed == 0:
        print('All .ctl sizes already up to date.')
        return 1 if missing else 0

    if check_only:
        print(f'{changed} entr{"y" if changed == 1 else "ies"} out of date (--check, not writing).')
        return 1

    README.write_text('\n'.join(lines) + '\n', encoding='utf-8')
    print(f'Updated {changed} entr{"y" if changed == 1 else "ies"} in README.md.')
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
