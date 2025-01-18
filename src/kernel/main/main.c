#include <avr/pgmspace.h>

#include "defs.h"

#define ERR blink
#define OK() while (1) 

int main()
{
    usart_init();

    printf(PSTR("lerme\0"));

    ERR();

    OK();
    return 0;
}
