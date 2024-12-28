PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld
OBJCOPY = ${PREFIX}objcopy
OBJDUMP = ${PREFIX}objdump

SRC = ./src
INCLUDE = ./inc


BLINK_DIR = ${SRC}/blink
ENTRY_DIR = ${SRC}/entry

CCFLAGS = -mmcu=atmega328p -Wall -Os -nostdlib
LDFLAGS = -e _start

OBJECTS = ${ENTRY_DIR}/entry.o ${BLINK_DIR}/main.o

${ENTRY_DIR}/entry.o: ${ENTRY_DIR}/entry.s
	${AS} -g -c -mmcu=atmega328p -I${INCLUDE} -o ${ENTRY_DIR}/entry.o ${ENTRY_DIR}/entry.s

${BLINK_DIR}/main.o: ${BLINK_DIR}/main.c
	${CC} ${CCFLAGS} -o ${BLINK_DIR}/main.o ${BLINK_DIR}/main.c -I${INCLUDE}

blink: ${OBJECTS}
	${LD} ${LDFLAGS} -Ttext 0x0 ${OBJECTS} -o ${BLINK_DIR}/out.elf
	${OBJCOPY} -j .text -j .data -O ihex ${BLINK_DIR}/out.elf ${BLINK_DIR}/out.hex



DUDE = avrdude
DUDECONF = avrdude.conf
DUDEOPTS = -patmega328p -carduino -b57600 -D
COM = /dev/ttyS3

flash-%: %
	avrdude -C${DUDECONF} ${DUDEOPTS} -P${COM} -Uflash:w:${SRC}/$</out.hex:i


.PHONY: clean

clean:
	rm ${BLINK_DIR}/*.o
	rm ${BLINK_DIR}/*.elf
	rm ${BLINK_DIR}/*.hex

	rm ${ENTRY_DIR}/*.o
	rm ${ENTRY_DIR}/*.elf
	rm ${ENTRY_DIR}/*.hex