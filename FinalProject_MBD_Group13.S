; Read ADC value from potentiometer
read_adc:
    ; Start conversion
    lds r16, ADCSRA
    ori r16, (1<<ADSC)
    sts ADCSRA, r16
    
    ; Wait for conversion to complete
adc_wait:
    lds r16, ADCSRA
    sbrc r16, ADSC
    rjmp adc_wait
    
    ; Read ADC result
    lds r16, ADCL    ; Must read ADCL first
    lds r17, ADCH
    
    ; Convert 10-bit ADC (0-1023) to dB (0-100)
    ; We'll use a simple formula: dB = ADC / 10
    ; Combine ADCL and ADCH into a 10-bit value
    mov r24, r16     ; Low byte in r24
    mov r25, r17     ; High byte in r25
    
    ; Divide by 10 by repeated subtraction
    ldi r21, 10      ; Divisor
    clr r16          ; Result counter
div10_loop:
    cp r24, r21      ; Compare low byte with 10
    cpc r25, r1      ; Compare high byte with 0
    brlo div10_done  ; If less than 10, done
    
    ; Subtract 10
    subi r24, 10
    sbci r25, 0
    
    ; Increment result
    inc r16
    rjmp div10_loop
    
div10_done:
    ret              ; Result in r16 (0-100)

; Process sound level
process_level:
    ; r16 = dB level (0-100)
    ; Returns r17 = category (0=HENING, 1=KONDUSIF, 2=GADUH)
    
    cpi r16, GADUH_THRESHOLD
    brsh is_gaduh
    
    cpi r16, HENING_THRESHOLD
    brsh is_kondusif
    
    ldi r17, 0    ; HENING (0-30 dB)
    ret
    
is_kondusif:
    ldi r17, 1    ; KONDUSIF (31-80 dB)
    ret
    
is_gaduh:
    ldi r17, 2    ; GADUH (>80 dB)
    ret

; Update LEDs based on category
update_leds:
    ; r17 = category (0=HENING, 1=KONDUSIF, 2=GADUH)
    
    ; Turn off all LEDs first
    cbi PORTD, HENING_LED
    cbi PORTD, KONDUSIF_LED
    cbi PORTD, GADUH_LED
    
    ; Turn on appropriate LED
    cpi r17, 0
    brne not_hening_led
    sbi PORTD, HENING_LED
    ret
    
not_hening_led:
    cpi r17, 1
    brne not_kondusif_led
    sbi PORTD, KONDUSIF_LED
    ret
    
not_kondusif_led:
    sbi PORTD, GADUH_LED
    ret

; Improved uart_tx with better waiting logic
uart_tx_char:
    ; Input: r16 = character to send
    push r17
uart_tx_wait:
    lds r17, UCSR0A
    sbrs r17, UDRE0
    rjmp uart_tx_wait
    sts UDR0, r16
    pop r17
    ret

; Send data to virtual terminal - FIXED
send_to_terminal:
    ; r16 = dB level, r17 = category
    push r16
    push r17
    
    ; Print dB value - REVISED
    rcall print_decimal
    
    ; Print "dB " text
    ldi r16, 'd'
    rcall uart_tx_char
    ldi r16, 'B'
    rcall uart_tx_char
    ldi r16, ' '
    rcall uart_tx_char
    
    ; Print category based on r17
    pop r17
    cpi r17, 0
    brne not_hening_print
    
    ; Print "HENING"
    rcall print_hening
    rjmp finish_print
    
not_hening_print:
    cpi r17, 1
    brne not_kondusif_print
    
    ; Print "KONDUSIF"
    rcall print_kondusif
    rjmp finish_print
    
not_kondusif_print:
    ; Print "GADUH"
    rcall print_gaduh
    