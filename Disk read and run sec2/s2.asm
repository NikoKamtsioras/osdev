[org 0x9000]

start:
    mov si, msg

.loop:
    lodsb
    test al, al
    jz .done

    mov ah, 0x0E
    int 0x10
    jmp .loop

.done:
    jmp $

msg db "Hello from sector 2!", 0

