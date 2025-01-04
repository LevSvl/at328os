// #include <avr/pgmspace.h>

#include "types.h"
#include "m328Pdef.h"
#include "defs.h"
#include "mem.h"

const char greet[14] PROGMEM = "kernel start\n";

static void nop()
{
    while (1);
}

int main()
{
    usart_init();

    char g[14];
    cpy_f2s(g, (uint16_t)greet, 14);

    printf((g));

    blink();
    nop();
    return 0;
}
