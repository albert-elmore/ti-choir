# ti-choir

1-bit music for Z80-based TI graphing calculators. Each unit plays the same program in parallel; pitch drifts with CPU speed (battery voltage), so a dozen calculators slowly detune into a natural chorus.

## First program: BEEP1

`asm/beep1.asm` drives the **link port data-out line** (port 0, bit 2) as a square-wave “speaker.” Timing uses **cycle-counted delays**, not the crystal timer, so frequency follows CPU clock speed.

| Key | Action |
|-----|--------|
| (run) | Repeats a slow ~C3 tone with short gaps |
| **CLEAR** | Exit |

## Requirements

- **Calculator**: TI-83 Plus, TI-84 Plus, or Silver Edition (same link-port layout)
- **Shell**: MirageOS, Doors CS, or similar — or run via `Asm(` on the homescreen
- **Cable / output**: Link cable or 2.5 mm setup you use for 1-bit audio (same as Houston Music Tracker)
- **Assembler**: [spasm-ng](https://github.com/alberthdev/spasm-ng/releases)

Original TI-83 (non-Plus) uses a different ROM and program format; BEEP1 targets the Plus family first.

## Build

```bash
# Option A: install spasm-ng to your PATH, then:
make

# Option B: build spasm-ng into tools/ (needs a C++ toolchain):
make tools
make SPASM=tools/spasm-ng/spasm-ng
```

Output: `build/BEEP1.8xp`

## Load onto calculators

1. Connect via TI-Connect CE, TILP, or similar.
2. Send `build/BEEP1.8xp` to each calculator.
3. Run **BEEP1** from your shell (or `Asm(prgmBEEP1)` if applicable).

## Tuning

Edit these defines at the top of `asm/beep1.asm`:

```asm
#define NOTE_DELAY       $015E   ; smaller → higher pitch
#define NOTE_HALF_CYCLES 250     ; longer tone per burst
```

Use the same values on all units for the chorus experiment. Fresh vs weak batteries will spread the pitch over time.

## Project layout

```
asm/
  beep1.asm      — main test program
  linkport.inc   — link port speaker on/off
  audio.inc      — delay + square-wave playback
Makefile
build/           — generated .8xp files (gitignored)
```

## Next steps

- Slow multi-note “piece” (same delay-loop timing)
- Optional second target for TI-83 (non-Plus)
- Shared note table for a future choir score
