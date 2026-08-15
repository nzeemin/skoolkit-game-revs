# Actors (Personages)

Three characters share one set of code: **Bruce** (the player), and two enemies,
the **Ninja** and the **Green Yamo** (sumo). They are distinguished only by which
struct pointer is in IX; the same per-frame update, state machine, drawing and
combat routines run for all three. This mirrors the Atari port, whose
`UpdateState` loops over actors 0–2 the same way.

## The three structs

Each actor is described by a fixed-layout struct. The game holds three of them at
fixed addresses:

| Actor | Struct | Notes |
|-------|--------|-------|
| Ninja | `$CB1C` (`ninja_description`) | enemy |
| Green Yamo | `$CBBE` (`sumoist_description`) | enemy |
| Bruce | `$CCA5` | the player |

The main loop (`$C714`, around `$C7FA`) calls `pers_play_step` (`$D24E`) once per
frame for each of the three, in the order Ninja, Yamo, Bruce.

## Struct fields

Offsets are from the struct base (IX). Field addresses shown are for the Ninja.

| Off | Addr | Field |
|-----|------|-------|
| +$00 | $CB1C | Step-delay countdown (frames until the actor next acts) |
| +$01 | $CB1D | Step-delay reload value = movement speed (Ninja 4, Yamo 5) |
| +$02 | $CB1E | **State index** (also the sprite/pose index); `0` = not alive |
| +$03 | $CB1F | Facing direction: 0 = right, 1 = left |
| +$04 | $CB20 | Pixel-precise Y offset 0–7 / animation sub-frame |
| +$05 | $CB21 | Colour attribute |
| +$06 | $CB22 | X coordinate (8-pixel cells, top-left corner) |
| +$07 | $CB23 | Y coordinate (8-pixel cells, top-left corner) |
| +$08 | $CB24 | Previous X (used to repaint the vacated cell) |
| +$09 | $CB25 | Previous Y |
| +$0A | $CB26 | Flashing/dying counter; `0` = alive and healthy |
| +$0B | $CB27 | Desired action / decoded input for this frame |
| +$0C | $CB28 | Jump/walk cycle counter |
| +$0D | $CB29 | Walk sub-counter (times the walk→kick combo) |
| +$0E | $CB2A | Accumulated damage (hit counter) |
| +$0F | $CB2B | Saved pose, shown while flashing after defeat |
| +$10 | — | Respawn countdown (enemies) |
| +$11 | — | Pending kick/hit bonus flag (scored in `$D24E`) |

Fields +$10 and +$11 sit past the labelled part of the struct; their use is
inferred from the code (`revive_personage` counts +$10 down; the melee code sets
+$11).

## Per-frame update (`pers_play_step`, `$D24E`)

For one actor each frame:

1. **Dying?** If the dying counter (+$0A) is non-zero, run the death/flash
   sequence instead of normal play: advance the counter, flash the sprite between
   its saved pose (+$0F) and blank, and eventually leave the actor deactivated.
2. **Step delay.** Otherwise decrement the step-delay (+$00); if it hasn't reached
   zero the actor does nothing this frame (this is what sets each actor's speed).
   When it reaches zero, reload it from +$01.
3. **Dead body?** If the state/pose index (+$02) is `0`, jump to
   `revive_personage` (`$D2EB`) — enemies respawn after a countdown; Bruce is
   skipped.
4. **Decide the action.** Call `get_pers_action_will` (`$D675`) and store the
   result in +$0B. For Bruce this is his real decoded input; for enemies it is a
   simulated joystick value from the AI (see below).
5. **Touch objects.** `review_pers_location` (`$D4EC`) checks the tiles under the
   actor for hazards and collectables.
6. **Run the state handler.** Dispatch through the state table (below) to the
   handler for the current state, which moves the actor and returns the next
   state; store that back into +$02.
7. **Clamp** the resulting position and record the previous cell for redrawing.

## The state machine

The **state index is `(IX+$02)`**. It selects an entry in the actor's state table
(`ninja_images_refs` at `$CB32`, and the equivalents for Yamo and Bruce). Each
table entry is 4 bytes:

```
entry N (state N):  DEFW <sprite descriptor>, <handler routine>
```

- The **sprite descriptor** (first word) is used by `draw_personage` (`$C3CB`) to
  draw the actor.
- The **handler** (second word) is run by `$D24E`; it updates the actor and
  returns the next state in A.

Dispatch reads entry `(IX+$02) − 1` (state `0`/pose `0` means "dead", so live
states start at pose index 1). All three actors' tables point at the **same**
shared handler routines — only the sprite descriptors differ.

### States and handlers

State 15 is the "empty action" (`$CB8A`, a bare return).

| State | Handler | Meaning |
|-------|---------|---------|
| 0  | `$CD9B` | Idle — read input and pick the next state |
| 1  | `$CE48` | Walking — continue, re-read input |
| 2  | `$CF04` | Jump rising, check for floor landing |
| 3  | `$CF18` | Jump — obstacle/collision check against all actors |
| 4  | `$CF2D` | Walking — advance one column, bump off obstacle |
| 5  | `$CF59` | Kick/attack — execute swing, resolve hit |
| 6  | `$CFB3` | Jump apex, prepare landing |
| 7  | `$CFBD` | Jump rising (2 rows per tick) |
| 8  | `$CFCE` | Jump — diagonal motion via arc table |
| 9  | `$CFF8` | Jump — diagonal motion, advance column |
| 10 | `$D023` | Jump landing — step forward one column |
| 11 | `$D032` | Jump landing — check floor, resume walking |
| 12 | `$D03F` | Falling — descend, check for a rope catch |
| 13 | `$D063` | Climbing — up/down/left/right on a rope/ladder |
| 14 | `$D10D` | Climbing — dismount entry (falls into 13) |
| 15 | `$CB8A` | (empty) |
| 16 | `$D112` | Kick/attack recovery, award points on hit |
| 17 | `$D15D` | Enter climbing, snap to the ladder tile |
| 18 | `$D16F` | Being hit — recoil, or escalate to knockback |
| 19 | `$D198` | Hit reaction — apply damage and knockback flag |
| 20 | `$D1A2` | Recoil — step back after being blocked |
| 21 | `$D1D2` | Attack — melee-hit check against all actors |

## Input vs AI (`get_pers_action_will`, `$D675`)

Every actor is steered the same way: a single byte of "desired action" (a
joystick-style direction/button code) is fed into the state machine each frame
via +$0B. The difference is only where that byte comes from:

- **Bruce** normally uses his real decoded input. `$D675` returns immediately for
  him with the stored input (it only takes over during brief "computer plays"
  moments).
- **Enemies** are driven by the AI in `$D675`, which fabricates that same kind of
  input byte: it climbs ladders, avoids ledges and obstacles, heads toward or
  attacks the nearest target, and throws in an occasional random direction change
  so movement doesn't look mechanical.

Shared helpers the movement handlers lean on:

- `check_floor_below` (`$D332`), `check_ceiling_above` (`$D353`),
  `check_rope_below` (`$D405`) — scan the tiles around the actor's footprint.
- `check obstacle ahead` (`$D456` and its `$D45C`/`$D48F`/`$D43B`/`$D447` entries)
  — is the way blocked on the side faced.

## Combat, damage and death

- The attack handlers call `$D375` for each of the three actors to test for a
  landed melee hit; on a hit it adds to the target's damage total (+$0E), knocks
  it into a hurt state, and plays the hit sound. The Ninja takes single damage;
  the others take doubled damage.
- `$D1EB` decides when accumulated damage is enough to kill: it flags the actor
  dying (+$0A) and clears the tally. Killing an enemy awards Bruce points; Bruce
  dying scores nothing.
- On death the actor flashes (using its saved pose +$0F) and is deactivated
  (+$02 = 0). When Bruce finishes dying, the main loop calls `$CA46` to take a
  life and either end the game or restart the room / switch player.
- Enemies whose +$02 has reached 0 are brought back by `revive_personage`
  (`$D2EB`) once their respawn countdown (+$10) expires, dropped back at the
  room's spawn point. Bruce is never revived this way.

## Open questions

- Exact meaning of struct bytes past +$0F for Bruce vs the enemies (the tail of
  each struct differs, e.g. the "defeated pose" bytes at `$CB2A`+).
- Whether +$0C and +$0D are reused differently by different states.
- The precise contents of a sprite descriptor (width/height plus cell indices)
  are used by `$C3CB` but not fully broken out here.
