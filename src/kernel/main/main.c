#include "types.h"
#include "defs.h"
#include "mem.h"

static void nop()
{
    while (1);
}

PROGMEM const char fstr[] = "kslkernelll";
#define debug (({ cpy_f2s(fstr, fstr, ( sizeof(fstr) %2 ? (sizeof(fstr) + 1): sizeof(fstr))); fstr;}))
#define ERR blink
#define OK nop

int main()
{
    usart_init();
    printf(debug);

    ERR();
    return 0;
}
