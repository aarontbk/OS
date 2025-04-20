[BITS 16]
[ORG 0x7C00]

CODE_OFFSET equ 0x8
DATA_OFFSET equ 0x10

KERNEL_LOAD_ADDRESS equ 0x10000      ; physical
KERNEL_START_ADDRESS equ 0x100000    ; where we copy to in PM

start:
    cli
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00

mov ax, 0x1000 ; segment = 0x1000
mov es, ax

; Load kernel (8 sectors from disk)
mov ah, 0x02
mov al, 8 ; sectors
mov ch, 0
mov cl, 2 ; sector 2 onward
mov dh, 0
mov dl, 0x80 ; hdd

xor bx, bx ; offset = 0
int 0x13
jc load_error

; Enable PM
lgdt [gdt_descriptor]
mov eax, cr0
or eax, 1
mov cr0, eax
jmp CODE_OFFSET:PModeMain

; GDT
gdt_start:
gdt_null:      dq 0

gdt_code:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_stack:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010110b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start

[BITS 32]
PModeMain:
    mov ax, CODE_OFFSET
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ax, DATA_OFFSET
    mov ss, ax
    mov ebp, 0xAC00
    mov esp, ebp

    ; Enable A20 (optional if already done)
    in al, 0x92
    or al, 2
    out 0x92, al

    ; Copy kernel from 0x10000 → 0x100000
    mov esi, KERNEL_LOAD_ADDRESS
    mov edi, KERNEL_START_ADDRESS
    mov ecx, 512
    cld
    rep movsd

    jmp CODE_OFFSET:KERNEL_START_ADDRESS

load_error:
    jmp $

times 510 - ($ - $$) db 0
dw 0xAA55
