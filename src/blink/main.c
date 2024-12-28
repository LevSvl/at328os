#include "types.h"
#include "m328Pdef.h"


void _sleep()
{
    for(volatile int i = 0; i < 1000; i++) ;
}

int main()
{
    int i = 0;
    // LED_BUILTIN - PB5
    DDRB |= (1 << PINB5);
    while(i++ < 10000) {
        PORTB |= (1 << PINB5);
        _sleep();
        PORTB &= (0 << PINB5);   
        _sleep();
    }
    
  
    return 0;
}
