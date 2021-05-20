; Global Descriptor table
; define the characteristics of the various memory areas used during program execution, 
; including the base address, the size, and access privileges like executability and 
; writability.

; 1. null descriptor
; 2. code segment
; 3. data segment

gdt_nullDesc:
    dd 0
    dd 0
gdt_codeDesc:
    dw 0xFFFF       ; limit
    dw 0x0000       ; Base (low)
    db 0x00         ; Base (medium)
    db 10011010b    ; Flags
    db 11001111b    ; Flags + upper limit
    db 0x00         ; Base (high)


gdt_dataDesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
        dw gdt_end - gdt_nullDesc - 1   ; length of the gdt
        dq gdt_nullDesc                 ; dq for 32 bit

codeseg equ gdt_codeDesc - gdt_nullDesc ; length of code segment
dataseg equ gdt_dataDesc - gdt_nullDesc ; length of data segment

[bits 32]
EditGDT:
    mov [gdt_codeDesc + 6], byte 10101111b  ; converting code descriptor for 32bit
    mov [gdt_dataDesc + 6], byte 10101111b  ; converting data descriptor for 32bit
    ret

[bits 16]