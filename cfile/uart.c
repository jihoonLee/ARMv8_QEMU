#include "uart.h"

void uart_put_char(const char c) {
	while (*((unsigned int *)UART_WAIT) & (1 << 5)) { }
	*((unsigned int *)UART_BASE) = c; 
}


void uart_put_hex64(const long long n) {
	const char *hexdigits = "0123456789ABCDEF";

	uart_put_char('0');
	uart_put_char('x');
	int i;
	for (i = 60; i >= 0; i -= 4) {
		uart_put_char(hexdigits[(n >> i) & 0xf]);
		if (i == 32) {
			uart_put_char(' ');
		}
	}
	uart_put_char('\n');
	
}

void uart_put_hex32(const int n) {
	const char *hexdigits = "0123456789ABCDEF";
	uart_put_char('0');
	uart_put_char('x');
	int i;
	for (i = 28; i >= 0; i -= 4) {
		uart_put_char(hexdigits[(n >> i) & 0xf]);
	}
	uart_put_char('\n');
}

void uart_put_int32(const int n) {
	int value = n;
	char ch[32];
	int i = 0;
	do {
		ch[i++] =  (value%10) + 48;
		value /= 10;
	} while(value !=0);
	
	while( i > 0 ) {
		uart_put_char(ch[--i]);	
	}

	uart_put_char('\n');
}

void uart_put_int64(const long long n) {
	int value = n;
	char ch[32];
	int i = 0;
	do {
		ch[i++] =  (value%10) + 48;
		value /= 10;
	} while(value !=0);
	
	while( i > 0 ) {
		uart_put_char(ch[--i]);	
	}

	uart_put_char('\n');

}

void uart_put_line(const char *s) {
	int i;
	for (i = 0; s[i] != '\0'; i ++) {
		uart_put_char((unsigned char)s[i]);
	}
}


