#include "types.h"

#include "defs.h"

extern void pgm_read_byte();


void cpy_f2s(char *dst, uint16_t src, uint32_t sz)
{
    uint32_t i;

    for(i = 0; i < sz; i++){
        char byte = ((char (*)(uint16_t))pgm_read_byte)(src + i);
        *(dst + i) = byte;
    }
}