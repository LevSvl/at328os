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

CCFLAGS = -mmcu=atmega328p -Wall -Os -nostdlib -ffreestanding -g -c
LDFLAGS = -e _start -m avr5 -nostdlib

OBJECTS = ${ENTRY_DIR}/entry.o \
	${USART_DIR}/usart.o \
	${LED_DIR}/led.o \
	${PRINTF_DIR}/printf.o \
	${KERNEL_DIR}/main.o \
	${MEM_DIR}/sram.o \
	${MEM_DIR}/progmem.o \
	${PROC_DIR}/proc.o

${ENTRY_DIR}/entry.o: ${ENTRY_DIR}/entry.s
	${AS} -g -c -Wall -mmcu=atmega328p -I${INCLUDE} -o ${ENTRY_DIR}/entry.o ${ENTRY_DIR}/entry.s

%.o: %.c
	$(CC) $(CCFLAGS) -o $@ $< -I$(INCLUDE)

%.o: %.s
	${AS} -g -c -mmcu=atmega328p -I${INCLUDE} -o $@ $<


kernel: ${OBJECTS}
	${LD} ${LDFLAGS} ${OBJECTS} -o ${KERNEL_DIR}/out.elf
	${OBJCOPY} -R .eeprom -O ihex ${KERNEL_DIR}/out.elf ${KERNEL_DIR}/out.hex
	$(OBJDUMP) -S ${KERNEL_DIR}/out.elf > ${KERNEL_DIR}/out.lst

DUDE = avrdude
DUDECONF = avrdude.conf
COM = /dev/ttyS3

DUDEOPTS += -C${DUDECONF} -patmega328p
DUDEOPTS += -carduino -b57600 -D -P${COM}
DUDEOPTS += -Uflash:w:${SRC}/main/out.hex:i

MINICOM = minicom
MINICOMOPTS += -D /dev/ttyS3 -b 9600
MINICOMOPTS += -F addcarreturn=on

flash: kernel
	${DUDE} -C${DUDECONF} ${DUDEOPTS}	
	${MINICOM} ${MINICOMOPTS}

serial:
	${MINICOM} ${MINICOMOPTS}


.PHONY: clean

clean:
	rm ${OBJECTS}
	rm ${KERNEL_DIR}/*.elf
	rm ${KERNEL_DIR}/*.hex
	rm ${KERNEL_DIR}/*.lst