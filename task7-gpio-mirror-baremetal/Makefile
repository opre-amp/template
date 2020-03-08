PREFIX = ../../opre-amp-solution/toolchain/gcc-arm-9.2-2019.12-x86_64-arm-none-eabi/bin/arm-none-eabi-

ARCH = -march=armv8.2-a -mtune=cortex-a53 -marm -mfpu=neon-fp-armv8 -mfloat-abi=hard # RPI 3B+
#ARCH = -mfloat-abi=hard -marm -mcpu=cortex-a7 -mfpu=neon-vfpv4	  # RPI 2B

CFLAGS = -Wall -Werror -O2  -ffreestanding -fno-exceptions -nostdinc -nostdlib -nostartfiles
CFLAGS += $(ARCH)

LDFLAGS = -Ttext 0x20000000 -nostartfiles -Trpi.x

TARGET = metal

SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

CC	= $(PREFIX)gcc
LD	= $(PREFIX)ld


all: $(TARGET).img

%.o: %.s
	$(CC) $(ARCH) -c -o $@ $<

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<


$(TARGET).img: start.o $(OBJS) rpi.x
	$(LD) $(LDFLAGS) -o $(TARGET).elf  start.o $(OBJS)
	$(PREFIX)objcopy $(TARGET).elf -O binary $(TARGET).img
	$(ECHO) $(PREFIX)nm metal.elf

clean :
	-rm *.o
	-rm *.elf
	-rm *.img
