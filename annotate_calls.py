#!/usr/bin/env python3
"""Annotate CALL sites in a SkoolKit .ctl with the target routine's title.

For every `CALL $XXXX` (conditional or not) found in the .skool disassembly
whose target routine has a title on its `c $XXXX <title>` line in the .ctl,
add a `C $addr,3 <short title>` sub-block comment at the call site -- unless
that address already has a C-line (existing comments are never touched).

The title is shortened for the call-site comment: cut at the first ': ' or
'; ' outside parentheses, and a trailing parenthetical is dropped -- so
"Print a BCD number: B bytes from (HL), ..." becomes "Print a BCD number".

Idempotent: running it twice adds nothing new. Re-run after giving more
routines titles to propagate them to their call sites.

Usage: python annotate_calls.py [file.ctl] [file.skool]
"""
import re
import sys

CTL = sys.argv[1] if len(sys.argv) > 1 else 'hydrofool.ctl'
SKOOL = sys.argv[2] if len(sys.argv) > 2 else 'hydrofool.skool'


def shorten(title):
    # cut at the first ': ' or '; ' that is outside parentheses
    depth = 0
    for i, ch in enumerate(title):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif ch in ':;' and depth == 0 and title[i:i + 2] in (': ', '; '):
            title = title[:i]
            break
    # drop a trailing parenthetical
    title = title.rstrip()
    if title.endswith(')'):
        depth = 0
        for i in range(len(title) - 1, -1, -1):
            if title[i] == ')':
                depth += 1
            elif title[i] == '(':
                depth -= 1
                if depth == 0:
                    title = title[:i].rstrip()
                    break
    return title


ctl_lines = open(CTL, encoding='utf-8').read().splitlines()

# 1. Routine titles from the ctl: c $XXXX <title>
titles = {}
for line in ctl_lines:
    m = re.match(r'^c \$([0-9A-F]{4}) (\S.*)$', line)
    if m:
        titles[int(m.group(1), 16)] = shorten(m.group(2).strip())

# 2. Addresses already covered by a C-line in the ctl (including multi-byte spans)
have_c = set()
for line in ctl_lines:
    m = re.match(r'^C \$([0-9A-F]{4})(?:,(\d+))?', line)
    if m:
        start = int(m.group(1), 16)
        length = int(m.group(2)) if m.group(2) else 1
        have_c.update(range(start, start + length))

# 3. CALL sites from the skool
calls = []  # (site_addr, target_addr)
for line in open(SKOOL, encoding='utf-8').read().splitlines():
    m = re.match(r'^[\* ]\$([0-9A-F]{4}) CALL (?:(?:NZ|Z|NC|C|PO|PE|P|M),)?\$([0-9A-F]{4})\b', line)
    if m:
        calls.append((int(m.group(1), 16), int(m.group(2), 16)))

# 4. Build the new C-lines
new_lines = {}  # addr -> line
for site, target in calls:
    if site in have_c or target not in titles or not titles[target]:
        continue
    new_lines[site] = 'C ${:04X},3 {}'.format(site, titles[target])

# 5. Insert each new line at its address-sorted position in the ctl
def line_addr(line):
    m = re.match(r'^[a-zA-Z@]{1}\S* \$([0-9A-F]{4})', line)
    return int(m.group(1), 16) if m else None

out = list(ctl_lines)
for addr in sorted(new_lines):
    idx = len(out)
    for i, line in enumerate(out):
        a = line_addr(line)
        if a is not None and a > addr:
            idx = i
            break
    out.insert(idx, new_lines[addr])

open(CTL, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print('titled routines: {}, call sites found: {}, C-lines added: {}'.format(
    len(titles), len(calls), len(new_lines)))
for addr in sorted(new_lines):
    print('  ' + new_lines[addr])
