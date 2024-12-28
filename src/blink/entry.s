.include "m328Pdef.inc"

.text

.globl main
.globl _start
_start:
    
    # allocate 4096 bytes for stack
    nop

    ldi r16, 0x0
    out SPL, r16
    ldi r16, 0x10
    out sph, r16
    
    jmp main
    nop
