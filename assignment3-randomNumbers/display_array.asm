extern printf
global printArray

segment .data
header_message db "IEEE754                  Scientific Decimal", 0x0a, 0
index_information db "0x%016lx       %-18.13g", 0x0a, 0

segment .bss
; empty

segment .text
printArray:
    ; Backup registers
    push rbp
    mov  rbp,rsp
    push rdi                                                    ;Backup rdi
    push rsi                                                    ;Backup rsi
    push rdx                                                    ;Backup rdx
    push rcx                                                    ;Backup rcx
    push r8                                                     ;Backup r8
    push r9                                                     ;Backup r9
    push r10                                                    ;Backup r10
    push r11                                                    ;Backup r11
    push r12                                                    ;Backup r12
    push r13                                                    ;Backup r13
    push r14                                                    ;Backup r14
    push r15                                                    ;Backup r15
    push rbx                                                    ;Backup rbx
    pushf                                                       ;Backup rflags

    mov r13, rdi
    mov r14, rsi
    mov r15, 0

    ; print table header
    push qword 0
    mov rax, 0
    mov rdi, header_message
    call printf
    pop rax

print_information:
    ; ensure still within range of size filled array
    cmp r15, r14
    je done

    ; print information
    push qword 0
    mov rax, 1
    mov rdi, index_information
    mov rsi, [r13+r15*8]
    movsd xmm0, [r13+r15*8]
    call printf
    pop rax

    inc r15
    jmp print_information

done:
    ; restore registers
    popf                                                        ;Restore rflags
    pop rbx                                                     ;Restore rbx
    pop r15                                                     ;Restore r15
    pop r14                                                     ;Restore r14
    pop r13                                                     ;Restore r13
    pop r12                                                     ;Restore r12
    pop r11                                                     ;Restore r11
    pop r10                                                     ;Restore r10
    pop r9                                                      ;Restore r9
    pop r8                                                      ;Restore r8
    pop rcx                                                     ;Restore rcx
    pop rdx                                                     ;Restore rdx
    pop rsi                                                     ;Restore rsi
    pop rdi                                                     ;Restore rdi
    pop rbp                                                     ;Restore rbp
ret