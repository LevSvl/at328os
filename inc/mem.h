#define STACK_SIZE 512
#define MAXPA (0x8FF)

#define USTACK(n) (MAXPA - (n+1) * STACK_SIZE)

#define low(data) (data & 0xFF)
#define high(data) ((data >> 8) & 0xFF)

/*  SRAM LAYOUT
 __________________ 
|    IO + REGS     | 0x0
|__________________|
|       ...        | 0x100
|__________________|
|                  |
|     USTACK1      |
|__________________|
|                  |
|     USTACK0      |
|__________________|
|                  |
|      KSTACK      |
|__________________| 0x8ff

*/
