// #include <avr/pgmspace.h>

#include "types.h"
#include "m328Pdef.h"
#include "defs.h"
// #include "mem.h"

static void nop()
{
    while (1);
}

__attribute__ ((__progmem__)) const char fstr[] = "kernel";

int main()
{
    usart_init();

    char g[8];
    cpy_f2s(g, fstr, 8);

    printf(g);

    blink();
    nop();
    return 0;
}
