#include "types.h"
#include "m328Pdef.h"

#define BAUD_RATE 9600
#define FOSC 16000000UL
#define UBRR ((FOSC/(16UL*BAUD_RATE))-1)

void usart_init()
{
    // setting the baud rate
    UBRR0H = (uint8_t)(UBRR>>8);
    UBRR0L = (uint8_t)UBRR;

    // setting frame format
    UCSR0C = (0<<USBS0) | (3<<UCSZ00);

    // enabling the transmitter
    UCSR0B = (1<<TXEN0);
}

void usart_transmit(uint8_t data)
{
    while ((UCSR0A & (1<<UDRE0)) == 0) {};
    UDR0 = data;
}