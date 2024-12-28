#include "types.h"
#include "m328Pdef.h"

void sleep(int n)
{
    for(int i = 0; i < 1000000*n; i++) ;
}

int main()
{
    // LED_BUILTIN - PB5

    while(1) {
        PINB = (1 << PINB5);   
        sleep(20);
        PINB = (0 << PINB5);   
        sleep(20);
    }
  
    return 0;
}
