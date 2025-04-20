[BITS 16]
[ORG 0x7C00]

CODE_OFFSET equ 0x8
DATA_OFFSET equ 0x10

start:
    cli
    mov ax, 0x00
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

load_PM:
    cli
    lgdt[gdt_descriptor]
    mov eax, cr0
    or al, 1
    mov cr0, eax

    jmp CODE_OFFSET:PModeMain

; GDT implementation
gdt_start:
    gdt_null:
        dw 0, 0
        db 0, 0, 0, 0, 0, 0, 0, 0

    gdt_code:
        dw 0xFFFF ; limit
        dw 0x0000 ; base low
        db 0x00 ; base middle
        db 10011010b
        db 11001111b ; granularity
        db 0x00 ; base high

    gdt_data:
        dw 0xFFFF ; limit
        dw 0x0000 ; base low
        db 0x00 ; base middle
        db 10010010b
        db 11001111b ; granularity
        db 0x00 ; base high

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of GDT - 1
    dd gdt_start ; address of GDT

[BITS 32]
PModeMain:
    mov ax, DATA_OFFSET
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    mov ebp, 0xAC00
    mov esp, ebp

    in al, 0x92
    or al, 2
    out 0x92, al

    jmp $


times 510 - ($-$$) db 0
dw 0xAA55