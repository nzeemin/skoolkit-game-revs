# Actors: Hero and Creatures

Both the hero and every creature/hazard share one object-record format and one
per-frame update loop ($9B22). This doc covers that shared record, the hero's
input/movement/status machinery, and what's known about creature types and
their spawn/behavior code.

## Object record ($5B04-based array)

Up to 5 live world objects at a time, stride 4 bytes, base $5B04:

| Slot | Base   | Occupant |
|---|---|---|
| 0 | $5B04 | Hero (always slot 0) |
| 1 | $5B08 | Creature/hazard |
| 2 | $5B0C | Creature/hazard |
| 3 | $5B10 | Creature/hazard |
| 4 | $5B14 | Creature/hazard |

Confirmed fields, offsets from the slot base (IX):

| Offset | Field |
|---|---|
| +0 | X position |
| +1 | Y position |
| +2 | Type/animation-frame byte. `$FF`=inactive, `$FE`=just cleared (see $9D21/$BEDD). For creatures, also doubles as the type ID copied from the room data table ($C152) at spawn. |
| +3 | Direction/flag byte, bit7 = facing/direction (set by movement code from velocity sign, e.g. $A3C1), also reused by some creatures as an "armed" flag (SET/RES 7 in $B72D's block) |

A second parallel region at slot-base+$40/+41/+42/+43 caches **screen address
and plot-routine pointer** for the current frame (written by $9B22 from
$9CEE's output) - but the *same* offsets ($40/$41) are read by $9D3C as a
**tile-graphic index** when drawing a tile-based icon for a slot. These are
probably two different consumers of the same scratch bytes at different
points in the frame (not a real conflict), but this hasn't been fully
reconciled - see Open Questions.

$5AE4 is a second, structurally identical 5-slot array processed by the same
restore-background routine ($9BEB) via $9B22 - purpose not confirmed, likely
UI/inventory-bar icon positions rather than world objects.

## Hero

### Position and identity

Hero is always object slot 0, base $5B04. `$5B9E`/`$5B9F` track "room last
ran for" (used by the room-entry trigger, $AF81). `$5B97` is the lives
counter (confirmed live via the "Infinite Lives" POKE 43517,182, which
patches the `DEC (HL)` at $A9FD in $A9EE to a no-op `OR (HL)`).

### Input

$B894 reads the selected input device (`$94AF`: 0=keyboard via redefined-key
table $B8D4, 1=Kempston port $1F, 2=Sinclair 2 port $EFFE) and normalizes to
a Kempston-style bitmask at $B87C: bit0=right, bit1=left, bit2=down,
bit3=up, bit4=fire. $B87D wraps this and cancels out simultaneous
opposite-direction presses (both L+R or both U+D collapse to 0).

### Movement ($A34B / $A3E1)

$A34B is the per-frame movement resolver: takes the resolved input bitmask,
turns it into a velocity (`$5C34`), checking $A1D3/$A208 for blocked tiles
in the intended direction before committing Y velocity. Updates the
direction flag (IX+3) from the velocity's sign, applies X/Y deltas to the
position, and - if X crosses past 4 - hands off to the room-edge handler at
$A640 (see Room-Format.md for the room-crossing mechanism itself).

$A3E1 is the outer per-frame driver: calls $A34B, dispatches scripted-zone
triggers ($AF3B, $B03B via table $B073), runs the room-state dispatch
($A6CC, indexed by `$5C06`), and handles a handful of hardcoded room+state
combinations that force specific `$5C06` values (see below).

### Collision / tile sampling

$A102 is the main per-frame hazard-tile check for the hero: samples the
tile at the hero's feet and to the right ($A176), and separately checks the
tile directly under the hero against the "standing on hazard" tile IDs
($BC/$BD). Standing on one of those for 50 frames (`$5C29` reaching `$32`)
forces `$5C06=$11`. $A2AC/$A2FA/$A31F/$A30B are the shared "scan a tile
against a solid/special list" primitives, reused by both hero and creature
code (lists at $A24B/$A271/$A242/$A268, chosen by whether music is on -
these are almost certainly *pairs of the same list*, one authored for each
music state, not different tile sets).

### Status code ($5C06)

`$5C06` is the hero's status/trigger code - **not** the hazard timer (that's
`$5C07`). Every status change funnels through $AE84/$AE85 (`LD A,code; JP
$AE85`), which also resets `$5C07` to 0 every time. Known values, all
inferred from call-site context - **none confirmed against the on-screen
animation yet**:

| Value | Set by | Context |
|---|---|---|
| 0 | $AE84 (most reset paths) | normal/idle - the default |
| 1 | $A564 | - |
| 2 | $A476 | gates $9A09 and the $BB5D item-pickup snap |
| 4 | $A42D | - |
| 5 | $BBC1 | item-pickup snap-to-object animation |
| 6 | $BCB4 | seesaw active ($BC73) |
| 7 | $AF60, $AC97 | room-dependent alt of 8 |
| 8 / 9 | $AC90 / $ACC0 | mutually exclusive, chosen by room |
| $0D | $AF7D | special zone: hero snapped to X=$1E; gates $B704's trigger |
| $11 | $A15C | stood on hazard tile ($BC/$BD) 50 frames |
| $12 | $AAF0 | creature-trap trigger |
| $13 / $14 | $AFCC / $AFC1 | special-zone up/down input |
| $15 | $B45A | - |
| $17 | $A90B, $B526, $B796 | generic cutscene/event trigger, reused by 3 unrelated sites |
| $18 | $9255 | - |
| $1A | $A12D | also see $B02E below - a *different* code on a similar-looking key check |
| $1B | $B704/$B71E | |
| $1C | $B3A1 | |

$B02E/$A416 separately check the ENTER key (port $FBFE) and set `$5C06=$0A`
- easy to confuse with the $1A path above since both are "confirm/trigger"
style checks.

### Respawn and lives

$9AA1 snapshots room/state/position into staging (`$5C2B`-`$5C32`) on room
entry. $A9EE increments the per-room hazard counter (`$5C07`) each frame;
at 50 (`$32`) it sets the respawn-pending flag (`$5C2A`) and decrements
lives. Zero lives falls into the game-over sequence ($9372: `$5B06=$7F`,
forced to room $28). $9090 is the respawn handler: restores the staged
state back into the live variables so the hero restarts in the same room
rather than switching rooms.

### Inventory tie-in

$5B7C is the 26-byte sequential item-pickup log (index into the $8400
sprite table; `$FF`=unused slot; last non-`$FF` entry = item currently
held) - see Items-Format.md for the full item table. $BB5D checks both
creature slots each frame for proximity to the hero and, if in range and an
inventory slot is free, triggers the pickup animation (`$5C06=5` via
$BBC1).

## Creatures / hazards

There are **two separate, parallel creature-spawn mechanisms** feeding two
different sets of object slots. They don't share code and were previously
easy to conflate under one "creature table" label - keeping them distinct
here:

### Static per-room hazards: $C152 -> slots $5B08/$5B0C/$5B10

12 bytes per room, indexed directly by room number (`level*12+col`),
decoded by $BE42 into 3 sub-records of 4 raw bytes (one per hazard slot;
all-zero = empty). Byte0's low nibble is the creature type ID:

| Type ID | Creature |
|---|---|
| $01 / $03 | Flying Lizard |
| $05 | Water Drop |
| $07 | Tentacles in concrete block |

Confirmed live: room $08 has 2 Water Drops, room $12 has none, room $14
(start) has a Tentacle-block + a Flying Lizard - matches what's seen
in-game. Byte1/byte2's role (position offset? behavior parameter?) within a
filled slot is not confirmed. $BE98 dispatches per-type init via a jump
table at $BECA, one entry per type ID, into object slots based at $5B08 -
i.e. up to 3 of these are always present while the hero is in a room that
has them, drawn/updated as part of the same 5-slot $5B04 array the hero
lives in (see Object record above). Slot 4 ($5B14) is never targeted by
this table - it's reserved for the scripted set-piece objects ($B0B6,
$B370, $B409, $B5DD) instead.

### Room-tagged encounter table: $B99D -> slots $5C0E/$5C13

A flat, room-number-tagged list, separate from $C152 and from the $5B04
object array entirely: 31 entries, 3 bytes each, at $B99D-$B9F9. Byte0 is
the room number the entry belongs to (confirmed against the snapshot - the
list includes ordinary rooms like $00/$07/$08/$09 *and* the portal rooms
$2E/$2F/$46/$47 from the $A66C table, which don't otherwise have $D600/
$C152 room data) - room numbers only reach $47, leaving bit7 free, and
that bit doubles as a flag: cleared in bulk across all 31 entries at init
($B932), and cleared individually for one specific entry by the room-$30
boss-defeat code ($B9FA, targeting entry 20 at $B9D9 directly by address
rather than through the scan). Whether the bit means "armed"/"consumed" or
something else isn't confirmed - both places *clear* it, so it can't yet
be read as a simple armed/consumed toggle. Byte1 holds the type ID in its
low 5 bits (top 3 bits unconfirmed). Byte2 is decoded by $B95F into an X/Y
sub-position (via a small rotate sequence) - it does **not** hold the slot
choice, despite an earlier pass through this doc saying so.

$B93F ($9880/$B5DD/$B9FA all call it on room entry) linearly scans all 31
entries, comparing byte0 against the current room, and spawns each match
into $5C0E or $5C13 via $B95F. The slot choice and the "stop after 2" skip
aren't stored in the table at all: $B93F carries a running counter (in C)
across the whole scan, which $B95F reads on entry - the counter's bit0
picks the slot and its bit1 (set once both slots have been filled) skips
any further matches. So unlike the $C152 hazards, only up to 2 of these
can be active at once, chosen dynamically rather than by fixed
slot number. $BB5D is what then checks these two slots each frame for hero
proximity/pickup. Whether this table's "creatures" are actually collectible
items, one-off scripted encounters, or a second hazard type is not
confirmed - the record format (type + X/Y only, no visible behavior-select
byte) looks more minimal than $C152's, which fits either reading.

### Movement/behavior primitives

Creature-specific movement is built from small shared primitives rather
than one big state machine per creature:

- $BEDD / $BF22: move an object ±2px along X or Y, bounce off walls/edges
  (checked via $C0FD/$C109/$C115/$C121, which wrap the tile-scan
  primitives above), then fall into $C0AC to advance the animation frame
  and - if the hero is in range (via $9140's proximity check) - trigger a
  hit/event through $AE85.
- $9140 is the shared proximity/collision test: compares two objects'
  X/Y deltas against a threshold (`$10` normally, `$08` for type range
  `$5C`-`$5F`), result in the carry flag.
- $BFA0 is a shared per-object countdown timer (byte at IY+8), reseeded
  from $9390 (a pseudo-random byte generator mixing the R register with a
  rotating stride table) whenever it hits 0 - used to stagger
  creature behavior changes (direction flips, etc.) instead of every
  object moving in lockstep.
- $AA3C/$AA6F/$AC35/$AD17/$AD32/$ADAC and neighbors are per-room "trap
  entry" points: hazard-timer-gated triggers that clamp a creature's
  position to a track and fire room-state changes once a per-room
  hazard-counter threshold is hit (via $ABDE, which increments $5C07 and
  indexes a per-trap lookup table by half its value). These read as
  authored, per-obstacle scripted behavior rather than a generic AI.

### Boss/miniboss ($B5DD)

$B5DD is a distinct state machine (phase counter `$5C3D`, room lock
`$5C3C`) gated on a room match and $9140's proximity check: advances through
scripted phases (position/animation lookups in `$B6BB`/`$B6C1`), forces a
room warp to $28 with a fanfare trigger at phase 6 ($B6EE), and separately
handles a bounded left-right patrol with column-wrap logic ($B676-$B6BA).
Distinct from the room-trap creatures above; likely the "Prof" or a fixed
boss encounter tied to a specific room, not spawned via the $C152 table.

## Open questions

- What each hero status code ($5C06) actually *looks* like on screen -
  none of the table above has been checked against the live sprite/frame.
  Needs a breakpoint-per-write + screen capture pass.
- Whether the $5B04-slot-base+$40/+41 "screen address cache" (written by
  $9B22) and "tile-graphic index" (read by $9D3C) are really the same
  bytes used for two purposes at different points in the frame, or two
  different fields that happen to share ctl comments written at different
  times in this project.
- What $5AE4's 5-slot array actually holds (processed identically to
  $5B04's array by $9BEB, but never seen written to directly in the
  routines traced so far).
- Byte1/byte2 meaning inside a filled $C152 creature sub-record.
- What $B99D's entries actually represent (creatures? items? one-off
  triggers?), what byte0's bit7 flag actually means (both places that
  touch it - init and the room-$30 boss-defeat code - *clear* it, so it
  isn't a simple set-on-consume/clear-on-spawn toggle), and how the
  $5C0E/$5C13 object records relate field-for-field to the $5B04 array's
  layout - a stray `(IX+7)` write seen in $B93F falls outside the 4-field
  record documented above, so the two record shapes haven't been
  reconciled.
- Whether the $A24B/$A271 and $A242/$A268 tile lists are truly music-on/
  music-off duplicates of the same list, or carry different tile sets.
