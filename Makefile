PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld
OBJCOPY = ${PREFIX}objcopy
OBJDUMP = ${PREFIX}objdump

SRC = src/kernel
INCLUDE = inc


LED_DIR = ${SRC}/led
ENTRY_DIR = ${SRC}/entry
USART_DIR = ${SRC}/usart
KERNEL_DIR = ${SRC}/main
PRINTF_DIR = ${SRC}/printf
MEM_DIR = ${SRC}/memory
PROC_DIR = ${SRC}/proc

CCFLAGS = -mmcu=atmega328p -Os -g -mrelax -e _start -I$(INCLUDE) # -fno-stack-protector

ALLOBJECTS = ${ENTRY_DIR}/entry.o \
	${USART_DIR}/usart.o \
	${LED_DIR}/led.o \
	${PRINTF_DIR}/printf.o \
	${KERNEL_DIR}/main.o \
	${MEM_DIR}/sram.o \
	${MEM_DIR}/progmem.o \
	${PROC_DIR}/proc.o \
	${PROC_DIR}/swtch.o

ASOBJECTS = ${ENTRY_DIR}/entry.o \
	${MEM_DIR}/progmem.o \
	${PROC_DIR}/swtch.o

SOURCES = ${USART_DIR}/usart.c \
	${LED_DIR}/led.c \
	${PRINTF_DIR}/printf.c \
	${KERNEL_DIR}/main.c \
	${MEM_DIR}/sram.c \
	${PROC_DIR}/proc.c \

${ENTRY_DIR}/entry.o: ${ENTRY_DIR}/entry.s
	${AS} -g -mmcu=atmega328p -I${INCLUDE} -o ${ENTRY_DIR}/entry.o ${ENTRY_DIR}/entry.s -I$(INCLUDE)

%.o: %.s
	${AS} -g -mmcu=atmega328p -I${INCLUDE} -o $@ $<


kernel: ${SOURCES} ${ASOBJECTS}
	${CC} ${CCFLAGS} -o ${KERNEL_DIR}/out.elf  ${SOURCES} ${ASOBJECTS}
	${OBJCOPY} -R .eeprom -O ihex ${KERNEL_DIR}/out.elf ${KERNEL_DIR}/out.hex
	$(OBJDUMP) -S ${KERNEL_DIR}/out.elf > ${KERNEL_DIR}/out.lst
	$(OBJDUMP) -t ${KERNEL_DIR}/out.elf | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > kernel.sym

DUDE = avrdude
DUDECONF = avrdude.conf
COM = /dev/ttyS6

DUDEOPTS += -patmega328p
DUDEOPTS += -carduino -b57600 -D -P${COM}
DUDEOPTS += -Uflash:w:${SRC}/main/out.hex:i

MINICOM = minicom
MINICOMOPTS += -D /dev/ttyS6 -b 9600
MINICOMOPTS += -F addcarreturn=on

flash: kernel
	${DUDE} ${DUDEOPTS}	
	${MINICOM} ${MINICOMOPTS}

serial:
	${MINICOM} ${MINICOMOPTS}


.PHONY: clean

clean:
	rm ${ALLOBJECTS}
	rm ${KERNEL_DIR}/*.elf
	rm ${KERNEL_DIR}/*.hex
	rm ${KERNEL_DIR}/*.lst

