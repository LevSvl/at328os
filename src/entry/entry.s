.include "m328Pdef.inc"

.text

.globl main
.globl _start
_start:
    
    # allocate 4096 bytes for stack
    nop

    ldi r16, 0x5f
    out SPL, r16
    ldi r16, 0x04
    out SPH, r16
    
    jmp main
    nop
