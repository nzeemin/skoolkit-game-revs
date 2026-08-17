# Rendering

How the game draws the screen: an off-screen buffer it composes into, the tile
and sprite data it draws from, the coordinate "fold" used everywhere, and how the
finished image reaches real video memory.

## Double buffering

The game never draws characters straight onto the visible screen. It composes
into an **offline buffer** that mirrors the ZX Spectrum's screen layout, then
copies the changed parts to real video RAM. This keeps the picture from tearing
or flickering while sprites move.

| Region | Address | Notes |
|--------|---------|-------|
| Offline pixels | `$E000`–`$F7FF` | 6144 bytes, same layout as the ZX screen |
| Offline attributes | `$F800`–`$FAFF` | 768 bytes |
| Real screen pixels | `$4000`–`$57FF` | ZX video RAM |
| Real screen attributes | `$5800`–`$5AFF` | |

The offline buffer's top 2 character rows are the status bar (score, lives); the
remaining 22 rows hold the play area.

## Graphics data

| Data | Address | Notes |
|------|---------|-------|
| Background tile pixels | `$9800` | 8x8 tiles |
| Background tile colours | `$6300` (`bktile_colors`) | one attribute per tile |
| Room tile map | `$6040` | 22 x 32 indices, one byte per cell (see Room-Format.md) |
| Personage sprite bank | `$A000`–`$BFFF` | pixels + masks, both facings (see Actors.md) |
| Text font | `$3C00` | 8x8 characters |

## The coordinate fold

Positions are held as `(row, column)` in 8-pixel cells. Turning that into a
screen or buffer address needs the ZX Spectrum's non-linear screen layout, so the
same bit-fold appears throughout the drawing code (`$D626`, `$D60E`, `$C2EC`,
`$C366`, `$DECD`, `$C3CB`, and the key/object code): the row's high bits are
rotated down and XOR-masked into the column to produce the byte address, and the
row's low bits pick the pixel line within the character cell. Any routine that
takes "tile coordinates (H = row, L = column)" is about to run this fold.

## Scene tiles

A room is a grid of 8x8 tiles (the `$6040` map). Two routines paint them:

- `draw_scene_element` (`$C2C0`) — draws one 8x8 tile straight into the offline
  buffer at a fixed destination, given the tile's element index. Used to paint the
  whole room when it loads.
- `draw_scene_tile` (`$D626`) — redraws one tile at a given room coordinate,
  looking the graphic up from the map and updating both the pixel buffer and the
  matching colour so they stay in sync. `$D60E` is the same but for callers that
  already hold the tile index. These are used to repaint tiles that change during
  play (cracks, water, opened doors).

A companion/shadow copy of the map at `$5D00` (and a second map at `$6800`) lets
the game know the untouched background so it can restore tiles a sprite passed
over.

## Personage sprites

Characters are multi-cell sprites blended over the background. Full detail is in
Actors.md; in short:

- `draw_pers` (`$C3CB`) reads the character's pose descriptor (width x height in
  8x8 cells, plus the cell indices) and draws each cell into the offline buffer.
- `$C44D` blends one cell using its mask: it punches a hole in the background with
  the mask, then drops the sprite pixels in, so the sprite is transparent around
  its edges. The mask for a cell sits `$1000` above its pixels in the sprite bank.
- Left-facing sprites are a separate pre-mirrored copy `$800` higher in the bank.

## Getting to the real screen

- `update_screen` (`$C29C`) copies the entire offline buffer to video RAM — used
  after big changes (room load, full redraw).
- `show_pers_area` (`$C2EC`) copies just the small rectangle a character occupies
  from the offline buffer to the screen, pixels then attributes. This is the
  normal per-frame update: only the moving characters' patches are copied, which
  keeps it fast and flicker-free.
- `update_pers_backgr` (`$C366`) repaints the room background over the patch a
  character has just vacated (in the offline buffer), so no smear is left behind.

## Text

- `draw_message` (`$C924`) prints a string by drawing each byte with
  `draw_char` (`$C908`), which renders one 8x8 font character straight onto the
  real screen from the font at `$3C00`.
- `draw_message_and_invalidate` (`$C933`) does the same and flags the screen for a
  redraw.
- The score/status header is assembled by `$C93C` (colour fill + player number +
  score digits) and drawn by `$C960`.

## Per-frame flow

Each frame the main loop (`$C714`, from `$C7A4`):

1. Erases each character from the offline buffer by repainting the background over
   its old cell (`update_pers_backgr`).
2. Runs each character's movement/AI step, which updates its position.
3. Redraws each character into the offline buffer at its new position
   (`draw_pers`).
4. Copies the affected patches to the real screen (`show_pers_area`), or does a
   full `update_screen` when a bigger change flags it.

## Open questions

- Exact purpose of the second tile map at `$6800` versus the `$5D00` shadow copy.
- Whether the status-bar rows use a different draw path from the play area.
