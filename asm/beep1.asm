; BEEP1 — first ti-choir test program
;
; Plays a slow square-wave tone on the link port (1-bit audio).
; Timing uses CPU cycle delays, so pitch drifts with battery voltage.
;
; Target: TI-83 Plus / TI-84 Plus (and SE), run from a shell or Asm(.
; Quit: CLEAR

#define PROG_NAME "BEEP1"

#include "ti83plus.inc"
#include "linkport.inc"
#include "audio.inc"

; Approximate "C3" (~131 Hz) at 6 MHz — empirically tune on hardware.
; Lower HL → higher pitch. Adjust if your model runs faster (e.g. 15 MHz SE).
#define NOTE_DELAY	$015E	; HL delay per half-cycle (smaller = higher pitch)
#define NOTE_HALF_CYCLES	250

	.org	9D93h-2
	.db	t2ByteTok, tasmCmp

main:
	; Start with speaker line low
	in	a, (LINK_PORT)
	and	LINK_OUT_OFF
	out	(LINK_PORT), a

	bcall(_RunIndicOff)

.main_loop:
	ld	hl, NOTE_DELAY
	ld	b, NOTE_HALF_CYCLES
	call	playSquare

	; Short gap between tone bursts
	ld	hl, $03FF
	call	delayHL

	bcall(_GetKey)
	cp	skClear
	jr	nz, .main_loop

	bcall(_RunIndicOn)
	ret
