#!/usr/bin/env python3
"""Annotate CALL and JP sites in a SkoolKit .ctl with the target routine's title.

For every `CALL $XXXX` (conditional or not) found in the .skool disassembly
whose target routine has a title on its `c $XXXX <title>` line in the .ctl,
add a `C $addr,3 <short title>` sub-block comment at the call site -- unless
that address already has a C-line (existing comments are never touched).

`JP $XXXX` (conditional or not) sites are annotated the same way, but with
an "=> " prefix on the comment text (e.g. `C $addr,3 => <short title>`) to
mark them as a jump/handoff rather than a call-and-return.

The title is shortened for the call-site comment: cut at the first ': ' or
'; ' outside parentheses, and a trailing parenthetical is dropped -- so
"Print a BCD number: B bytes from (HL), ..." becomes "Print a BCD number".

Idempotent: running it twice adds nothing new. Re-run after giving more
routines titles to propagate them to their call sites.

Pass --force to instead overwrite the text of existing C-line comments at
call sites (address and length are kept as-is, only the trailing comment
text is replaced) -- use this after renaming/retitling routines so their
call-site annotations catch up.

Usage: python annotate_calls.py [--force] [file.ctl] [file.skool]
"""
import re
import sys

args = sys.argv[1:]
FORCE = '--force' in args
args = [a for a in args if a != '--force']

CTL = args[0] if len(args) > 0 else 'hydrofool.ctl'
SKOOL = args[1] if len(args) > 1 else 'hydrofool.skool'


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

# 2. Addresses already covered by a C-line in the ctl (including multi-byte spans),
#    and the ctl line index of each C-line's own start address (for --force rewrites)
have_c = set()
c_line_idx = {}  # start_addr -> index into ctl_lines
for i, line in enumerate(ctl_lines):
    m = re.match(r'^C \$([0-9A-F]{4})(?:,(\d+))?', line)
    if m:
        start = int(m.group(1), 16)
        length = int(m.group(2)) if m.group(2) else 1
        have_c.update(range(start, start + length))
        c_line_idx[start] = i

# 3. CALL and JP sites from the skool
calls = []  # (site_addr, target_addr, prefix)
for line in open(SKOOL, encoding='utf-8').read().splitlines():
    m = re.match(r'^(?:[\* ]|[a-zA-Z])\$([0-9A-F]{4}) CALL (?:(?:NZ|Z|NC|C|PO|PE|P|M),)?\$([0-9A-F]{4})\b', line)
    if m:
        calls.append((int(m.group(1), 16), int(m.group(2), 16), ''))
        continue
    m = re.match(r'^(?:[\* ]|[a-zA-Z])\$([0-9A-F]{4}) JP (?:(?:NZ|Z|NC|C|PO|PE|P|M),)?\$([0-9A-F]{4})\b', line)
    if m:
        calls.append((int(m.group(1), 16), int(m.group(2), 16), '=> '))

# 4. Build the new C-lines, and (with --force) text-only rewrites of existing ones
new_lines = {}  # addr -> line
rewrites = {}  # addr -> (ctl_line_index, new_line)
for site, target, prefix in calls:
    if target not in titles or not titles[target]:
        continue
    text = prefix + titles[target]
    if site not in have_c:
        new_lines[site] = 'C ${:04X},3 {}'.format(site, text)
    elif FORCE and site in c_line_idx:
        old = ctl_lines[c_line_idx[site]]
        m = re.match(r'^(C \$[0-9A-F]{4}(?:,\d+)? )(\S.*)$', old)
        if m and m.group(2) != text:
            rewrites[site] = (c_line_idx[site], m.group(1) + text)

# 5. Insert each new line at its address-sorted position in the ctl
def line_addr(line):
    m = re.match(r'^[a-zA-Z@]{1}\S* \$([0-9A-F]{4})', line)
    return int(m.group(1), 16) if m else None

out = list(ctl_lines)
for addr, (idx, new_line) in rewrites.items():
    out[idx] = new_line
for addr in sorted(new_lines):
    idx = len(out)
    for i, line in enumerate(out):
        a = line_addr(line)
        if a is not None and a > addr:
            idx = i
            break
    out.insert(idx, new_lines[addr])

open(CTL, 'w', encoding='utf-8').write('\n'.join(out) + '\n')
print('titled routines: {}, call/jp sites found: {}, C-lines added: {}, rewritten: {}'.format(
    len(titles), len(calls), len(new_lines), len(rewrites)))
for addr in sorted(new_lines):
    print('  ' + new_lines[addr])
for addr in sorted(rewrites):
    print('  ~ ' + rewrites[addr][1])
