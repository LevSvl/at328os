#include <stdarg.h>
#include <avr/pgmspace.h>

#include "__udivmodsi4.c"
#include "defs.h"

char digits[] = "0123456789abcdef";

static int 
convert(unsigned long x, int base, char buf[16])
{
  int i;


  i = 0;
  do{
    buf[i++] = digits[x % base];
  } while ( (x /= base) > 0);

  return i;
}

static void 
printint(uint16_t n, int base, int sign)
{
  char buf[16];
  int i;
  unsigned x;

  if (sign && (sign = n < 0))
    x = -n;
  else
    x = n;

  i = 0;
  i = convert(x, base, buf);

  if (sign)
    buf[i++] = '-';

  while (--i >= 0)
    usart_transmit(buf[i]);
}

static void
printptr(unsigned long n)
{
  int i;
  char buf[16];

  i = convert(n, 16, buf); 

  usart_transmit('0');
  usart_transmit('x');

  while (--i >= 0)
    usart_transmit(buf[i]);
}

void 
printf_P(char* fmt, ...)
{
  va_list ap;
  char p;
  int ival; // ?????
  double bval; // ?????
  char* sval; // ??????
  unsigned long ptrval; // ?????????

  va_start(ap, fmt);

  while((p = pgm_read_byte(fmt))){
    if (p != '%'){
      usart_transmit(p);
      fmt++;
      continue;
    }
    switch (pgm_read_byte(++fmt))
    {
    case 'd':
      ival = va_arg(ap, int);
      printint(ival, 10, 1);
      break;
    case 'f':
      break;
    case 'x':
      ival = va_arg(ap, int);
      printint(ival, 16, 1);
      break;
    case 's':
      break;
    case 'p':
      ptrval = va_arg(ap, unsigned long);
      printptr(ptrval);
      break;
    }
    fmt++;
  }
  va_end(ap);
}

void 
printf(char* fmt, ...)
{
  va_list ap;
  char *p;
  int ival;
  double bval; 
  char* sval; 
  unsigned long ptrval;

  p = fmt;

  va_start(ap, fmt);

  while(*p != 0){
    if (*p != '%'){
      usart_transmit(*p);
      p++;
      continue;
    }
    p++;
    switch (*p)
    {
    case 'd':
      ival = va_arg(ap, int);
      printint(ival, 10, 1);
      break;
    case 'f':
      break;
    case 'x':
      ival = va_arg(ap, uint16_t);
      printint(ival, 16, 1);
      break;
    case 's':
      break;
    case 'p':
      ptrval = va_arg(ap, unsigned long);
      printptr(ptrval);
      break;
    }
    p++;
  }
  va_end(ap);
}
