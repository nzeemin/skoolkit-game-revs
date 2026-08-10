#!/usr/bin/env python3
"""Report C-line (per-instruction comment) density for a SkoolKit .ctl/.skool pair.

For every `c` (code) block in the .ctl, computes the ratio of disassembled
instructions to C-line comments covering that block's address range, and
prints an overall summary plus a sorted list of the worst-covered blocks
(highest instructions-per-comment ratio first).

A ratio of 5 means "1 comment per 5 instructions" -- pass --threshold to
change the cutoff for what gets listed (default 5). Blocks with fewer than
--min-instr instructions are skipped (tiny routines don't need a comment
every 5 lines to be readable; default 8).

Usage: python comment_density.py [file.ctl] [file.skool] [--threshold N] [--min-instr N]
Example: python comment_density.py nebulus-zx/nebulus.ctl nebulus-zx/nebulus.skool
"""
import re
import sys
import bisect

args = [a for a in sys.argv[1:] if not a.startswith('--')]
opts = {}
for a in sys.argv[1:]:
    if a.startswith('--threshold='):
        opts['threshold'] = float(a.split('=', 1)[1])
    elif a.startswith('--min-instr='):
        opts['min_instr'] = int(a.split('=', 1)[1])

CTL = args[0] if len(args) > 0 else 'hydrofool.ctl'
SKOOL = args[1] if len(args) > 1 else 'hydrofool.skool'
THRESHOLD = opts.get('threshold', 5.0)
MIN_INSTR = opts.get('min_instr', 8)

ctl_lines = open(CTL, encoding='utf-8').read().splitlines()
skool_lines = open(SKOOL, encoding='utf-8').read().splitlines()

# 1. block starts: c/b/s/t/w/g blocks with addresses, in order
blocks = []  # (addr, type)
for line in ctl_lines:
    m = re.match(r'^([cbstwg])\s+\$([0-9A-F]{4})', line)
    if m:
        blocks.append((int(m.group(2), 16), m.group(1)))
blocks.sort()

# 2. instruction addresses from skool (real code lines only)
addr_re = re.compile(r'^[\* ]\$([0-9A-F]{4})\s+\S')
instr_addrs = sorted({int(m.group(1), 16) for m in
                       (addr_re.match(l) for l in skool_lines) if m})

# 3. C-line addresses (comments) from ctl
c_addrs = sorted({int(m.group(1), 16) for m in
                   (re.match(r'^C \$([0-9A-F]{4})', l) for l in ctl_lines) if m})

# 4. per-block stats for c-type blocks
results = []
total_instr = 0
total_c = 0
for i, (addr, typ) in enumerate(blocks):
    if typ != 'c':
        continue
    end = blocks[i + 1][0] if i + 1 < len(blocks) else 0x10000
    lo = bisect.bisect_left(instr_addrs, addr)
    hi = bisect.bisect_left(instr_addrs, end)
    n_instr = hi - lo
    clo = bisect.bisect_left(c_addrs, addr)
    chi = bisect.bisect_left(c_addrs, end)
    n_c = chi - clo
    total_instr += n_instr
    total_c += n_c
    if n_instr < MIN_INSTR:
        continue
    ratio = n_instr / max(n_c, 1)
    results.append((ratio, addr, end, n_instr, n_c))

overall = total_instr / max(total_c, 1)
print('Overall: {} code instructions, {} C-line comments, 1 per {:.1f} instructions'.format(
    total_instr, total_c, overall))
print('(SkoolKit convention target: 1 per {:.0f})'.format(THRESHOLD))
print()

results.sort(reverse=True)
flagged = [r for r in results if r[0] > THRESHOLD]
print('{} of {} code blocks (>= {} instructions) exceed the ratio:'.format(
    len(flagged), len(results), MIN_INSTR))
for ratio, addr, end, n_instr, n_c in flagged:
    print('${:04X}-${:04X}  instr={:4d}  C-lines={:3d}  ratio={:.1f}'.format(
        addr, end, n_instr, n_c, ratio))

flagged_instr = sum(r[3] for r in flagged)
flagged_c = sum(r[4] for r in flagged)
print()
print('Total (flagged blocks): {} instructions, {} C-lines, 1 per {:.1f}'.format(
    flagged_instr, flagged_c, flagged_instr / max(flagged_c, 1)))
