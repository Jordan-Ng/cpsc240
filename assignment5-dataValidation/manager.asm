extern printf
extern scanf
global manager

section .data
    INPUT_LEN equ 256
    MAX equ 10
    name_prompt db "Please enter your name: ", 0
    greeting_message db "It is nice to meet you %s. Please enter an angle number in degrees: ",0
    invalid_input_feedack db "Invalid. Please try again: ",0
    no_of_terms_message db "Thank you. Please enter the number of terms in a Taylor series to be computed: ", 0
    confirmation_message db "Thank you. The Taylor series will be used to compute the sine of your angle", 0x0a, 0
    completion_message db "The computation completed in %d tics and the computed value is %1.9lf", 0x0a, 0
    sin_function_message db "Next the sine of %1.9lf will be computed by the function sin in the library <math.h>", 0x0a, 0
    sin_complete_message db "The computation completed in %d tics and gave the value %1.9lf" , 0x0a, 0

section .bss
    name resb INPUT_LEN
    angle resb MAX

section .text
manager:
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
    pushf                                                       ;Backup rflags

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