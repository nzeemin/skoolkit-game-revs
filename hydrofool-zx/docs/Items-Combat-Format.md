# Hydrofool Items, Creatures, and Scoring

Reference for the fire/pick-up system, creature behaviour, the Plug Room
delivery mechanic, and the end-game score counters. All addresses refer to
the 48K snapshot `hydrofool.sna`. Builds on `Room-Format.md` (dynamic
object system) and `Movement-Format.md` (input reading).

## 1. End-game stat counters

Three BCD byte counters, printed on the `$86CC` "DEATHBOWL DIVINED"
end-game stats screen via `$854F`:

| Address | Stat | Incremented by |
|---|---|---|
| `$6122` | "Gnomes Gnabbed" | `$8AFB` (picking up a kind-`$36` object) |
| `$6123` | "Goodies Gathered" | `$9341` (delivering an item to a Plug Room) |
| `$6124` | "Plugs Pulled" | `$94F4` (a Plug Room's delivery nibble reaching `$0F`) |

## 2. The fire/pick-up button (`$8AFB`)

Gated on bit 4 of the input mask (`$6186` — see `Movement-Format.md` §1).
Branches on whether a weapon is currently held (`$619E`):

- **Weapon held** → jumps to `$8D8D` (attack — not yet traced).
- **Nothing held, and the held-item pointer `$6110` equals the fixed
  "empty hands" sentinel record at `$788A`** → **pick up**.
- **Otherwise** (holding a regular item) → **drop**.

### 2.1 Pick up (`$8B2B`)

Plays a "reach out" animation, then walks nearby objects via `$9B5D` (the
same proximity/overlap helper used by movement collision — see
`Room-Format.md` §6.2), skipping any candidate whose kind byte is `$44`
(the shared "vulnerable creature" pose). For the first valid candidate
found:

- **Kind `$6E`** → calls `$6622` (not yet traced — likely a special item
  type, e.g. a key).
- **Kind `$36`** → treated as a **Gnome**: calls `$888E`, increments
  `$6122` ("Gnomes Gnabbed", BCD), plays sound effect `$04`, and finalizes
  via `$9A60` (the gnome is consumed on pickup).
- **Anything else** → searches a weapon lookup table at `$7C83` (via
  `$88E3`); if the object matches, sets the weapon-held flag `$619E`
  (and possibly a variant flag at `$619F`, gated on a `$3C` check) instead
  of picking it up outright.

In all non-gnome cases, the found record's address is stored into `$6110`
(now "held"), `$6895` is called (equip/HUD update — not confirmed), and
sound effect `$04` plays.

### 2.2 Drop (`$8BC4`)

Writes the **current room number** into the held item's table record
(byte 0), restoring it to the world, and re-derives its stored Y/X (record
bytes 1-2) from the player's own grid-aligned position (`$8DBB`/`$8DBC`)
— items are dropped at the player's feet. The exact bit-packing of the
combined Y/X byte isn't fully resolved.

## 3. Item persistence

Confirmed by live memory diffing (picking up a horseshoe): each item lives
in a 4-byte table record `(room, Y, X, sprite)`. Picking it up zeroes its
room byte (the mechanism `$8AFB` reverses on drop, §2.2); `$6110` then
points at that record as "currently held." A parallel table
(`$75B5`-`$792E`-ish region) holds variable-length spawner records
`(len, marker, handler_word, Y, X, type, flags, room-list...)` whose
handler words (`$9232`, `$921E`, `$9208`, `$9085`, `$90A8`) are per-type
behaviour handlers — likely how decorations/items actually get placed and
drawn per room, separate from the item-persistence table itself. Not
fully connected to §2's pickup code yet.

## 4. The room creature and the Plug Room delivery mechanic (`$9341`)

`$6663` spawns one object per room at build time (handler `$9341`), type
from the room description's `byte2`. This handler has two completely
different behaviours depending on the room:

### 4.1 Plug Room branch — item delivery detector

When `$62F9` confirms the current room is this level's Plug Room, `$9341`
does **not** behave like a creature at all — it checks whether *this
object's own sprite number* (`+0x08`) matches one of the 4 items still
needed (the level's per-slot required-item sprites, `$7287` bytes 2-5),
gated by that slot's undelivered bit in the level's state nibble (`$7287`
byte 1, low nibble — see `Room-Format.md` §4b).

On a match:
1. Sets the delivery bit for that slot.
2. Repositions itself at the matching corner-cube grid cell.
3. Increments `$6123` ("Goodies Gathered", BCD).
4. Plays sound effect `$01`, runs a short transform animation (via the
   `$919A` sprite table), then re-pokes the grid cell to the "delivered"
   marker `$13` and self-destructs.

This strongly implies the object's sprite (`+0x08`) is set *elsewhere* to
track whichever item the player is currently carrying/delivering — that
link (how carrying the right item near the Plug Room makes this object's
sprite match) is not yet found. If the state nibble is already fully
clear, the handler falls through to the normal creature branch instead.

### 4.2 Normal-room branch — settle physics and hit detection (`$93C1`)

- **Settle/float physics**: a height/Z field (`+0x07`) decays by `4` each
  frame toward a rest value `$18`, tested via `$9BF0` (collision) each
  step; if blocked, the height bounces back up by `4` instead of settling
  further. This produces a bobbing-at-rest-height look, not walking.
- **Hit detection**: if bit 2 of `+0x0D` is set (a "just hit by a weapon"
  flag — the code that sets it isn't traced yet), calls `$9401`.

### 4.3 Hit/defeat sequence (`$9401`)

Only proceeds if the creature's current sprite (`+0x08`) is `$44` (the
shared "vulnerable" pose — creatures presumably must be in this pose to
register a hit). Searches a `(room, position, reward-sprite)` triple table
at `$7C89` for an entry matching the current room and this object's
position field (`+0x09`). On a match:

1. Swaps the reward sprite into `+0x09` (and into offset `+3` of a linked
   record via `+0x0E`/`+0x0F`).
2. Plays sound effect `$01` (the same "success" sound as item delivery).
3. Steps through the `$919A` animation table to transform the sprite.
4. Finalizes (`+0x08` = reward sprite, a kind lookup via `$9AAB` into
   `+0x0A`, then `$9A60`) and resumes normal behaviour at `$93C1`.

Likely how a creature is "defeated" and turns into a collectible — quite
possibly a Gnome, tying back into §2.1's pickup path, though this isn't
confirmed.

## 5. Plug Room win-condition trigger (`$94F4`)

The Plug object's own per-frame handler (not just its spawn routine)
**polls every frame** for delivery completion: re-checks (via `$62F9` +
`AND $0F`/`CP $0F`) whether the level's state nibble has reached `$0F`
(all 4 items delivered). Once it has:

1. Increments `$6124` ("Plugs Pulled", BCD).
2. Plays sound effect `$09`.
3. Animates the plug popping out (`+0x07 += 8` per frame, gated by bit 4
   of `+0x0D` so this only fires once).
4. Self-destructs on the following frame (bit 6 of `+0x0D` check).

This is the actual per-room win-condition trigger — the moment a Plug
Room's plug visibly pops after the 4th item is delivered.

## 6. Open questions

- What sets bit 2 of `+0x0D` (the creature "just hit" flag) — the actual
  weapon-attack code (`$8D8D`, reached from `$8AFB` when a weapon is
  held) isn't traced.
- The `$7C89` room/position/reward-sprite hit table's exact byte layout.
- How a carried item's sprite gets linked to the Plug Room delivery
  detector's own sprite field (`+0x08` in `$9341`'s object) — the gap
  between "player is holding the right item" and "delivery detector
  notices."
- What kind `$6E` represents (handled via `$6622`, distinct from both
  Gnomes and weapons).
- The weapon lookup table at `$7C83`'s format, and what `$6895`/`$888E`/
  `$88D7` actually do.
- The exact Y/X bit-packing used when dropping an item (§2.2).
- Whether all 4 Plug Rooms need to be completed simultaneously/in-order,
  or independently — a live session found door access to a Plug Room
  gated (couldn't enter `$32` normally), suggesting an ordering
  requirement not yet traced in code.
- Whether `$9341`'s "defeated creature → reward" (§4.3) and "pick up
  Gnome" (§2.1) are the same mechanism or two unrelated systems that both
  happen to reuse sprite `$44`/kind `$36`.
