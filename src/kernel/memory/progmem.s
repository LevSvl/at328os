.include "m328Pdef.inc"

.text

.globl pgm_read_word
pgm_read_word:
    out 0x1E, r24
    out 0x1F, r25

    lpm r25, Z+
    lpm r24, Z+

    ret