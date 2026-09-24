# Robin of the Wood — Collectibles

How the wreath, flower, quiver and bag-of-gold pickups are placed, displayed, collected,
carried and spent. Actor-side sources of gold (Bishop) and the Witch's consumption of the
carried-items queue are in `Actors.md`; the icon/glyph rendering mechanism is in `General.md`
and `Render.md`.

## The four pickups

| Item | Message # | Icon | Confirmed via |
|---|---|---|---|
| Wreath (extra life) | `$01` | `$B536` | rendered; message index `$01` in `$D7CE` |
| Flower | `$05` | `$B548` | rendered; HUD flower-count icon |
| Quiver | `$07` | `$B57C` (laying, world) / `$B567` (upright, HUD) | rendered; inferred from a walkthrough's "flower, extra life or quiver" set |
| Bag of gold | `$02` | `$B512` | rendered; HUD gold-bag-count icon |

Gold bags are **not** placed by the same random-placement system as the other three - they
only ever come from robbing Bishop of Peterborough (`$B919`, see `Actors.md`'s Bishop
section). Killing his escort makes `$B919` call `$D997` twice to drop two `$02` entries into
the room-position log at `$D543` (the same table below), at his tracked position - from
there they follow the identical placement/display/collect/carry pipeline described here. The
other three items are placed once, randomly, at game start.

## Placement — `$D4AD` (30 entries x 5 bytes)

Same 5-byte layout throughout this system: room lo, room hi, position D, position E, message
number. `$D4AD`'s message-number column is at `$D4B1` (`= $D4AD+4`).

Filled once, at game start, from `$D3BB`:

1. **`$D3F3`** — forces slot 0 to message `$01` (wreath), guaranteed; then finds 5 more free
   slots via `$D47D` and also sets them to `$01`. **6 wreaths placed in total, always.**
2. **`$D402`** (two near-identical halves, `$D5A6` selects which runs first) — rolls a random
   target count into B (**6-9 for flowers, 8-11 for quivers**, via the R register) and places
   that many `$05`/`$07` messages into free slots, tracking progress in the running counters
   `$D5A2` (flowers placed) / `$D5A3` (quivers placed).

`$D47D` finds a free slot: rolls a random start index 0-29, scans forward for a message-number
byte of `$00`, wrapping at 30. Confirmed against a player walkthrough: "these locations may or
may not hold one of the named items, and which item, both decided randomly by the game" -
matches exactly: some rolled locations may end up with `$00` (nothing) if the pickup counts
run out before every slot is touched.

## Room-position log — `$D543` (11 entries x 5 bytes)

Same layout as `$D4AD`, but filled at *runtime* rather than at game start:

- `$D997` logs Robin's current room+position into the first free (`$FF`) slot as he explores.
- Two entries are hard-coded by `$D454` before normal logging starts: `{$3D,$00,$30,$60,$06}`
  and `{$BB,$00,$58,$58,$06}` - both message `$06` (the key icon), likely permanent "always
  logged" hint markers for the two key/gate landmark rooms (see `General.md`'s `$79`/`$BB`
  bullet).
- Emptied to `$FF` by `$D3BB` at game start.

## Showing the icon in a room — `$D5A7`

Called on every room entry (`$BF80`/`$C4D2`/`$CD6C`). In order:

1. Continues the random flower/quiver placement via `$D402` (so placement can still be
   in progress across the first several room visits, not only at the very first frame).
2. Fills the 9-entry trigger table `$D57A` with `$FF` (fresh per room).
3. Clears `$DFE6` (the Ent's one-payment-per-visit latch, see below).
4. Scans `$D4AD` for the current room; if a non-empty entry matches, prints that pickup's
   icon at the logged position via `$D631`.
5. Scans `$D543` the same way for a room-position-log match.

So the icon a player sees in a room is drawn fresh every visit from whichever table (`$D4AD`
or `$D543`) still has a live entry for that room - not a persistent sprite object.

**The stored position (position D/E) is a literal top-left corner, not a center.** Traced
through `$D631`'s two passes (see `Render.md`'s "Position" section for the full byte-level
derivation): position D (X) divided by 4 gives the exact left character column with no
offset, and position E (Y) is used directly as the literal top pixel row the glyphs start
drawing from (multiplied straight by the 32-byte-per-row shadow stride, no division or bias
first). That's unlike Robin's own sprite draw (`$C585`), which biases X to his horizontal
center and Y to a near-top anchor - the message/icon printer has no such bias anywhere in its
position math.

## Collecting it — `$D7F3`

**A fixed-rectangle position test, not a sprite-vs-sprite hitbox.** No actor object record or
`$BEE3` bounding-box call is involved at all (that routine is reserved for guard/sword/arrow
hits) - a pickup is not a sprite the game tracks, it's a coordinate zone.

1. **Zone registration** happens as a side effect of *drawing* the icon: the text printer
   (`$D735`) notices an in-string control character while printing the pickup's glyph string
   and takes the first free (`$FF`) slot in the 9-entry table `$D57A`, storing the mode byte
   plus the **glyph's own screen address** as that slot's X/Y reference bytes. So the trigger
   zone is anchored to wherever the icon actually got printed, not to a separate authored
   hitbox.
2. **The test itself**, run every frame by `$D7F3` against each live `$D57A` entry:
   - `X = max($CC85, $18) - $18`, must satisfy `xref <= X < xref+$10` (16-pixel-wide band);
   - `Y = $CC86 + $0C`, must satisfy `yref <= Y < yref+$10` (16-pixel band).
   
   Both are plain `CP`/carry comparisons - no diagonal or partial-overlap logic, just two
   independent 1-D range checks.
3. **On a match**: the entry's type byte (`$00`/`$03`/`$06`/`$07` = sword/bow/key/quiver-style
   weapon icons, others chained) picks the message to print via `$D619`/`$D631`, then the
   trigger retires - wipes the matching `$D543` slot to `$FF`, clears the `$D4AD` slot's
   message-number byte back to `$00`, decrements the running spawn counters `$D5A2`/`$D5A3`
   for flower (`$05`)/quiver (`$07`) types, and dispatches to `$D944` (plays a sound,
   increments the trigger's own counter byte) then `$D94B` for the "add to carried items" step.

Not every field of `$D57A`'s 3-byte trigger-entry format is confirmed - only the
position-match and message-pointer roles are solid.

### Contrast with wall/scenery collision

Robin's *movement* collision (`$C95A`, calling `$DD6F`/`$DD80`/`$DD93`/`$DD9F` via `$DDD6`,
see `Render.md`) is a completely different, attribute-based system: it tests whether the
**shadow attribute byte** at the target cell is non-zero, i.e. whether a room block painted
anything there. Confirmed live this session: untiled "empty" background is genuinely `$00`
attribute, so Robin walks freely across it - there's no separate wall/collision layer, "is
this a wall" and "did the room artist draw something here" are the same question. Pickups,
by contrast, are never checked against attributes at all - purely the `$D57A` position-band
test above, so Robin can stand *on* a pickup's cell regardless of what's drawn there.

## Carrying it — `$D595` (8 bytes)

`$D94B` is the **only writer** of `$D595`. It's a blind FIFO: shifts the existing 7 bytes
(`$D595`-`$D59B`) one slot toward `$D59C`, and writes the incoming event value (from `$D9F6`,
set by `$D7F3`'s dispatch) into the freed front slot at `$D595`. Whatever byte falls off the
`$D59C` end is simply gone - **no explicit cap-check, just an unconditional push that
overwrites the oldest entry.**

This confirms a player walkthrough's exact warning: "maximum of 8 carried items... a
carelessly-picked-up flower can silently bump out a gold bag once full" - there's no warning
in the code either, it just happens.

`$D94B` also: plays a short sound, prints a HUD status message for the newly-queued item
(defaulting to `$B548` flower / `$B512` gold bag via the `$D9F9` pointer table), and - if the
value that just fell off the back of the queue was `$02` (gold) - falls into `$D997` to log
Robin's current position (this is the same routine that seeds `$D543` above; a gold bag
falling off the queue apparently re-triggers position logging as a side effect, not fully
explained by any single N-line and worth re-checking).

`$D595` is dual-used: it's also the special-event-room status array consumed by `$DA16`/
`$DB18` (see `Actors.md`'s Witch section) and read as an 8-slot inventory by `$DB98` (per-slot
HUD status messages) and `$DF03` (the Ent transaction, below).

## Spending it — `$DF03` (the Ent)

Called every frame, only acts while Robin stands in the Ent's room (`$D3B2`). Fully traced,
confirmed against a walkthrough:

- `$D5A1` is a shared quest-stage counter (also read by `$C462`'s forest-door hints). Only
  the magic-arrow branch below reads or advances it - sword and bow purchases are gated
  solely by their own flags (`$D59D`/`$D59E`) and never touch `$D5A1` - so it caps **arrow**
  purchases at 3, not the Ent's transactions overall.
- `$DFE6` (cleared every room entry) limits it to **one payment per visit** - leave and
  come back to pay again.
- While unset, throttled to roughly once a second (1-in-256 R-register roll).
- Counts how many of the 8 `$D595` slots currently read `$02` (gold bags). **Fewer than 3:
  nothing happens.** With 3 or more: removes 3 of them from the queue, prints per-slot status
  messages, knocks 3 off the arrow-hit counter `$D5A5`, then resolves the purchase:
  - sword flag `$D59D` clear -> buys the **sword** (prints `$B495`);
  - else bow flag `$D59E` clear -> buys the **bow** (prints `$B567` then `$B4C1`, extends the
    `$D5A0` arrow-hit countdown by 10);
  - else -> buys one of the **3 magic arrows**, one per payment, message selected by `$D5A1`.

So: **the full weapon-purchase price is always exactly 3 gold bags per item**, sword and bow
and each magic arrow, 5 purchases total (matching a walkthrough describing this exact
economy). A visual side effect: the Ent's eye (a specific attribute cell, picked by `$79F9`'s
mirror bit) flashes red then back to normal during the transaction, confirmed by a
player screenshot.

## Open questions

- The exact byte-level meaning of `$D57A`'s 3-byte trigger-entry format beyond
  position-match and message-pointer.
- Why a gold bag (`$02`) falling off the back of the `$D595` queue triggers `$D997`'s
  position-logging tail in `$D94B` - not explained beyond "that's what the code does."
- Whether `$D454`'s two hard-coded `$D543` entries are genuinely permanent markers or serve
  some other purpose - stated as "likely" only.
