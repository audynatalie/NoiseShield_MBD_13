finish_print:
    ; Print newline
    ldi r16, '\r'
    rcall uart_tx_char
    ldi r16, '\n'
    rcall uart_tx_char
    
    pop r16
    ret

; Print "HENING" text
print_hening:
    ldi r16, 'H'
    rcall uart_tx_char
    ldi r16, 'E'
    rcall uart_tx_char
    ldi r16, 'N'
    rcall uart_tx_char
    ldi r16, 'I'
    rcall uart_tx_char
    ldi r16, 'N'
    rcall uart_tx_char
    ldi r16, 'G'
    rcall uart_tx_char
    ret

; Print "KONDUSIF" text
print_kondusif:
    ldi r16, 'K'
    rcall uart_tx_char
    ldi r16, 'O'
    rcall uart_tx_char
    ldi r16, 'N'
    rcall uart_tx_char
    ldi r16, 'D'
    rcall uart_tx_char
    ldi r16, 'U'
    rcall uart_tx_char
    ldi r16, 'S'
    rcall uart_tx_char
    ldi r16, 'I'
    rcall uart_tx_char
    ldi r16, 'F'
    rcall uart_tx_char
    ret

; Print "GADUH" text
print_gaduh:
    ldi r16, 'G'
    rcall uart_tx_char
    ldi r16, 'A'
    rcall uart_tx_char
    ldi r16, 'D'
    rcall uart_tx_char
    ldi r16, 'U'
    rcall uart_tx_char
    ldi r16, 'H'
    rcall uart_tx_char
    ret

; Print decimal value (0-99) - COMPLETELY REVISED
print_decimal:
    push r16
    push r17
    push r18
    push r19
    
    ; Save original value
    mov r18, r16
    
    ; Handle numbers >= 10
    cpi r18, 10
    brlo print_single_digit
    
    ; Divide by 10
    ldi r19, 10
    clr r17            ; Initialize quotient
divide_loop:
    cp r18, r19        ; Compare with 10
    brlo divide_end    ; If < 10, done
    sub r18, r19       ; Subtract 10
    inc r17            ; Increment quotient
    rjmp divide_loop
divide_end:
    ; r17 = tens digit, r18 = ones digit
    
    ; Print tens digit
    mov r16, r17
    ldi r19, '0'
    add r16, r19
    rcall uart_tx_char
    
    ; Print ones digit
    mov r16, r18
    ldi r19, '0'
    add r16, r19
    rcall uart_tx_char
    
    pop r19
    pop r18
    pop r17
    pop r16
    ret
    
print_single_digit:
    ; For single digit, print leading zero
    ldi r16, '0'
    rcall uart_tx_char
    
    ; Print digit
    mov r16, r18
    ldi r19, '0'
    add r16, r19
    rcall uart_tx_char
    
    pop r19
    pop r18
    pop r17
    pop r16
    ret

; Delay function (milliseconds)
delay_ms:
    ; Input: r24:r25 = milliseconds
    push r24
    push r25
    push r18
    push r19
    
delay_outer_loop:
    ldi r18, 200        ; Adjust for 16MHz
delay_inner_loop:
    ldi r19, 80
delay_cycle:
    dec r19
    brne delay_cycle
    dec r18
    brne delay_inner_loop
    
    sbiw r24, 1
    brne delay_outer_loop
    
    pop r19
    pop r18
    pop r25
    pop r24
    ret