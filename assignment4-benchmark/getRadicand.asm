extern printf
extern scanf
extern atof
global getRadicand

section .data
    string_format db "%s", 0
    get_radicand_prompt db  0x0a, "Please enter a floating radicand for square root bench marking: ", 0
    invalid_radicand_feedback db "Invalid input detected. Please enter a valid floating point", 0x0a, 0

section .bss
    radicand_input resb 100


section .text
getRadicand:
    ; backup registers
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
    pushf                                                        ;Backup rflags

get_radicand_input:
    push qword 0
    mov rax, 0
    mov rdi, get_radicand_prompt
    call printf
    pop rax

    mov rax, 0
    mov rdi, string_format
    mov rsi, radicand_input
    call scanf

    ; attempt to convert to float
    mov rax, 0
    mov rdi, radicand_input
    call atof
    movsd xmm15, xmm0

    ; compare value returned by atof and jump accordingly
    push qword 0
    movsd xmm14, [rsp]
    pop rax

    ucomisd xmm15, xmm14
    jbe invalid_input
    jg done

invalid_input:
    mov rax, 0 
    mov rdi, invalid_radicand_feedback
    call printf

    jmp get_radicand_input

done:
    movsd xmm0, xmm15
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