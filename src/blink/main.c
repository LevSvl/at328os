#include "types.h"
#include "m328Pdef.h"


void _sleep()
{
    for(volatile long i = 0; i < 70000; i++) ;
}

int main()
{
    // LED_BUILTIN - PB5
    DDRB |= (1 << PINB5);
    while(1) {
        PORTB |= (1 << PINB5);
        _sleep();
        PORTB &= (0 << PINB5);   
        _sleep();
    }
  
    return 0;
}
