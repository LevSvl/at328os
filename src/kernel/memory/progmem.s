.include "m328Pdef.inc"

.text

.globl pgm_read_byte
pgm_read_byte:
    # addr low -  в r24 
    # addr high - в r25
    ldi r24, 0
    ldi r25, 0

    out 0x1E, r25
    out 0x1F, r24

    lpm r20, Z
    mov r24, r20
    ret