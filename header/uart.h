#ifndef __UART_H__
#define __UART_H__
#define UART_BASE 0x09000000
#define UART_WAIT 0x09000018
void uart_put_char(const char c);
void uart_put_hex64(const long long n);
void uart_put_hex32(const int n);
void uart_put_int64(const long long n);
void uart_put_int32(const int n);
void uart_put_line(const char *s); 

#endif

