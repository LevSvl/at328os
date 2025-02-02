#include "types.h"
#include "defs.h"
#include "m328Pdef.h"


void _sleep()
{
    for(volatile int i = 0; i < 10; i++) ;
}

int blink()
{
    // int i = 0;
    // LED_BUILTIN - PB5
    printf("aaaaa");
    // DDRB |= (1 << PINB5);
    // PORTB |= (1 << PINB5);
    while(1) 
        ;
    
  
    return 0;
}
