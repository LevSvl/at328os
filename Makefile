PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld
OBJCOPY = ${PREFIX}objcopy
OBJDUMP = ${PREFIX}objdump

SRC = ./src
INCLUDE = ./inc


BLINK_DIR = ${SRC}/blink

CCFLAGS = -mmcu=atmega328p -Wall -Os 

blink: ${BLINK_DIR}/main.c
	${CC} ${CCFLAGS} -o ${BLINK_DIR}/out.elf ${BLINK_DIR}/main.c -I${INCLUDE}
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