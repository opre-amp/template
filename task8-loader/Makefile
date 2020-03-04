obj-m += loader.o
all:
	make ARCH=arm CROSS_COMPILE=$(CROSS_LINUX) -C ../linux M=$(PWD) modules
clean:
	make ARCH=arm CROSS_COMPILE=$(CROSS_LINUX) -C ../linux M=$(PWD) clean