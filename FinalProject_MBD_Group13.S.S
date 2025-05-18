#define __SFR_OFFSET 0x00
#include <avr/io.h>

; Constants for pins
.equ HENING_LED, 3        ; Digital pin 3 for HENING LED
.equ KONDUSIF_LED, 4      ; Digital pin 4 for KONDUSIF LED
.equ GADUH_LED, 5         ; Digital pin 5 for GADUH LED

; Constants for thresholds
.equ HENING_THRESHOLD, 30     ; 0-30 dB is HENING
.equ GADUH_THRESHOLD, 80      ; >80 dB is GADUH

.section .text
.global main

; Main entry point
main:
    ; Initialize stack pointer
    ldi r16, hi8(RAMEND)
    out SPH, r16
    ldi r16, lo8(RAMEND)
    out SPL, r16
    
    ; Initialize UART (virtual terminal)
    rcall uart_init
    
    ; Initialize GPIO pins
    rcall gpio_init
    
    ; Initialize ADC
    rcall adc_init
    
    ; Send startup message
    rcall send_startup_msg
    
    ; Main program loop
main_loop:
    ; Read potentiometer value
    rcall read_adc
    
    ; Save the dB value for later
    mov r20, r16
    
    ; Determine noise category
    rcall process_level
    
    ; Save the category
    mov r21, r17
    
    ; Update LEDs
    rcall update_leds
    
    ; Send to terminal using the saved values
    mov r16, r20
    mov r17, r21
    rcall send_to_terminal
    
    ; Short delay
    ldi r24, 200
    ldi r25, 0
    rcall delay_ms
    
    rjmp main_loop

; Send startup message
send_startup_msg:
    ldi r16, 'S'
    rcall uart_tx_char
    ldi r16, 'o'
    rcall uart_tx_char
    ldi r16, 'u'
    rcall uart_tx_char
    ldi r16, 'n'
    rcall uart_tx_char
    ldi r16, 'd'
    rcall uart_tx_char
    ldi r16, ' '
    rcall uart_tx_char
    ldi r16, 'D'
    rcall uart_tx_char
    ldi r16, 'e'
    rcall uart_tx_char
    ldi r16, 't'
    rcall uart_tx_char
    ldi r16, 'e'
    rcall uart_tx_char
    ldi r16, 'c'
    rcall uart_tx_char
    ldi r16, 't'
    rcall uart_tx_char
    ldi r16, 'o'
    rcall uart_tx_char
    ldi r16, 'r'
    rcall uart_tx_char
    ldi r16, ' '
    rcall uart_tx_char
    ldi r16, 'R'
    rcall uart_tx_char
    ldi r16, 'e'
    rcall uart_tx_char
    ldi r16, 'a'
    rcall uart_tx_char
    ldi r16, 'd'
    rcall uart_tx_char
    ldi r16, 'y'
    rcall uart_tx_char
    
    ; Newline
    ldi r16, '\r'
    rcall uart_tx_char
    ldi r16, '\n'
    rcall uart_tx_char
    ret

; Initialize UART for serial communication
uart_init:
    ; Set baud rate to 9600 baud
    ldi r16, 103            ; 16MHz / (16 * 9600) - 1
    sts UBRR0L, r16
    ldi r16, 0
    sts UBRR0H, r16
    
    ; Enable transmitter
    ldi r16, (1<<TXEN0)
    sts UCSR0B, r16
    
    ; Set frame format: 8 data bits, 1 stop bit
    ldi r16, (1<<UCSZ01) | (1<<UCSZ00)
    sts UCSR0C, r16
    ret

; Initialize GPIO for LEDs
gpio_init:
    ; Set LED pins as outputs
    sbi DDRD, HENING_LED
    sbi DDRD, KONDUSIF_LED
    sbi DDRD, GADUH_LED
    
    ; All LEDs off initially
    cbi PORTD, HENING_LED
    cbi PORTD, KONDUSIF_LED
    cbi PORTD, GADUH_LED
    ret

; Initialize ADC for potentiometer reading
adc_init:
    ; Select ADC0 (Analog pin 0) with AVCC reference
    ldi r16, (1<<REFS0)
    sts ADMUX, r16
    
    ; Enable ADC, set prescaler to 128 (16MHz/128 = 125kHz)
    ldi r16, (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1) | (1<<ADPS0)
    sts ADCSRA, r16
    ret