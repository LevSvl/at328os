#include <avr/pgmspace.h>

#include "defs.h"

#define ERR blink
#define OK() while (1) 

int main()
{
    usart_init();

    printf_P(PSTR("lerme\0"));

    proc_init();


    ERR();
    OK();
    return 0;
}
