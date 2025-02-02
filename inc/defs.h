#ifndef DEFS_H
#define DEFS_H

// sram.c
void cpy_f2s(char *dst, const char *src, uint32_t nbytes);

// usart.c
void usart_init();
void usart_transmit(uint8_t data);

// printf.c
void printf_P(char* fmt, ...);

// led.c
int blink();

// proc.c
void proc_init();

#endif  /* DEFS_H */