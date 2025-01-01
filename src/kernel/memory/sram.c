#include <avr/pgmspace.h>

void cpy_f2s(void *dst, void *src, uint32_t sz)
{
    uint32_t i;

    for(i = 0; i < sz; i++){
        uint8_t byte = (uint8_t)pgm_read_byte((uint8_t)src + i);
        *((uint8_t *)dst + i) = byte;
    }
}