metal.img: metal.elf
	${CROSS_BARE}objcopy metal.elf -O binary metal.img

metal.elf: rpi.o start.o
	${CROSS_BARE}ld -Ttext 0x20000000 -nostartfiles -Trpi.x  start.o rpi.o -o metal.elf

rpi.o: rpi.c
	${CROSS_BARE}gcc -c rpi.c -o rpi.o

start.o: start.S
	${CROSS_BARE}as start.S -o start.o