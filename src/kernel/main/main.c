#include <avr/pgmspace.h>

#include "defs.h"

#define OK() while (1) 

char a[] = {0xAA,0xBB, 0xCC, 0xDD};

void main()
{
    // sram_init();
    usart_init();
    proc_init();

    create_task((uint16_t)blink);
    scheduler();
    // blink();

    while(1);
    OK();
}
