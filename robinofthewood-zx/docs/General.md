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
guards, boars, the arrow, Bishop, the Sheriff of Nottingham — are documented
in `Actors.md`.

## Input

`$C95A` calls `$D1E9`, which dispatches through a pointer at `$D275` to the active
control scheme's handler: joystick ports, keyboard, or user-defined keys via `$D191`,
which tests the 5 stored key codes at `$D277` using `$D176`. The handler returns a
direction bitmask through `$D1F1`, which cancels opposite bit pairs (both left+right,
or both up+down). Every handler is expected to return the same FUDLR layout (bit 0
right, 1 left, 2 down, 3 up, 4 fire) - confirmed for `$D1A2`/`$D191`, but `$D1AB`
(Sinclair joystick, control-scheme option 2) does not match it: simulating its exact
bit-shuffle shows key 9 (up) sets bit 0, which every other handler and `$CD42`'s facing
table treat as "right" - a real bug in that control scheme, not just unconfirmed.

`$C95A` then only accepts a *changed* direction bit (right/left as one pair, down/up as
another, and separately the fire bit) once Robin is aligned to a cell boundary on that
axis - a direction pressed mid-cell is dropped for the frame rather than queued, taking
effect only once he reaches the next cell. The filtered mask is saved to `$CC8B`, then
runs collision tests (`$DD6F`/`$DD80`/`$DD93`/`$DD9F`, each converting a pixel position
to a shadow-attribute address via `$DDD6` and testing 2-3 cells for a solid/occupied
tile via `$DDB1`/`$DDC5`) before committing Robin's move.

## Combat and hazards

Which routine hits what, and how each actor reacts, is in `Actors.md`. The parts that
are game-wide rather than per-actor:

- **Overlap test**: `$BEE3` is shared by every contact check — `|dx| < D and |dy| < E`
  against a box supplied by the caller.
- **Energy**: `$BE25` decrements the energy value at `$BF6F` (0-`$0F`) and redraws the
  bar via `$BF37`. At critical energy (`$02`) it instead sets animation code `$6E`,
  which `$C9E7` routes to `$CB9D` — a short border-flash, an extra-life-counter penalty and a
  timed recovery. That is a stagger, not a game-over; Robin keeps playing.
- **Energy display**: a fixed pair of branching antlers, static pixel art from the font
  glyphs at `$AF0B` (upper half) and `$AF83` (lower half), 15 glyphs each. The shape
  never changes — `$BF37` recolours a 63-byte attribute strip over the artwork, so the
  antlers' colour reflects the energy value.
- **Extra-life counter** (`$D5A4`): incremented by `$D91A`, called only from `$BEDA` (special
  enemy defeat) and `$CBAA` (critical-hit stagger, netting against its own -1 via
  `$CBA8`) in the static disassembly. A regular guard killed with the sword did **not**
  increment it in testing, so it appears reserved for arrow kills and/or the special
  enemy. `$D91A` prints the green archer figure at `$B51F` (2x2 glyphs `$93`/`$94` top,
  `$95`/`$96` bottom, bright green/black) followed by the counter's ASCII digit.
  Live-tested: picking up a wreath (`$B536`, glyphs `$9D`-`$A2`) increments this
  same counter by 1, confirmed with a clean test (no guard contact, energy unchanged at
  `$0F`, counter `$00`->`$01` matching the HUD digit) — but no wreath-pickup call site to
  `$D91A` is visible in the static disassembly, so it must be reached indirectly (e.g. via
  a jump table), not by a literal `CALL $D91A`. A regular sword kill does **not**
  increment it - there's no score in this game, so killing a guard has no mechanical
  reward beyond removing the threat; he stops shooting/chasing and that's it.
  `$CBA5`'s critical-hit penalty decrements this counter twice with no
  underflow guard - at a count of 0 or 1 extra lives it wraps to `$FE`/`$FF`, both of
  which have bit 7 set, the "game over" flag `$C055` checks. This is the actual
  lives-based death path: `$C055` then prints the GAME OVER message at `$B663` (real
  text starts at `$B665`, after `$D619`'s 2-byte position header) - a separate, shorter
  string from the "CONGRATULATIONS..." victory text at `$B6AC`, even though the two
  share one data block. The victory text is reached only via `$D085` (see below), never
  from `$C055`.

## Rooms, events and messages

- **Text printing**: `$D619`/`$D631` are the shared print-string entry points into a core (`$D661`) that draws glyphs via `$D6D6`-family font-address math and shadow-screen XOR-plotting. Two passes over the data: the first draws glyphs, honouring in-string control codes `$01` (2x2-icon row-stack) and `$02`/`$03` (per-glyph horizontal mirror - bit-reverses the glyph's row bytes through the `$FD00` table, confirmed on `$B4C1`'s bow icon); the second reads the data immediately after the string's `$00` terminator as one attribute byte per glyph (`$FF` between rows) and writes it to the shadow/real attribute area - confirmed by rendering several icons (`$B4B8`, `$B434`, `$B4C1`) with their real trailing bytes. Message text and position data live in the table at `$D7CE`. Glyph codes `$20`-`$5F` are literal ASCII in this font (confirmed: `$B6AC`'s victory message decodes directly as "CONGRATULATIONS"/"YOU HAVE "); higher codes are the custom icon/decoration glyphs used throughout the `$D7CE` table.
- **Room-entry / message triggers**: `$D57A` holds up to 9 (position, type) trigger zones written by the print routine when it encounters certain control codes; `$D7F3` scans this table each frame against Robin's position and prints/queues associated messages or sounds. One trigger type calls `$D944`, which plays a short border-flash beep (`$D9E9`) and increments the entry's counter - confirmed to match the short beep heard on picking up a key/item. A related table at `$D543` (11 slots) logs recently-visited room/position pairs (`$D997`) and is scanned by `$D5A7` on room entry to print position-specific messages; `$D454` seeds its first two entries at game start.
- **Special-event rooms are the Witch's rooms**: a 9-entry table at `$DBCD` lists rooms with scripted one-off effects (`$0002`, `$000D`, `$0044`, `$004E`, `$0064`, `$0074`, `$008E`, `$0095`, `$00C1`); `$DA0F` checks it on room entry and, on a match, arms an "extra frame" callback (`$C4D3`, normally a no-op via `$DB17`) consumed by `$C4D2` when redrawing the room. Confirmed live: each of these rooms is otherwise an ordinary forest room, distinguished only by a magenta attribute overlay near the door - the fixed set of places a player-sourced walkthrough independently describes as "where you'll definitely meet the witch". A `$D595` 8-slot queue (see `$D94B`, its writer - fed from `$D7F3`'s room-authored pickup-trigger zones) holds pending gold (`$02`) and flower (`$05`) tokens picked up anywhere; once Robin's door-flash animation in one of these 9 rooms completes a cycle, `$DB18` resolves them: every flower token is removed first (up to 3) - 1 just taken, 2 refills energy to full, 3 (or more, excess left queued) warps Robin to room `$CC` ("the garden in front of the castle") - and only once no flowers remain does a single gold token get removed (nothing given back). This matches the walkthrough's stated rule exactly: flowers are always taken ahead of gold, and the Witch takes nothing if the queue is empty (though whether her sprite is suppressed in that case is unconfirmed - no draw routine for her has been located yet, see `Actors.md`).
- **Random pickup placement** (previously misdocumented here as "extra guard spawning" - `$D4B1` is not a separate table, it's the message-number byte of each `$D4AD` entry, `$D4AD`+4): `$D4AD` is a fixed 30-slot, 5-byte-per-entry (room, screen position, message number) table; at game start `$D3F3` places 6 wreath/extra-life pickups (message `$01`, one guaranteed, five more into random free slots) and `$D402` (also re-entered from `$D5A7` on room entry, gated by `$D5A6`) places a random 6-10 flowers (message `$05`) and 8-12 quivers (message `$07`, `$B57C` - inferred icon) into other random free slots, found via `$D47D`. `$D5A7` scans this table for the current room and prints whichever icon (if any) was placed there. Confirmed against a player-sourced walkthrough: "these locations may or may not hold an item, and which item, is decided randomly by the game" - exactly this mechanism.
- **Scripted ambush / capture**: one room per game, rolled by `$CFB3` from the table at `$D3A2` (distinct from `$CF71`'s opening-scenario picks), triggers the ambush described in `Actors.md`, which warps Robin to room `$9C` — the barred dungeon gate listed under landmark rooms below. Confirmed against play: this and the intro (`$CE62`) are the only places "evil laughter" plays, and it is what the player experiences as Robin's capture/death. No separate energy-zero game-over has been found; a critical-energy hit stagger-recovers via `$CB9D` instead of ending the game.
- **Second teleport destination, room `$CC` - the castle**: `$C4D2`'s teleport logic (triggered by the `$DBEA` state byte armed via `$DA0F`'s special-event mechanism above) isn't only the `$9C` ambush warp — state `$01` warps to `$9C`, but any *other* non-zero `$DBEA` value warps to room `$CC` instead. `$DBEA` is set by `$DB18`'s event-resolution scan: `$DB3F` sets it to `$2` (the generic trigger frame, warping to `$CC`) on completing a scripted event, `$DB66` sets it to `$1` (warping to `$9C`) otherwise - i.e. `$CC` is exactly the Witch's 3-flower reward destination (`Actors.md`). A player-sourced walkthrough independently confirms `$CC` is "the castle": it describes teleporting there deliberately (via 3 flowers) once per game to obtain a key good for the rest of the game, and warns a Witch always guards the way back out, draining every carried item before letting Robin leave. The persistent-key mechanic itself hasn't been traced in code yet.
- **Carried-items cap**: the `$D595` 8-byte queue (`Actors.md`'s Witch/Bishop/Ent sections) doubles as Robin's inventory - confirmed by a player-sourced walkthrough's "maximum of 8 carried items", matching the array size exactly. `$D94B`'s blind FIFO push (a new pickup enters at `$D595`, the oldest falls off `$D59C`) explains the walkthrough's warning that a carelessly-picked-up flower can silently bump out a gold bag once full.
- **Hardcoded landmark rooms**, confirmed live (teleporting Robin via `$C548` at the `$C22F` room-transition point):
  - `$65`/`$6E` (message group `$4E`, checked by `$C462`) — a matched pair of forest doors. `$65` also has a small gold chest and a purple hooded figure.
  - `$79`/`$BB` (message group `$4D`, checked by `$C462`) — a gate-and-key pair: `$79` is a barrel cellar behind a closed gate, `$BB` holds the key (visible as an item sprite in the bushes) that opens it.
  - `$9C` — the barred cave/dungeon gate `$B867` warps Robin to after the Sheriff of Nottingham's scripted ambush.
  - `$69` — a second win condition. `$BF80`'s edge-of-map handling (`$BFF5`) checks the new room number after any off-the-edge step; landing specifically on `$69` calls `$D085`, which prints the victory message (message `$50` via `$D631`) and side-wipes back, entirely separately from `$C055`'s own ending.
  - The **Ent's room** — one of 4 possible rooms (`$D38E`), rolled once per game by `$CF71` (`$D3B2`) - confirmed by a player-sourced walkthrough ("4 places on the map where the magic tree can stand"), not a fixed room number. Decorated via `$C56A`'s token list, which places room blocks `$1C`-`$1F` (`$659B`/`$662C`/`$66BD`/`$673F`) as a 2x2 arrangement - confirmed by a player screenshot as the large red tree-face figure. `$DF03` is the actual purchase logic: while standing in this room, once 3 of the 8 `$D595` queue slots read `$02` (3 bags of gold robbed from the Bishop of Peterborough), it sets the sword flag `$D59D` on the first payment, the bow flag `$D59E` on the second, then a magic arrow on each of the third through fifth (tracked by `$D5A1`) - confirmed by the same walkthrough: "for every 3 bags you'll be given, in sequence: sword, bow, three magic arrows one at a time." Each completed payment also blinks the Ent's eye: the attribute cell it flashes (shared door-marker code, `$588D`/`$5894`) happens to fall inside block `$662C` (the Ent's top-right quarter) in this room, turning solid red (`$12`) then back to its normal green (`$04`) after a delay - confirmed by a player screenshot of the effect.
  - The **Hermit's room** — one of 3 distinct rooms (`$D392`'s 4 slots, entries 3/4 duplicate), rolled once per game (`$D3B4`), decorated via `$C573`'s token list, blocks `$24`-`$27` in the same 2x2 layout as the Ent - confirmed by a player screenshot as the thatched hut. This is also the room `$CFC7` points the Hermit's own actor at (`$BC59`/`$BBC1`, previously undocumented here as "the roaming object" before being identified) - see `Actors.md` for the full heal/reward mechanic, confirmed against a player-sourced walkthrough.
  - **Robin's starting room** (`$D3B6`) — not an independently-rolled room: `$CF71` sets it to a copy of whatever room Robin's own random start lands on (`$C548`, swapped to `$D2` if that room is `$9C`, avoiding a clash with the dungeon-gate landmark), then decorates it via `$C57C`'s token list, blocks `$20`-`$23` in the same 2x2 layout as the Ent - a "split tree", confirmed by a player screenshot and by a player-sourced walkthrough as a deliberate landmark unique to the starting room (placed nowhere else on the map, matching the walkthrough's claim exactly).

## Startup / menu

- `$CD6C` is the top-level menu/intro procedure (title screen, key-redefinition screen `$D0FF`/`$D140`/`$D156`, control-scheme menu `$D0CB`, random starting scenario via `$CF71`, interrupt setup `$D095`, initial state clear `$D3BB`).
- **Digitized speech** ("Will you help Robin..."): confirmed live by breaking mid-playback. `$CD6C`'s very first instructions write a bit-count of `$1644` (5700 bits) into `$E500` and call `$8CAA` (the 1-bit border-flash bitstream player) reading from there. A live memory read at `$E500` during actual playback showed genuine, non-trivial bitstream data (not zero - an earlier snapshot check that showed all-zero must have been captured after `$CD86` cleared the buffer, later in the same routine). So the speech data lives at `$E500`-`$E7CE` (2-byte count + ~712 bytes of bitstream), played once via `$CD7A` before the menu is drawn. The "ha-ha-ha-ha" laugh (`$8C8D`, heard later on capture/game-over) reuses the same `$8CAA` player with its own data at `$8CD4` (172 bytes: count `$00AC` = 172 bits, then the bitstream), replayed ~11 times at rising pitch for the "ha-ha-ha" cadence.
- **Continuous menu "music"**: a real, small beeper music engine, not border-flash crosstalk and not a growing-tune bitstream:
  - `$8A79`/`$8A7E`/`$8A83` each point `$8AAF` at a **playlist** for their screen (`$8B82` main menu, `$8C3E` game over, `$8C74` victory): 3-byte entries (header byte, 2-byte phrase address), ending in a `$00` header. The header's low nibble is a repeat count; the high nibble (`$80`/`$A0`/`$C0`/`$E0`) selects an effect (plain/echo/drums/... by ear) applied to the phrase.
  - Each phrase (e.g. `$8BA7`, length-prefixed - confirmed for `$8BA7` itself: first byte `$0B`=11 matches its 11 data bytes exactly) is a sequence of note bytes, processed two at a time by `$8AAF`. Per note byte: **bits 0-4** select a pitch (0-31, into `$8B60`); **bits 6-7 of the second byte in each pair** select a duration class (1-4, extracted at `$8B17` via `RLCA`/`RLCA`/`AND $03`) that sets the note's playback countdown length (`$8B1E`). Bit 5 isn't used anywhere in the decode.
  - `$8B60` is a 32-entry chromatic pitch/period table for the beeper (indexed 0-31 via `$8B57`): consecutive values' ratios all cluster around 1.059 = 2^(1/12), the equal-temperament semitone ratio, spanning ~2.5 octaves; entry 0 fits the same progression only when read as `$100` (256), not literal zero. Absolute frequencies (computed by simulating `$8B27`'s loop's exact fixed T-state cost at 3.5MHz, since only the D-counter's underflow toggle is ever tested for output - see below): entry 0 (`$100`) ~71Hz (near C#2/D2) up to entry 31 (`$2D`) ~401Hz (near G4).
  - `$8AAF`'s player loop (`$8B27`-`$8B48`) is re-invoked continuously while the menu idles waiting for a key, and on one specific countdown condition sets **bit 4 of port `$FE`** - the real beeper/EAR bit - giving genuine tones, not just border-colour bits (0-2). The loop actually runs two independent countdown counters (C from the first decoded note, D from the second), each toggling one bit of an accumulator on underflow, but only D's toggle bit is ever tested (`AND $02`) before the `OUT` - so of each processed note pair, only the second note's period actually drives the audible tone; the first note's countdown is computed but has no audible effect.
  - Not yet fully decoded: bit 5 of the note byte, why the engine decodes an audibly-inert first note per pair, and precisely how the playlist header's effect nibble modifies playback (echo/drums).
- **Game-start intro sequence**, confirmed against player observation: on pressing start, the room/scenario roll happens first (`$CF71`/`$CFB3`/`$CFC7`), then `$CE3C`-`$CE44` prints message `$0F` (`$B434`, the Odin logo itself, spelled out in font glyphs) onto the cleared shadow screen; `$CE47` side-wipes the menu away (`$CE81`'s transition) to reveal it. Behind the logo, `$CE4E`-`$CE5F` silently draw the actual starting room and initialise game state; `$CE62` plays "evil laughter" (`$8C8D`) over the logo; then `$CE65` side-wipes again, revealing the already-drawn room underneath - the "opening" effect back into gameplay.
- Interrupts run in IM 2 (`$D095`), vectoring through a table at `$FFF4`/`$FFFF` to `$DFE7`, an interrupt-safe wrapper around the border-flash sound generator at `$DFF4`/`$E00D` (used throughout for short "beep" effects via border colour changes — see also `$8CAA`, a more general bitstream-driven border-flash sound player used for effects like "evil laughter").
- Menu item selection (`$8A86`, reached via `$8A79`/`$8A7E`/`$8A83` for the main menu, GAME OVER screen, and victory screen respectively) waits for exactly one key from a header-tagged list of options, each entry choosing colour/flash/timing via its header byte, decoded through `$8AAF`/`$8B57`.
- `$BF80` is the main per-frame game loop, called once per frame: menu-key check, Robin update, arrow/guard/special-enemy updates, all collision/hit checks, screen flush, event scanning, HUD draw, and room-edge/room-transition handling.
- `$C055` shows the victory message and returns to the menu once the extra-life count reaches its "game complete" state. `$D085` prints the same underlying victory text (they share the "CONGRATULATIONS.../ROBIN OF THE WOOD/...ARCHERY CONTEST..." string blob, `$C055` via a hardcoded pointer at `$B663`, `$D085` via `$D631`'s message table, index `$50`) but is reached by walking off the world-map edge into room `$69` - a second, independent way to win, unrelated to the extra-life count.

## Randomness

There is no real PRNG; code repeatedly reads the Z80 `R` register (`LD A,R`) as a cheap pseudo-random source, sometimes additionally stirred by XORing a running seed byte at `$D38D` (`$CE6D`).

## Open questions

- Per-actor open questions (the duplicated `$AC13` triples, the `$DEAB` region) are listed in `Actors.md`.
- Most of the 16 entries in `$D7CE` are now identified, but the actual custom-font *text* (as opposed to icons or known-context messages) is still unread pixel-by-pixel. Icons (rendered and confirmed): `$00`/`$B4B8` sword (shown in the main menu, `$AC83`), `$01`/`$B536` wreath, `$02`/`$B512` bag of gold, `$04`/`$B556` arrow, `$05`/`$B548` flower, `$06`/`$B52E` key, `$0E`/`$B630` closed door/gate (printed by `$C48A` for the `$65`/`$6E` landmark pair), `$0D`/`$B5F9` open/missing door/gate (printed by `$C4AC` for the `$79`/`$BB` gate/key pair). `$0F`/`$B434` is the Odin logo itself (printed by `$CE44` right before `$CE47`'s side-wipe reveals it) - not a message in the usual sense, just the logo spelled out in glyphs. Plain literal text (from the `$ACC6`-region strings they point at): `$08`-`$0C` are the menu control-scheme options ("0 START".."4 CURSOR"). `$10`/`$B6AC` decodes as plain ASCII in this font ("CONGRATULATIONS"/"YOU HAVE ") and is the victory text printed by `$D085`/`$D08E` - a separate, shorter GAME OVER string sits earlier in the same data block, printed by `$C055` from `$B663` (real text at `$B665`, after `$D619`'s 2-byte position header). `$07`/`$B57C` is a quiver of arrows, laying flat - the gameplay pickup icon, distinct from `$B567`'s upright HUD quiver (`$DF03`'s bow-sale pair) - see the pickup-placement bullet below. Outside this table, printed by direct address rather than message number: `$B567` (quiver, confirmed) and `$B4C1` (bow, confirmed) are `$DF03`'s "bow bought" pair, `$B495` (sword, confirmed) is `$DF03`'s sword-bought message and also `$D7F3`'s type-`$00` trigger. `$03`/`$B504` renders as a bow-like shape but has no confirmed call site printing message index `$03` and hasn't been seen in the game - unknown/possibly unused. Still unread: whatever the general hint-trigger system (`$D57A`/`$D94B`) prints for values outside this table's fixed slots. The `$79`/`$BB` key/gate pairing is very likely cosmetic, not a coded mechanic: no code anywhere compares the room number against `$79` except `$C462`'s hint-message print (gated only by quest-stage `$D5A1`, not by any "has key" flag), and no boolean tracking a key pickup at `$BB` was found anywhere in the disassembly. `$D454` does permanently seed a `$D543` room-position-log entry for `$BB` (message `$06`/`$B52E`, confirmed by rendering as a key icon), but that's just the "key visible here" hint marker shared with other landmarks, not an inventory/gate-state mechanism.
