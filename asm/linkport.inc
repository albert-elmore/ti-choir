; Link-port 1-bit audio helpers (TI-83 Plus / TI-84 Plus family).
; Bit 2 on port 0 drives the data-out line (speaker hacks use this pin).

#define LINK_PORT	0
#define LINK_OUT_ON	%00000100
#define LINK_OUT_OFF	%11111011

; Set link data-out high (speaker on).
#define LINK_SPEAKER_ON \
	in a, (LINK_PORT) \
	or LINK_OUT_ON \
	out (LINK_PORT), a

; Set link data-out low (speaker off).
#define LINK_SPEAKER_OFF \
	in a, (LINK_PORT) \
	and LINK_OUT_OFF \
	out (LINK_PORT), a
