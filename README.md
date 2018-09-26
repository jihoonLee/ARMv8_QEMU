QEMU ARMv8 MemoryMap

###### #define PHY_START       0x40000000
###### #define PHYSTOP         (0x08000000 + PHY_START)
###### #define UART0           0x09000000
###### #define UART_CLK        24000000    // Clock rate for UART

###### #define TIMER0          0x1c110000
###### #define TIMER1          0x1c120000
###### #define CLK_HZ          1000000     // the clock is 1MHZ