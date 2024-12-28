PREFIX = avr-

CC = ${PREFIX}gcc
AS = ${PREFIX}as
LD = ${PREFIX}ld
OBJCOPY = ${PREFIX}objcopy
OBJDUMP = ${PREFIX}objdump

SRC = ./src
INCLUDE = ./inc


BLINK = ${SRC}/blink

.PHONY: clean

CCFLAGS = -Wall -g -mmcu=atmega328p -nostdlib -ffreestanding -flto -fuse-linker-plugin -Wl,--gc-sections


EEPROM_FLAGS += -v
EEPROM_FLAGS += -O ihex
EEPROM_FLAGS += -j .eeprom --set-section-flags=.eeprom=alloc,load
EEPROM_FLAGS += --no-change-warnings
EEPROM_FLAGS += --change-section-lma .eeprom=0

OTHER_FLAGS += -O ihex
OTHER_FLAGS += -R .eeprom


blink: ${BLINK}/main.c
	${CC} ${CCFLAGS} ${BLINK}/main.c -o ${BLINK}/out.elf -I${INCLUDE}
	${OBJCOPY} ${EEPROM_FLAGS} ${BLINK}/out.elf ${BLINK}/out.eep
	${OBJCOPY} ${OTHER_FLAGS} ${BLINK}/out.elf ${BLINK}/out.hex



DUDE = avrdude
DUDECONF = avrdude.conf
DUDEOPTS = -patmega328p -carduino -b57600 -D
COM = /dev/ttyS3

flash-%: %
	avrdude -C${DUDECONF} ${DUDEOPTS} -P${COM} -Uflash:w:${SRC}/$</out.hex:i


clean:
	rm  