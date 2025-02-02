PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld
OBJCOPY = ${PREFIX}objcopy
OBJDUMP = ${PREFIX}objdump

SRC = src/kernel
INCLUDE = inc

KERNEL_DIR = ${SRC}/main


SOURCES := $(wildcard ${SRC}/*/*.c)
ASOBJECTS := $(patsubst %.s,%.o,$(wildcard ${SRC}/*/*.s))


CCFLAGS = -mmcu=atmega328p -Os -g -mrelax -e _start -I$(INCLUDE) # -fno-stack-protector

${ENTRY_DIR}/entry.o: ${ENTRY_DIR}/entry.s
	${AS} -g -mmcu=atmega328p -I${INCLUDE} -o ${ENTRY_DIR}/entry.o ${ENTRY_DIR}/entry.s -I$(INCLUDE)

%.o: %.s
	${AS} -g -mmcu=atmega328p -I${INCLUDE} -o $@ $<


kernel: ${SOURCES} ${ASOBJECTS}
	${CC} ${CCFLAGS} -o ${KERNEL_DIR}/out.elf  ${SOURCES} ${ASOBJECTS}
	${OBJCOPY} -R .eeprom -O ihex ${KERNEL_DIR}/out.elf ${KERNEL_DIR}/out.hex
	$(OBJDUMP) -S ${KERNEL_DIR}/out.elf > ${KERNEL_DIR}/out.lst
	$(OBJDUMP) -t ${KERNEL_DIR}/out.elf | sed '1,/SYMBOL TABLE/d; s/ .* / /; /^$$/d' > ${KERNEL_DIR}/out.sym

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
	rm ${SRC}/*/*.o
	rm ${KERNEL_DIR}/*.elf
	rm ${KERNEL_DIR}/*.hex
	rm ${KERNEL_DIR}/*.lst
	rm ${KERNEL_DIR}/*.sym

