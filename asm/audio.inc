; Cycle-counted delay and square-wave playback.
; Pitch follows CPU speed (battery voltage) — intentional for the choir effect.

; Burn HL iterations.
delayHL:
	push	bc
	ld	b, h
	ld	c, l
.dh_loop:
	dec	bc
	ld	a, b
	or	c
	jr	nz, .dh_loop
	pop	bc
	ret

; Burn BC iterations (same loop body as delayHL).
delayBC:
.dbc_loop:
	dec	bc
	ld	a, b
	or	c
	jr	nz, .dbc_loop
	ret

; Play B half-cycles of a square wave.
;   HL = delay per half-cycle (smaller = higher pitch)
;   B  = number of half-cycles (duration)
playSquare:
.link_wave:
	LINK_SPEAKER_ON
	push	hl
	pop	bc
	call	delayBC

	LINK_SPEAKER_OFF
	push	hl
	pop	bc
	call	delayBC

	djnz	.link_wave
	ret
