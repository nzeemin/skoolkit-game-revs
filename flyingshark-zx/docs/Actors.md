# Flying Shark — Actors

How the player's plane and every enemy/projectile/explosion are represented,
allocated, updated, collided and drawn. Addresses are hex; `$XXXX` refs point
into the disassembly. For *where enemies come from* (level timeline, spawn
templates, formation tags) see `Level-Format.md` — this document picks up at the
moment an object exists.

## Overview

Flying Shark has **one object system**. The player's plane is not special-cased:
it is an ordinary object out of the same pool, with the same 29-byte struct, on
the same linked list, dispatched through the same per-object state table. What
makes it "the player" is only its state index (`IY+$05 = $02`) and the fact
that its address is published to `$9C6D`, which is where every homing enemy
reads its aim target from.

Everything that moves — player plane, enemy planes, tanks, boats, cannons,
bullets, explosions, bonus items — is an object.

## 1. The object struct (29 bytes, `$1D` stride)

Objects are addressed through `IY` (or `IX` in code that needs `IY` for
something else). The struct is exactly `$1D` bytes, matching the highest field
(`+$1C`) and `$B730`'s pool stride.

| Offset | Size | Field | Notes |
|--------|------|-------|-------|
| `$00`  | word | **next-object pointer** | singly-linked list; `$B730` chains the pool, `$BDAE` walks it |
| `$02`  | word | **descriptor-record pointer** | *not* a code pointer — see §6 |
| `$04`  | byte | **status flags** | see bit table below |
| `$05`  | byte | **state index** | selects the per-frame handler (§3) |
| `$06`  | byte | **animation frame** | index into the object's sprite set |
| `$07`  | word | velocity dx | fixed-point, set by `$B8A2` |
| `$09`  | word | velocity dy | fixed-point, set by `$B8A2` |
| `$0B`  | word | **X position** | fixed-point: `+$0B` fraction, `+$0C` column |
| `$0D`  | word | **Y position** | fixed-point: `+$0D` fraction, `+$0E` row |
| `$0F`  | byte | respawn/blink timer | player only; bit 7 = blinking |
| `$10`  | byte | heading / angle | 0-63; `$FF` on a projectile = not yet launched |
| `$11`  | byte | speed | magnitude passed to `$B8A2` |
| `$12`  | byte | health / hit points | decremented by damage, explode at < 0 |
| `$13`  | byte | formation-slot id | `$FF` = none; used by `$B79F` |
| `$14`  | byte | **collision hit mask** | written by `$BCE9`, read by every handler (§5) |
| `$15`  | word | movement-script pointer | **reused** — see note below |
| `$17`  | byte | script byte cache / bank target | |
| `$18`  | byte | frame-delay timer | script wait; player invulnerability countdown |
| `$19`  | byte | script loop counter | movement opcodes `$3C` / `$42` |
| `$1A`  | byte | target reference / stage counter | `$FF` = no target |
| `$1B`  | byte | (from spawn template byte 3 + difficulty `$9C41`) | purpose unconfirmed |
| `$1C`  | byte | **steered heading** | turned toward the target by `$C43C` |

**Field reuse.** `+$15`/`+$16` is the movement-script pointer for objects that
run a script (`$B94E`), but objects that don't run one reuse those bytes for
completely different per-type state:

| Actor | `+$15` / `+$16` holds |
|-------|----------------------|
| script-driven enemy | movement-script pointer (`$B94E`) |
| player plane | `+$15` = bank-delay timer, `+$16` = current bank frame (`$BE4A`) |
| explosion (`$C5AF`) | **pointer to the group counter to bump on completion** — callers pass `$9D18`/`$9D19`/`$9D1A` in `DE`; `$C051` does `INC (HL)` through it |
| weave handler (`$C3C7`) | `+$15` = direction-rate (sign-flipped on edge bounce) |
| upgraded explosion (`$C5D2`) | `+$15` = growth rate (literal `$33`) |

`+$18` is likewise the script frame-delay timer for script-driven objects and
the invulnerability countdown for the player. A port must not assume one
meaning per byte — the meaning follows `+$05`.

**Two heading fields.** `+$10` is the heading the movement-script opcodes set
and `$B8A2` converts to velocity. `+$1C` is the heading `$C43C` steers toward a
target. They are separate values, not aliases.

### `+$04` status-flag bits

| Bit | Meaning | Set / cleared by |
|-----|---------|------------------|
| 0 | busy / suppress redraw | `$ADC8` sets, `$ACAC` clears; `$BD2A` skips mask draw when set |
| 1 | alive / ready to retire | movement opcode `$45` (`$BA25`); handlers retire on it |
| 2 | active | `$C559`, `$B730`; `$BDAE` self-loops while set |
| 3 | fixed-slot / special | `$B730` sets on the 4 persistent slots; `$BD1E` skips normal draw |
| 4 | in-transition | banking in progress (`$BE4A`) / near-death flicker (`$C388`) |
| 5 | on-screen, drawable | `$ADCF`/`$ADE1`; gates the mask draw (`$BD30`) and hit handling |
| 6 | mirror flag | movement opcode `$3F` (`$B9BC`) |
| 7 | facing left | movement opcode `$48` (`$BA4F`); mirrors headings in `$B974`/`$B992` |

## 2. Pool, allocation and lifecycle

### Pool layout — `$B730`

`$B730` builds the world at wave start:

- **19 object slots** at `$9D40`-`$9F66`, stride `$1D`, chained through
  `+$00`/`+$01` into a free list whose head is `$9D1C`.
- **4 persistent 6-byte slots** at `$9D1E`/`$9D24`/`$9D2A`/`$9D30`, stride 6.
  These are too small to be objects — they are **list heads / sentinels**, each
  with its own `+$04` flags byte (bits 2 and 3 pre-set). `$9D1E` is the head
  `$BDAE` walks; `$9D30` is the secondary object stack.
- **Four group counters** partitioning the pool: `$9D19`=6, `$9D18`=8,
  `$9D1A`=4, `$9D1B`=1 — totalling exactly 19.
- Finally it calls `$C559` once.

### `$C559` allocates the player's plane

`$C559` is called from exactly one place — `$B730`. It pops the free-list head,
pushes the old head onto the secondary stack, then initialises:

```
IX+$04 = 0, bit 2 set     (active)
IX+$02/$03 = $6B42        (descriptor record 0)
IX+$05 = $02              (state index 2 -> "Player" handler)
IX+$0C = $10, IX+$0E = $16 (column 16, row 22 — bottom centre)
IX+$16 = $01, IX+$17 = $01, IX+$06 = $06
IX+$13 = $FF, IX+$18 = $FF
($9C6D) = IX             (publish as the global aim target)
```

So this is the **player-plane allocator**, and `$9C6D` is the player object
pointer that every homing enemy aims at.

Enemies are allocated separately by `$BA5F` from the same free list, either from
the level timeline (`$C9AF`) or from spawn markers embedded in the scrolling
relief column (`$C981`) — see `Level-Format.md` §4.

### Death

Two conversion routines move an object into an explosion rather than freeing it:

- **`$C5AF`** — the shared "object destroyed" entry, called from 7 different
  handlers. Sets `+$02/$03` to descriptor `$6BCA`, `+$05 = $04`, `+$06 = $08`,
  stores the caller's `DE` into `+$15/$16` — the **group counter to bump when
  the explosion finishes** (callers pass `$9D18`, `$9D19` or `$9D1A`) — and
  resets two global explosion-growth timers (`$9C35`, `$9C39`).
- **`$C5D2`** — the sibling used from `$B79F`'s formation-completion path; sets
  descriptor `$6BF3`. Its `$C5EE` entry additionally awards score and may either
  upgrade to a bigger explosion (`$6BED`) or spawn the next object in a bonus
  sequence (`$6BE7`), depending on how many bonus follow-ups the player's record
  still has and on a rate cap.

Because `+$05 = $04` maps to handler index `$2D` ("move straight down, advance
animation frame"), an explosion simply drifts down with the scroll while its
frame counter runs.

## 3. The per-frame pipeline

Everything runs from the heavy ISR `$A0C4`, in this order:

| Step | Routine | Job |
|------|---------|-----|
| 1 | `$C72A` | animate the active player's corner-box indicator |
| 2 | `$BBE5` | stamp each active object's **identity bit** into the collision buffers |
| 3 | `$BCE9` | draw each object's variable-height mask and compute `+$14` hit masks |
| 4 | `$BBC2` | clear the two 256-byte collision buffers for next frame |
| 5 | `$C772` | fast attribute mover (background) |
| 6 | `$C680`/`$C8B8`/`$C84C` | background scroll |
| 7 | `$C9AF` | advance the enemy timeline (spawns) |
| 8 | `$BD99` → `$BDAE` | **walk the object list, run each object's handler** |
| 9 | `$A561` | player respawn / continue state check |

Collision is computed (2-3) *before* movement (8), so a handler reading `+$14`
sees the previous frame's overlap result.

### The object walk — `$BDAE`

```
IY = ($9D1E)                      ; list head
loop:
  toggle border/speaker bits ($9C33/$9C34) -> port $FE
  IY = (IY+$00)                   ; next object
  ($B7E4) = previous IY           ; saved for $B79F's unlink
  if (IY+$04) bit 2 set:
      A = (IY+$05)
      dispatch via table base $A052   ; -> master index $29 + A
      repeat
  ... else: player respawn/blink handling ...
```

The dispatch base `$A052` is offset `$52` into the shared jump table `$A000`,
i.e. master index `$29`. So:

```
handler index = $29 + (IY+$05)
```

That single line is the object-type dispatch for the whole game.

## 4. State-index catalogue

| `+$05` | Master idx | Routine | Actor |
|--------|-----------|---------|-------|
| `$00` | `$29` | `$BE02` | idle / no-op |
| `$01` | `$2A` | `$BE01` | player frozen (unwinds a call level, then no-op) |
| `$02` | `$2B` | `$BE03` | **player plane** |
| `$03` | `$2C` | `$BFEB` | bomb / bullet — check for hit, explode |
| `$04` | `$2D` | `$C051` | **explosion** — drift down, advance frame |
| `$05` | `$2E` | `$C075` | multi-hit enemy |
| `$06` | `$2F` | `$C075` | multi-hit enemy |
| `$07` | `$30` | `$C3C7` | weaving enemy with edge bounce |
| `$08` | `$31` | `$C31A` | drop-down enemy, scores + bumps a counter |
| `$09` | `$32` | `$C199` | multi-hit enemy (two-stage) |
| `$0A` | `$33` | `$C199` | multi-hit enemy (two-stage) |
| `$0B` | `$34` | `$C298` | drop-down enemy with variable damage + near-death anim |
| `$0C` | `$35` | `$C11C` | scripted-movement enemy, variable damage |
| `$0D` | `$36` | `$C015` | launched projectile |
| `$0E` | `$37` | `$C217` | scripted enemy, variable damage |
| `$0F` | `$38` | `$C388` | flickering enemy, scores + wave-progress bump |
| `$10` | `$39` | `$C359` | drop-down enemy, bumps a field on the hitter |
| `$11` | `$3A` | `$C199` | multi-hit enemy (two-stage) |

### Handler anatomy

The enemy handlers are variations on one skeleton:

1. *(optional)* run the movement script — `$B8F9`.
2. Move: either straight down at a fixed `$0020`/frame, or by heading+speed
   through `$B8A2` (angle → velocity) + `$BA0A` (velocity → position).
3. Read `+$14`. If hit, decode a damage amount, `OR` the hit bits into the
   global `$9C6B`, subtract damage from health `+$12`.
4. If health went negative: award score (`$66B5`) and call `$C5AF`.
5. Otherwise pick a sprite frame from the heading and run the fire-decision
   timer `$C43C`.
6. Retire off-screen (`+$0E` past a Y bound) via `$B79F`.

The **variable-damage decode** appears verbatim in `$C11C`, `$C217` and `$C298`:
bit 6 of `+$14` contributes a flat +2, and the low 6 bits are fed through six
`RR`/`ADC A,D` steps — i.e. a population-count of the hit bits. **More
simultaneous hits = more damage**, so overlapping fire is genuinely worth more
than sequential fire.

## 5. Collision — two 1-D projections

This is the cleverest part of the engine and the part least likely to survive a
naive port.

Collision does not test rectangles. It builds **two independent 1-D occupancy
buffers**, one indexed by row and one by column, each 256 bytes:

- `$7Exx` — indexed from the object's **Y** position (`+$0D`/`+$0E`)
- `$7Fxx` — indexed from the object's **X** position (`+$0B`/`+$0C`)

### Pass 1 — stamp identities (`$BBE5`)

Each active object gets a **single distinct bit** (`C`, starting at 1 and
rotated left with `RLC C` per object). That bit is `OR`ed into 12 consecutive
rows of `$7Exx` and 8 consecutive rows of `$7Fxx` around the object's position,
and stored in the object's own `+$14`. The loop count is `6 - ($9D19)`, so at
most 6 objects are stamped in this pass; `$BC79` separately stamps `$80` — the
bit the Immunity POKE forces, i.e. the player's.

### Pass 2 — read back overlaps (`$BCE9`)

For each object with the right `+$04` bits, `$BCE9` pops `+$02/$03` into `IX`
and reads the object's mask heights from the **two bytes immediately before that
record** — `IX-$01` (Y extent) and `IX-$02` (X extent). It then:

```
C = OR of $7Exx bytes over IX-$01 rows   ; every object overlapping in Y
A = OR of $7Fxx bytes over IX-$02 rows   ; every object overlapping in X
(IY+$14) = A AND C                       ; overlapping in BOTH
```

So `+$14` ends up holding **the set of identity bits of every other object this
one overlaps**, computed with two linear scans instead of an N² rectangle test.
A handler testing "was I shot?" just tests a bit of `+$14`; bit 7 is the
player's bit (the Immunity POKE forces the mask byte to `$80`, which is what
makes that cheat work).

The X-projection accumulator is seeded `A = $40`, so bit 6 is always present in
that half — which is why handlers treat `+$14` bit 6 as a damage modifier rather
than an identity.

**Porting note:** this is a shared-mutable-buffer algorithm with a per-frame
clear (`$BBC2`) and an order dependency between the two passes. It ports as an
*algorithm*, not as code — and if a port silently substitutes AABB tests, the
population-count damage rule in §4 quietly changes the game's balance.

## 6. Graphics

### Descriptor records, not handlers

`+$02/$03` looks like a code pointer (`$6Bxx`) and was originally assumed to be
a per-frame handler. It is not: the bytes there do not decode as coherent Z80.
Every value resolves onto one of two record grids — `$6B42 + 17*n` (the 17-byte
descriptor table also used by the title-screen decoder `$7D98`) or
`$6BDB + 6*n` (the explosion/state descriptor table). The two bytes *before* the
record are the collision mask extents (§5). See `Level-Format.md` §4 for the
full derivation.

### Sprite format

Objects are drawn as **masked sprites**: each frame is a set of vertical 8px
strips, stored as interleaved `[pixel, mask]` byte pairs, with the **mask byte
stored bit-reversed** and flipped through the lookup table at `$9A00` to line up
with its pixel byte. A mask bit of 1 means transparent.

Sprites are **pre-shifted**: successive frames in a group are the same artwork
shifted one more pixel right, generated at load time by `$7E4A` (`$7DF3`
interleaves the pixel/mask pairs; `$7D98` generates the mirrored halves through
`$9A00`). This trades RAM for speed — the blitter never shifts at runtime.

Sprite groups in memory:

| Address | Sprite |
|---------|--------|
| `$CA29` | Plane (player, 24×16) |
| `$CD49` | Plane moving |
| `$D069` / `$D389` / `$D6A9` | Cannon N / E / NE |
| `$D9C9` / `$DCE9` | Tank broken N / E |
| `$E009` / `$E329` | Boat broken N / E |
| `$E649` / `$E969` / `$EC89` | Enemy plane N / E / NE |
| `$EFA9` | "S" box (power-up) |
| `$F129` | Big Plane |
| `$F199` | Bullet ball (16×8) |
| `$F299` | Explosion (16×16, 8 animation phases) |

The `N` / `E` / `NE` suffixes are facing directions; handlers select among them
by folding the heading into `+$06` with `ADD A,$03 / AND $38 / RRCA×3` — an
8-way direction quantisation of the 64-step angle.

### The draw pass — `$AC8D`

`$AC8D` (445 instructions, the largest routine in the game and still largely
undocumented) is the per-object rendering pass. It reads `+$06`, `+$0D`/`+$0E`
and the `+$04` flags, sets the shared blit parameters `$9C13` (destination
screen address), `$9C15` (source data, `POP`-fed), `$9C1A` (width/pass count)
and `$9C1B` (height/Y offset), maintains flag bit 5 (on-screen) and bit 0
(suppress redraw), and hands off to the blitter bytecode.

The blitters themselves are jump-table indices `$00`-`$12`, dispatched by the
formation-script interpreter `$AFB8`:

- `$00`-`$07` — tile blits into the 2×2 tile-block tables (`$7900`-`$7CFF`)
- `$08`-`$0F` — **masked sprite blits**, in four variants × two heights:
  8-row/16-row × mask-reversed/pixel-reversed, each with ascending or
  descending column stride
- `$10`-`$12` — OR-composite and screen-strip copies

Each blitter body is a fully unrolled `POP`/store sequence (16 or 8 iterations)
using `SP` as the source pointer and self-modified opcodes for the row stride —
fast on a Z80, and another algorithm that must be rewritten rather than
translated.

## 7. Movement scripts

Script-driven objects (`+$05` = `$0C`, `$0E`) run a bytecode interpreter each
frame:

- **`$B8F9`** counts down the per-object frame delay `+$18`. When it expires it
  reads the next script byte and dispatches it.
- **`$B920`** classifies the byte: bit 7 set = a **wait** (low 7 bits = frame
  count; the special value 1 means a *random* wait of 1-32 frames via the LFSR
  `$B7FE`). Bit 7 clear = a movement step.
- A movement step's low 3 bits select one of 8 opcodes through the `$A076`
  sub-table; bits 3-6 are the opcode's parameter, carried in `C`.
- If a step returns carry set, the interpreter loops immediately and executes
  the next script byte in the same frame; carry clear ends the frame.

| Opcode | Master idx | Action |
|--------|-----------|--------|
| `$00` | `$3B` | dispatch sub-command (`C` bits 3-6) via `$A082` |
| `$01` | `$3C` | set `+$19` (from `C`, or the next script byte if `C`'s nibble is 0) |
| `$02` | `$3D` | set absolute heading, apply velocity |
| `$03` | `$3E` | turn heading relative, apply velocity |
| `$04` | `$3F` | set/clear mirror flag (`+$04` bit 6) |
| `$05` | `$40` | set N object fields from script (offset,value pairs) |
| — | `$41` | clear velocity |
| — | `$42` | loop back in script until `+$19` expires |
| — | `$43` | apply velocity |
| — | `$45` | set alive flag (`+$04` bit 1) |
| — | `$46` | turn heading toward the player (`$9C6D`) |
| — | `$47` | set random column (`+$0C`) |
| — | `$48` | randomly set/clear facing flag (`+$04` bit 7) |

Opcodes `$3D`/`$3E` mirror their heading when `+$04` bit 7 (facing left) is set,
so one script drives both left- and right-hand formations.

Script pointers live in `+$15`/`+$16`; `$B94E` fetches the next byte and
advances them. The bytecode pool itself is shared and variable-length — see
`Level-Format.md` §4.

## 8. The player plane in detail

### Movement — `$BE03` → `$BE4A`

1. Bail out if the immobilise flag `$9C3B` is set (fly-in cutscene, below).
2. Count down the invulnerability timer `+$18`; while it runs, `+$06` is forced
   to `(timer AND 7)` — that is what makes the plane flash after respawning.
3. If the global immunity flag `$9C6B` bit 7 is set, call `$BF22` (player hit).
4. Read input (`$68B1`) into `$9CDE`, Kempston-layout: bit 0 = Right,
   bit 1 = Left, bits 2-3 = vertical.
5. Horizontal: step X by `$0060`, and set the **bank target** `B` — 2 for right,
   0 for left, 1 for neither.
6. Vertical: step Y by `$0060`.
7. Clamp X to `$0700`-`$18E0` and Y to `$0300`-`$18E0`.
8. Bank animation: `+$16` is the current bank frame, `+$17` the target, `+$15`
   the delay timer. The current bank steps toward the target **one frame per
   expiry**, never snapping — a 5-frame delay is armed on each direction change
   (`+$04` bit 4 marks banking in progress). The resulting bank value indexes
   the sprite-frame table at `$9B4C` into `+$06`.
9. Call `$BF42` (bomb).

### Bomb — `$BF42`

Triggered when the input state `$9CDC` equals `$09`. On press: decrement the
bomb count in the player's record (`IX+$09`), set bit 2 of the deferred-event
mask `$9C27` (screen flash), add to a bonus accumulator, and point the flash
sequence at `$9C5E`. On **release** (`$9CDC` reaches exactly 1) it allocates the
actual bomb-explosion object from the free list, copies its initial fields from
the spawn-parameter table `$6BB9`, and positions it at the player's location.

### Fly-in cutscene — `$BED4`

While `$9C3B` (immobilise) is set, the plane is flown automatically: `$B845`
computes the angle from a fixed target record at `$9CB5`, `$B8A2` converts it at
speed 3, and `$BA0A` applies it. The sequence ends when the plane reaches row
`$11` at column `$0E`. `+$06` is forced to frame `$06`, or to `$04`/`$00`
depending on the sign of dx (`+$07` bit 7). When the counter runs out, `$A599`
ratchets the player state forward and normal control resumes.

### Being hit — `$BF22`

Tags the object that hit the player (`$9C77`'s record) with the current wave tag,
sets the player's `+$18` reaction timer to `$0E`, repoints `+$02/$03` at
descriptor `$6B86`, sets `+$06 = $06`, and arms a 38-frame ($26) death/respawn
timer at `$9C3C` — the sentinel `$A561` polls each frame.

### Respawn / blink — `$BDAE`

If `+$0F` bit 7 is set the object is blinking: the timer counts down, Y advances
by `$20`/frame, and when it reaches `$80` (or the low count reaches 0) flag bit 2
is set again and normal updating resumes.

### The player *record* is not the player *object*

Two different things, easy to conflate in a port:

- The **plane object** — a 29-byte pool object, pointer in `$9C6D`.
- The **player record** — a 12-byte block holding persistent per-player state,
  P1 at `$9C79`, P2 at `$9C85`, active one pointed to by `$9C77`, selected by
  `$9C76` (1 or 2).

Player record layout (offsets from the block base, as `IX+n`):

| Offset | Field | Init (`$A5C0`) |
|--------|-------|----------------|
| `$00`-`$02` | score, 3-byte packed BCD | 0 |
| `$03` | lives (capped at 10 by `$A189`) | P1 = 2, P2 = 3 |
| `$04` | bonus-life threshold index into `$9CB8` | 0 |
| `$06` | per-level config index (read by `$A612`) | 0 |
| `$07` | wave/formation tag (scanned by `$A4E7`) | 0 |
| `$08` | wave-group id | 1 |
| `$09` | bombs | 3 |
| `$0A` | difficulty scale (folded into fire-rate baseline `$9C40`) | 0 |
| `$0B` | bonus follow-up count (consumed by `$C5D2`) | 2 |

`$A7D7` handles death: in 2-player mode it hands control to the other player if
they still have lives (updating `$9C77` and toggling `$9C76`), then decrements
the now-current player's life count.

## 9. Enemy aiming and fire — `$C43C`

Shared by every enemy that shoots.

1. Count down the shared reload timer `$9C42` (reloaded from `$9C43`); return
   until it expires. Both values come from the per-level config row, so **fire
   rate is a level property, not a per-enemy one**.
2. Return if `+$04` bit 0 (busy) is set or bit 5 (on-screen) is clear, or if
   `+$1A` is `$FF` (no target).
3. `$B845` computes a coarse angle (0-63) from the enemy to the player
   (`IX = ($9C6D)`) — a hand-rolled atan2 built from position deltas, quadrant
   bookkeeping, an octant refinement and a linear-search division. No lookup
   table.
4. Turn `+$1C` toward that angle by a **rate-limited ±4 step** rather than
   snapping — enemies visibly swing onto target.
5. Quantise the new heading into an 8-way sector, store it in `+$1A`.
6. Fire only if the heading now matches the target angle *and* free object slots
   remain (`$9D1A - $9D1B`).

`$B845`'s accuracy characteristics (linear-search division, ±4 clamping) are
part of the game's feel; replacing it with a real `atan2` in a port will make
enemies aim visibly better than the original.

## 10. Formation bookkeeping — `$B79F`

When an object finishes, `$B79F` clears a bit in the formation-slot bitmap at
`$9B50` (indexed as `$9B50 + 2*(+$13)`) and decrements the counter in the byte
*before* it. So the 15-byte region from `$9B4F` is really **interleaved
`[counter, bitmap]` pairs**, one per formation slot — `$BA5F` scans it for the
first free slot, `$B730` clears it at wave start.
When that counter reaches zero the slot is marked done (`+$13 = $FF`) and the
group's completion effect fires — either `$C648` (decrement the wave-group
counter and, if the group is cleared, set up the bonus-award animation) or
`$C5D2` (convert to explosion), depending on `$9C3F`. Finally the group counter
`$9D18` is decremented.

Its tail from `$B7DC` (an `SP = IY` stack trick that appears to unlink the object
and return it to the free list at `$9D1C`) is **not yet fully traced**.

## Data location summary

| Data | Address |
|------|---------|
| Object pool (19 × `$1D` bytes) | `$9D40`-`$9F66` |
| Free-list head | `$9D1C` |
| Persistent list-head slots | `$9D1E` / `$9D24` / `$9D2A` / `$9D30` |
| Secondary object stack pointer | `$9D30` |
| Group counters | `$9D18` / `$9D19` / `$9D1A` / `$9D1B` |
| Player object pointer (global aim target) | `$9C6D` |
| Player records | `$9C79` (P1) / `$9C85` (P2), active via `$9C77` |
| Active player number | `$9C76` |
| Global hit-flag accumulator | `$9C6B` |
| Collision buffers | `$7E00`-`$7EFF` (Y) / `$7F00`-`$7FFF` (X) |
| Bit-reverse lookup table | `$9A00` |
| Player bank-frame table | `$9B4C` (3 bytes, immediately before the bitmap) |
| Formation-slot `[counter, bitmap]` pairs | `$9B4F` (15 bytes) |
| Object state/animation jump table | `$A000` (objects at base `$A052`) |
| Movement-script opcode sub-table | `$A076` |
| Bonus-life threshold table | `$9CB8` |
| Score-value table | `$A094` (3 bytes/entry) |
| Masked sprite data | `$CA09`-`$F498` |

## Open questions

- **`$AC8D`** (445 instructions) is the object render pass but is still untitled
  and largely uncommented. It is the single largest gap in the disassembly.
- The player's **gun** has no located spawn path. `$BF42` covers the bomb only;
  whether the forward gun is a real object, part of the render bytecode, or
  purely a collision-mask artefact is untraced.
- `+$1B`'s purpose (spawn-template byte 3 plus the difficulty offset `$9C41`).
- `$B79F`'s `$B7DC` tail — the presumed unlink/free sequence.
- Why the X-projection accumulator is seeded `$40` in `$BCE9`, and whether
  `+$14` bit 6 has a meaning beyond "always set".
- Whether the 4 persistent 6-byte slots at `$9D1E`+ are all list heads or
  whether some carry other per-group state; only `$9D1E` and `$9D30` have
  confirmed roles.
- `$9C84` is both player-1's record offset `$0B` and the base `$A612` indexes
  with a 13-byte stride. Almost certainly a coincidental address overlap (the
  strided reads land past the player blocks), but not confirmed — compare the
  identical `$5B56` overlap noted in `Level-Format.md`.
- Handler indices `$05`/`$06`, `$09`/`$0A`/`$11` map to the same routines
  (`$C075`, `$C199`); what distinguishes those actors is presumably their
  descriptor record and template fields, not their code — unverified.
