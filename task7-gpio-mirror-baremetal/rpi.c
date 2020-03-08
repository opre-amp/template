#define RPI2B
//#define RPI3BPLUS

#define IOBASE   0x3f000000
#define GPIO     0x200000

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

volatile void sleep(int seconds)
{
    for(int i = 0; i<seconds*10000000; ++i) asm volatile("nop");
}

int main()
{
    volatile unsigned int *set = (unsigned int *)(IOBASE + GPIO + SET);
    volatile unsigned int *clr = (unsigned int *)(IOBASE + GPIO + CLEAR);
    volatile unsigned int *cfg = (unsigned int *)(IOBASE + GPIO + CONFIG);

    *cfg |= (1 << CFG_BIT); // set as output (only affects that bit)

    for(int i = 0; i < 10; ++i) // flash the led 10 times
    {
        *set |= (1 << DATA_BIT);    // LED ON
        sleep(1);
        *clr |= (1 << DATA_BIT);    // LED OFF
        sleep(1);
    }    

    return 0;

}