[BITS 16]
[ORG 0x7C00]

start:
    cli
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov si, msg



print:
    lodsb 
    or al, al ; set ZF if AL == 0 (null terminator)
    jz done
    mov ah, 0x0E
    int 0x10 ; BIOS interrupt to print character in AL
    jmp print ; loop to print next character

done:
    cli
    hlt ; stop CPU execution


msg: dw 'Hello, World!', 0

times 510 - ($-$$) db 0
dw 0xAA55