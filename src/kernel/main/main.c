#include "types.h"
#include "m328Pdef.h"
#include "defs.h"

void nop()
{
    while (1);
}

int main()
{
    usart_init();
    nop();
}
