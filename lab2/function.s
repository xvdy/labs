[org 0x7c00]
; The main routine makes sure the parameters are ready and then calls the function
mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

; that's it! we can hang now
jmp $

; data
HELLO:
    db 'Hello, World', 0

GOODBYE:
    db 'Goodbye', 0

; print 打印字符串
; bx 存放要打印的字符串地址
print:
    pusha

; keep this in mind:
; while (string[i] != 0) { print string[i]; i++ }

; the comparison for string end (null byte)
start:
    mov al, [bx] ; 'bx' is the base address for the string
    cmp al, 0 
    je done

    ; the part where we print with the BIOS help
    mov ah, 0x0e
    int 0x10 ; 'al' already contains the char

    ; increment pointer and do next loop
    add bx, 1
    jmp start

done:
    popa
    ret


; 打印新行
print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10

    popa
    ret

; padding and magic number
times 510-($-$$) db 0
dw 0xaa55
