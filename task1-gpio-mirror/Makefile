CROSS_COMPILE=../../opre-amp-solution/toolchain/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-

#ARCH = -march=armv8.2-a -mtune=cortex-a53 -marm -mfpu=neon-fp-armv8 -mfloat-abi=hard # RPI 3B+
ARCH = -mfloat-abi=hard -marm -mtune=cortex-a7 -mfpu=neon-vfpv4	  # RPI 2B

TARGET=userspace-gpio
SOURCE=main

$(TARGET): $(SOURCE).c
	$(CROSS_COMPILE)gcc $(ARCH) -o $(TARGET) $(SOURCE).c

clean: 
	rm $(TARGET)