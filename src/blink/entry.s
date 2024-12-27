.text

.globl main
_start:
    
    # allocate 4096 bytes for stack
    nop

    ldi r16, 0x0
    out spl, r16
    ldi r16, 0x10
    out sph, r16
    
    jmp _start
    nop
