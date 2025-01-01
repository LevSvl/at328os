.include "m328Pdef.inc"

.text

.globl main
.globl _start
_start:
    
    # allocate 4096 bytes for stack
    nop

    ldi r16, 0xff
    out SPL, r16
    ldi r16, 0x08
    out SPH, r16
    
    jmp main
    nop
