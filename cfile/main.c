#include "uart.h"

void main(void) {
	uart_put_line("Hello\n");
	uart_put_line("1234\n");
	uart_put_int32(1234L);
	uart_put_hex32(15);
	uart_put_hex64(15);
	while (1);
}
