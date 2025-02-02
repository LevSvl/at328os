#include <avr/pgmspace.h>

#include "defs.h"

#define OK() while (1)

void main()
{
    // sram_init();
    usart_init();
    proc_init();

    create_task((uint16_t)blink);
    scheduler();

    OK();
}
