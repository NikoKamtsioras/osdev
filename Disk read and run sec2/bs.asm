[org 0x7c00]

    mov bx, HELLO
    call print
    call print_nl

    mov bp, 0x8000 ; set the stack safely away from us
    mov sp, bp


    [org 0x7c00]
    mov bp, 0x8000         ; set up stack safely away from bootloader
    mov sp, bp

    mov bx, 0x9000         ; target memory address for loaded sectors
    mov dh, 1              ; read 2 sectors (sector 2 and 3)
    call disk_load         ; read sectors to 0x9000

    jmp 0x0000:0x9000      ; jump to loaded code in sector 2

    HELLO:
    	db 'Hello From the Boot Sector!', 0

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; Magic number
times 510 - ($-$$) db 0
dw 0xaa55
