#include "types.h"
#include "defs.h"

extern void pgm_read_word();

void cpy_f2s(char *dst, const char *src, uint32_t nbytes)
{
    uint16_t (*pgm_rw)(uint16_t);
    uint32_t nwords, i;

    nwords = nbytes/2;
    pgm_rw = ((uint16_t (*)(uint16_t))pgm_read_word);

    for(i = 0; i < nwords; i++){
        uint16_t word_addr = ((uint16_t)(src + i))*2;
        uint16_t word = pgm_rw(word_addr);

        dst[i*2] = (uint8_t)(word >> 8);
        dst[i*2 + 1] = (uint8_t)word;
    }

}