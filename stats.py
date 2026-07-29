#!/usr/bin/env python3
"""Report coverage stats for a SkoolKit project: routine count, labels,
N-lines, instruction counts. Run from within the project directory - finds
the .skool file automatically and uses the matching .ctl (same basename)."""
import glob
import os
import re
import sys


def find_files():
    skool_matches = glob.glob('*.skool')
    if not skool_matches:
        sys.exit("No .skool file found in current directory.")
    if len(skool_matches) > 1:
        sys.exit(f"Multiple .skool files found: {skool_matches} - ambiguous.")
    skool = skool_matches[0]
    base = os.path.splitext(skool)[0]
    ctl = base + '.ctl'
    if not os.path.isfile(ctl):
        sys.exit(f"Found {skool} but no matching {ctl}.")
    return ctl, skool


def main():
    CTL, SKOOL = find_files()
    ctl_lines = open(CTL, encoding='utf-8').read().splitlines()
    skool_lines = open(SKOOL, encoding='utf-8').read().splitlines()

    c_starts = []
    titles = {}
    for l in ctl_lines:
        m = re.match(r'^c \$([0-9A-Fa-f]{4}) ?(.*)', l)
        if m:
            a = int(m.group(1), 16)
            c_starts.append(a)
            titles[a] = m.group(2)
    c_starts.sort()

    block_type_counts = {}
    for l in ctl_lines:
        m = re.match(r'^([bcgistuw]) \$[0-9A-Fa-f]{4}', l)
        if m:
            t = m.group(1)
            block_type_counts[t] = block_type_counts.get(t, 0) + 1

    label_addrs = set()
    for l in ctl_lines:
        m = re.match(r'^@ \$([0-9A-Fa-f]{4}) label=', l)
        if m:
            label_addrs.add(int(m.group(1), 16))

    n_addrs = set()
    for l in ctl_lines:
        m = re.match(r'^N \$([0-9A-Fa-f]{4})', l)
        if m:
            n_addrs.add(int(m.group(1), 16))

    c_line_addrs = set()
    for l in ctl_lines:
        m = re.match(r'^C \$([0-9A-Fa-f]{4})', l)
        if m:
            c_line_addrs.add(int(m.group(1), 16))

    all_starts = []
    for l in ctl_lines:
        m = re.match(r'^[bcgistuw] \$([0-9A-Fa-f]{4})', l)
        if m:
            all_starts.append(int(m.group(1), 16))
    all_starts.sort()

    # Count disassembled instruction lines within each c-block's byte span.
    # An instruction line in .skool starts with an optional block-type letter
    # or '*' or whitespace, then $ADDR, and is not a DEFB/DEFM/DEFW/DEFS line.
    instr_addrs = []
    for l in skool_lines:
        m = re.match(r'^[bcgistuw*]?\s*\$([0-9A-Fa-f]{4})\s+(\S+)', l)
        if m and m.group(2) not in ('DEFB', 'DEFM', 'DEFW', 'DEFS'):
            instr_addrs.append(int(m.group(1), 16))
    instr_addrs.sort()

    def instr_count(lo, hi):
        return sum(1 for a in instr_addrs if lo <= a < hi)

    titled = sum(1 for a in c_starts if titles.get(a, '').strip())
    labeled = sum(1 for a in c_starts if a in label_addrs)
    nlined = sum(1 for a in c_starts if a in n_addrs)

    total_instr = 0
    for a in c_starts:
        nxt = [x for x in all_starts if x > a]
        hi = nxt[0] if nxt else 0x10000
        total_instr += instr_count(a, hi)

    type_names = {'b': 'data b', 'c': 'code c', 'g': 'game status g',
                  'i': 'ignore i', 's': 'space s', 't': 'text t',
                  'u': 'unused u', 'w': 'word w'}
    type_line = '  '.join(
        f"{type_names.get(t, t)}: {block_type_counts.get(t, 0)}"
        for t in 'cbwtsgiu')
    ctl_size_kb = round(os.path.getsize(CTL) / 1024)
    print(f".ctl file size:          {ctl_size_kb}K")
    print(f"Block types:             {type_line}")
    print(f"Routines (c-blocks):     {len(c_starts)}")
    print(f"  titled:                {titled} ({len(c_starts)-titled} without a c-line title)")
    print(f"  labeled (@label=):     {labeled} ({len(c_starts)-labeled} unlabeled)")
    print(f"  with N-line:           {nlined} ({len(c_starts)-nlined} without)")
    print(f"Addrs with C-line:       {len(c_line_addrs)}")
    print(f"Total instructions:      {total_instr}")
    print(f"Avg instructions/routine:{total_instr/len(c_starts):.1f}")

    # Heuristic completion estimate: title coverage + C-line comment density,
    # weighted and calibrated so saboteur1-zx lands ~98-99% and joeblade-zx
    # ~95% (the two most mature projects in this repo). Not exact science -
    # a rough single-number signal for "how done is this disasm."
    title_frac = titled / len(c_starts) if c_starts else 0
    density_ratio = total_instr / len(c_line_addrs) if c_line_addrs else float('inf')
    density_term = 5 / density_ratio if density_ratio else 0
    completion = max(0.0, min(1.0, 0.62 * title_frac + 0.21 * density_term)) * 100
    print(f"Est. completion:         {completion:.1f}%"
          f"  (title coverage {title_frac*100:.0f}%, "
          f"1 C-line per {density_ratio:.1f} instructions)")


if __name__ == '__main__':
    main()
