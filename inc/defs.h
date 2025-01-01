#ifndef DEFS_H
#define DEFS_H

// sram.c
void cpy_f2s(void *dst, void *src, uint32_t sz);

// usart.c
void usart_init();
void usart_transmit(uint8_t data);

// printf.c
void printf(char* fmt, ...);

// led.c
int blink();

#endif  /* DEFS_H */