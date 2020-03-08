#define RPI2B
// #define RPI3BPLUS

#ifdef RPI2B

#define CONFIG   0x00010
#define CFG_BIT  21
#define SET      0x00020
#define CLEAR    0x0002C
#define DATA_BIT 15

#elif defined RPI3BPLUS

#define CONFIG   0x00008
#define CFG_BIT  27
#define SET      0x0001C
#define CLEAR    0x00028
#define DATA_BIT 29

#endif

#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <signal.h>

// end signal flag
char flag = 1;

//handling Ctrl+C (SIGINT)
void intHandler(int _i) {
    flag = 0;
}

int main()
{
    signal(SIGINT, intHandler); // registering the SIGINT handler
    
    int fd = open("/dev/gpiomem", O_RDWR | O_SYNC); // opening the device file  
    void* base = mmap(NULL, CLEAR+0x4, PROT_WRITE, MAP_SHARED, fd, 0); // mapping the memory into our virtual space

    volatile unsigned int *cfg = base + CONFIG;
    volatile unsigned int *set = base + SET;
    volatile unsigned int *clr = base + CLEAR;

    *cfg |= (1 << CFG_BIT); // set as output (only affects that bit)
    while(flag)
    {
        *set |= (1 << DATA_BIT);    // LED ON
        sleep(1);
        *clr |= (1 << DATA_BIT);    // LED OFF
        sleep(1);
    }
    
    *cfg &= ~(1 << CFG_BIT); // set as input again
    
    munmap(base, CLEAR+0x4); // Unmapping
    close(fd);               // Closing the file

    printf("Terminating.\n");
}