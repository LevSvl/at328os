PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld


SRC = ./src
INCLUDE = ./inc


BLINK = ${SRC}/blink

.PHONY: clean

CCFLAGS = -Wall -g -mmcu=atmega328p -nostdlib

blink: ${BLINK}/main.c
	${CC} ${CCFLAGS} ${BLINK}/main.c -o ${BLINK}/out.elf -I${INCLUDE}



clean:
	rm  