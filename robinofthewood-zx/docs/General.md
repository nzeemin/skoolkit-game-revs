# Robin of the Wood — General Internals

Reverse-engineering notes on the game's architecture, gathered from `robin.ctl`. Room/screen data format (world map, room types, additional elements, blocks) is covered separately — see `Room-Format.md`; the actors and the object system that drives them, in `Actors.md`.

## Screens and world map

The world is a 16x20 grid of rooms (320 cells, 318 used — see `$79F9`), each room built from a room type plus optional additional elements. Room numbers are packed 16-bit values: high nibble is the column (0-15), the rest is the row (0-19). Moving between rooms is a one-cell step on this grid, done by `$C22F`, driven by direction bits (bit 0/1 = step right/left, bit 2/3 = step down/up), with row wraparound at 0/19.

The visible game screen is 256x144 (32x18 character cells), rendered onto a shadow area and copied to the real ZX Spectrum screen; the leftmost and rightmost 2 character columns are decorative margins not part of play area.

## Shadow-screen architecture

Two shadow buffers are used instead of drawing directly to the real Spectrum screen ($4000-$5AFF):

- **`$EB00`** — shadow pixel data, 144 lines x 32 bytes, matching the real screen's pixel layout.
- **`$E800`** — shadow attribute data (one byte per 8x8 cell), matching $5800.
- **`$E500`** — a "dirty cell" staging/change buffer. Used both to save background pixels under a sprite before drawing it (so it can be restored later) and as a generic changed-cell queue: code writes glyph/marker bytes here as things change, and `$C85C` periodically scans it and flushes changed cells to the real screen. `$C517` does a full-screen column-by-column wipe using the same flush mechanism, for scene transitions.
- **`$C18E`** copies the whole shadow attribute area unconditionally to the real screen (18 rows x 28 bytes) — used for full redraws.
- **`$C806`** expands a per-row pointer table (`$FE00`) into shadow-screen rows; the `$FE00` table itself is built once at startup by `$D004` from the standard non-linear ZX screen-row addressing (192 entries, one per pixel line, based at $4000).

Room drawing (`$C072`) fills `$EB00`/`$E800` from the room type + additional element token lists (see `Room-Format.md`); `$C0AF`/`$C0D1` draw individual block tokens, with horizontal mirroring available via the bit-reversal table at `$FD00` (built once at startup by `$CFEE`) and consumed by `$C1D6` (block pixel/attribute mirror) and `$C8B7`/`$C8D0` (sprite frame mirror).

## Sprite / object system

Game entities are fixed-size **object records** advanced by the shared routine `$C8F7`,
which draws and erases frames through `$C6D6` by XORing pixel data into the shadow
screen (glyph rows are (position, length, source) tuples, drawn by `$C723`). Frame
mirroring uses the same `$FD00` bit-reverse trick as room blocks.

The record layout, the frame-list format, and each individual actor — Robin, room
guards, door guards, the arrow, the special enemy, the ambush figure — are documented
in `Actors.md`.

## Input

`$C95A` calls `$D1E9`, which dispatches through a pointer at `$D275` to the active
control scheme's handler: joystick ports, keyboard, or user-defined keys via `$D191`,
which tests the 5 stored key codes at `$D277` using `$D176`. The handler returns a
direction bitmask through `$D1F1`, which cancels opposite bit pairs (both left+right,
or both up+down).

`$C95A` then cancels bits against the previous frame's state and runs collision tests
(`$DD6F`/`$DD80`/`$DD93`/`$DD9F`, each converting a pixel position to a shadow-attribute
address via `$DDD6` and testing 2-3 cells for a solid/occupied tile via
`$DDB1`/`$DDC5`) before committing Robin's move.

## Combat and hazards

Which routine hits what, and how each actor reacts, is in `Actors.md`. The parts that
are game-wide rather than per-actor:

- **Overlap test**: `$BEE3` is shared by every contact check — `|dx| < D and |dy| < E`
  against a box supplied by the caller.
- **Energy**: `$BE25` decrements the energy value at `$BF6F` (0-`$0F`) and redraws the
  bar via `$BF37`. At critical energy (`$02`) it instead sets animation code `$6E`,
  which `$C9E7` routes to `$CB9D` — a short border-flash, a kill-counter penalty and a
  timed recovery. That is a stagger, not a game-over; Robin keeps playing.
- **Energy display**: a fixed pair of branching antlers, static pixel art from the font
  glyphs at `$AF0B` (upper half) and `$AF83` (lower half), 15 glyphs each. The shape
  never changes — `$BF37` recolours a 63-byte attribute strip over the artwork, so the
  antlers' colour reflects the energy value.
- **Kill counter** (`$D5A4`): incremented by `$D91A`. A regular guard killed with the
  sword did **not** increment it in testing, so it appears reserved for arrow kills
  and/or the special enemy. `$CB9D` applies a -1 that nets against `$D91A`'s +1. The
  scoring model for ordinary guards is still unclear.

## Rooms, events and messages

- **Text printing**: `$D619`/`$D631` are the shared print-string entry points into a core (`$D661`) that draws glyphs via `$D6D6`-family font-address math and shadow-screen XOR-plotting, honouring in-string control codes (bytes `$01`-`$03`) for colour/attribute state. Message text and position data live in the table at `$D7CE`.
- **Room-entry / message triggers**: `$D57A` holds up to 9 (position, type) trigger zones written by the print routine when it encounters certain control codes; `$D7F3` scans this table each frame against Robin's position and prints/queues associated messages or sounds. One trigger type calls `$D944`, which plays a short border-flash beep (`$D9E9`) and increments the entry's counter - confirmed to match the short beep heard on picking up a key/item. A related table at `$D543` (11 slots) logs recently-visited room/position pairs (`$D997`) and is scanned by `$D5A7` on room entry to print position-specific messages; `$D454` seeds its first two entries at game start.
- **Special-event rooms**: a 9-entry table at `$DBCD` lists rooms with scripted one-off effects (`$0002`, `$000D`, `$0044`, `$004E`, `$0064`, `$0074`, `$008E`, `$0095`, `$00C1`); `$DA0F` checks it on room entry and, on a match, arms an "extra frame" callback (`$C4D3`, normally a no-op via `$DB17`) consumed by `$C4D2` when redrawing the room. An 8-slot event-status array at `$D595` tracks progress through these; `$DB18`/`$DB98`/`$DB82`/`$DF03` resolve completed events (arrow-hit countdowns, energy refills, printing status messages from a shared pointer table at `$D9F9`) and remove/shift finished slots. Confirmed live: each of these rooms is otherwise an ordinary forest room, distinguished only by a magenta attribute overlay near the door (the `$C4D3` extra-frame drawing) — not a unique landmark, just a uniform "special encounter active here" marker.
- **Extra guard spawning**: `$D402` (called from `$D5A7` on room entry) randomly spawns additional guards of two types into a 30-entry slot table at `$D4B1` (free slots located by `$D47D`); the initial 6 guards (1 special + 5 normal) are seeded once at game start by `$D3F3`.
- **Scripted ambush / capture**: one room per game, rolled by `$CFB3` from the table at `$D3A2` (distinct from `$CF71`'s opening-scenario picks), triggers the ambush described in `Actors.md`, which warps Robin to room `$9C` — the barred dungeon gate listed under landmark rooms below. Confirmed against play: this and the intro (`$CE62`) are the only places "evil laughter" plays, and it is what the player experiences as Robin's capture/death. No separate energy-zero game-over has been found; a critical-energy hit stagger-recovers via `$CB9D` instead of ending the game.
- **Hardcoded landmark rooms**, confirmed live (teleporting Robin via `$C548` at the `$C22F` room-transition point):
  - `$65`/`$6E` (message group `$4E`, checked by `$C462`) — a matched pair of forest doors. `$65` also has a small gold chest and a purple hooded figure.
  - `$79`/`$BB` (message group `$4D`, checked by `$C462`) — a gate-and-key pair: `$79` is a barrel cellar behind a closed gate, `$BB` holds the key (visible as an item sprite in the bushes) that opens it.
  - `$9C` — the barred cave/dungeon gate `$B867` warps Robin to after the scripted ambush.

## Startup / menu

- `$CD6C` is the top-level menu/intro procedure (title screen, key-redefinition screen `$D0FF`/`$D140`/`$D156`, control-scheme menu `$D0CB`, random starting scenario via `$CF71`, interrupt setup `$D095`, initial state clear `$D3BB`).
- **Digitized speech** ("Will you help Robin..."): confirmed live by breaking mid-playback. `$CD6C`'s very first instructions write a bit-count of `$1644` (5700 bits) into `$E500` and call `$8CAA` (the 1-bit border-flash bitstream player) reading from there. A live memory read at `$E500` during actual playback showed genuine, non-trivial bitstream data (not zero - an earlier snapshot check that showed all-zero must have been captured after `$CD86` cleared the buffer, later in the same routine). So the speech data lives at `$E500`-`$E7CE` (2-byte count + ~712 bytes of bitstream), played once via `$CD7A` before the menu is drawn. The "ha-ha-ha-ha" laugh (`$8C8D`, heard later on capture/game-over) reuses the same `$8CAA` player with its own data at `$8CD4` (172 bytes: count `$00AC` = 172 bits, then the bitstream), replayed ~11 times at rising pitch for the "ha-ha-ha" cadence.
- **Continuous menu "music"**: a real, small beeper music engine, not border-flash crosstalk and not a growing-tune bitstream:
  - `$8A79`/`$8A7E`/`$8A83` each point `$8AAF` at a **playlist** for their screen (`$8B82` main menu, `$8C3E` victory, `$8C74` death/edge-of-map): 3-byte entries (header byte, 2-byte phrase address), ending in a `$00` header. The header's low nibble is a repeat count; the high nibble (`$80`/`$A0`/`$C0`/`$E0`) selects an effect (plain/echo/drums/... by ear) applied to the phrase.
  - Each phrase (e.g. `$8BA7`, length-prefixed - confirmed for `$8BA7` itself: first byte `$0B`=11 matches its 11 data bytes exactly) is a sequence of note bytes, processed two at a time by `$8AAF`. Per note byte: **bits 0-4** select a pitch (0-31, into `$8B60`); **bits 6-7 of the second byte in each pair** select a duration class (1-4, extracted at `$8B17` via `RLCA`/`RLCA`/`AND $03`) that sets the note's playback countdown length (`$8B1E`). Bit 5 isn't used anywhere in the decode.
  - `$8B60` is a 32-entry chromatic pitch/period table for the beeper (indexed 0-31 via `$8B57`): consecutive values' ratios all cluster around 1.059 = 2^(1/12), the equal-temperament semitone ratio, spanning ~2.5 octaves; entry 0 fits the same progression only when read as `$100` (256), not literal zero. Absolute frequencies (computed by simulating `$8B27`'s loop's exact fixed T-state cost at 3.5MHz, since only the D-counter's underflow toggle is ever tested for output - see below): entry 0 (`$100`) ~71Hz (near C#2/D2) up to entry 31 (`$2D`) ~401Hz (near G4).
  - `$8AAF`'s player loop (`$8B27`-`$8B48`) is re-invoked continuously while the menu idles waiting for a key, and on one specific countdown condition sets **bit 4 of port `$FE`** - the real beeper/EAR bit - giving genuine tones, not just border-colour bits (0-2). The loop actually runs two independent countdown counters (C from the first decoded note, D from the second), each toggling one bit of an accumulator on underflow, but only D's toggle bit is ever tested (`AND $02`) before the `OUT` - so of each processed note pair, only the second note's period actually drives the audible tone; the first note's countdown is computed but has no audible effect.
  - Not yet fully decoded: bit 5 of the note byte, why the engine decodes an audibly-inert first note per pair, and precisely how the playlist header's effect nibble modifies playback (echo/drums).
- **Game-start intro sequence**, confirmed against player observation: on pressing start, `$CE47` side-wipes the menu away (`$CE81`'s transition) to reveal the Odin logo; behind it, `$CE4E`-`$CE5F` silently draw the actual starting room and initialise game state; `$CE62` plays "evil laughter" (`$8C8D`) over the logo; then `$CE65` side-wipes again, revealing the already-drawn room underneath - the "opening" effect back into gameplay.
- Interrupts run in IM 2 (`$D095`), vectoring through a table at `$FFF4`/`$FFFF` to `$DFE7`, an interrupt-safe wrapper around the border-flash sound generator at `$DFF4`/`$E00D` (used throughout for short "beep" effects via border colour changes — see also `$8CAA`, a more general bitstream-driven border-flash sound player used for effects like "evil laughter").
- Menu item selection (`$8A86`, reached via `$8A79`/`$8A7E`/`$8A83` for the main menu, victory screen, and death/edge-of-map screen respectively) waits for exactly one key from a header-tagged list of options, each entry choosing colour/flash/timing via its header byte, decoded through `$8AAF`/`$8B57`.
- `$BF80` is the main per-frame game loop, called once per frame: menu-key check, Robin update, arrow/guard/special-enemy updates, all collision/hit checks, screen flush, event scanning, HUD draw, and room-edge/room-transition handling.
- `$C055` shows the victory message and returns to the menu once the kill count reaches its "game complete" state.

## Randomness

There is no real PRNG; code repeatedly reads the Z80 `R` register (`LD A,R`) as a cheap pseudo-random source, sometimes additionally stirred by XORing a running seed byte at `$D38D` (`$CE6D`).

## Open questions

- What actually rewards the player for a regular sword kill, if anything (`$D5A4` doesn't move) - the scoring/objective model for ordinary guards is still unclear.
- Per-actor open questions (guard flag bits, the duplicated `$AC13` triples, whether door guards are ever actually populated) are listed in `Actors.md`.
- The exact text of the in-game messages (custom font, doesn't decode as ASCII) — landmark rooms are now visually identified (see above), but the printed hint text itself is still unread. Also unconfirmed: whether opening `$79`'s gate with `$BB`'s key is actually implemented gameplay, or the key/gate pairing is coincidental to what's visible.
- Exact interaction between `$CB9D`'s counter adjustment and `$D91A`'s increment on `$D5A4` (net effect understood, intent less so).
