#include <stdarg.h>
#include <avr/pgmspace.h>

#include "__udivmodsi4.c"
#include "defs.h"

static int 
convert(unsigned long x, int base, char buf[16])
{
  
  char digits[] = "0123456789abcdef";
  int i;


  i = 0;
  do{
    buf[i++] = digits[x % base];
  } while ( (x /= base) > 0);

  return i;
}

static void 
printint(int n, int base, int sign)
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
printf(char* fmt, ...)
{
  va_list ap;
  char p;
  union fmtval
  {
    int ival; // целое
    double bval; // дробь
    char* sval; // символ
    unsigned long ptrval; // указатель
  } fmtval;

  va_start(ap, fmt);

  while((p = pgm_read_byte(fmt))){
    if (p != '%'){
      usart_transmit(p);
      fmt++;
      continue;
    }
    switch (pgm_read_byte(fmt + 1))
    {
    case 'd':
      fmtval.ival = va_arg(ap, int);
      printint(fmtval.ival, 10, 1);
      break;
    case 'f':
      break;
    case 'x':
      fmtval.ival = va_arg(ap, int);
      printint(fmtval.ival, 16, 1);
      break;
    case 's':
      break;
    case 'p':
      fmtval.ptrval = va_arg(ap, unsigned long);
      printptr(fmtval.ptrval);
      break;
    }

    fmt++;
  }
  va_end(ap);
}