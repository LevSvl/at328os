#include "types.h"
#include "defs.h"
#include "mem.h"

PROGMEM const char fstr[] = "kernel";

static void nop()
{
    while (1);
}

#define ERR blink
#define OK nop
#define debug (({char buf[100]; cpy_f2s(buf, fstr, ( sizeof(fstr) %2 ? (sizeof(fstr) + 1): sizeof(fstr))); buf;}))

int main()
{
    usart_init();

    ERR();

    OK();
    return 0;
}
