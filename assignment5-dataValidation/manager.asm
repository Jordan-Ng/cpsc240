extern printf
extern scanf
extern atoi
extern atof
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
    string_format db "%s", 0

section .bss
    name_input resb INPUT_LEN
    angle_input resq MAX
    iteration_input resq MAX

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

    ; prompt user for name input + store to name array
    mov rax, 0 
    mov rdi, name_prompt
    call printf

    mov rax, 0
    mov rdi, string_format
    mov rsi, name_input
    call scanf

    ; prompt user for angle input + store to angle array
    mov rax, 0
    mov rdi, greeting_message
    mov rsi, name_input
    call printf

angle_input_validation:
    mov rdi, string_format
    mov rsi, angle_input
    call scanf

    ; =========== attempt to conver to float =======
    mov rax, 0
    mov rdi, angle_input
    call atof
    movsd xmm15, xmm0

    push qword 0
    movsd xmm14, [rsp]
    pop rax

    ucomisd xmm15, xmm14
    jbe invalid_angle_input
    jg number_of_iterations

invalid_angle_input:
    mov rax, 0
    mov rdi, invalid_input_feedback
    call printf
    jmp angle_input_validation

; prompt user for no. of iteration
number of iterations:
    mov rax, 0
    mov rdi, no_of_terms_message
    call printf

    mov rax, 0
    mov rdi, string_format
    mov rsi, iteration_input
    call scanf

; number_of_iterations_validation:
    ; ===== attempt to convert input to int ======
    mov rax, 0
    mov rdi, iteration_input
    call atoi
    mov r15, rax        ; Number of iterations stored in r15

    cmp r15, 0
    js invalid_iteration_input
    je invalid_iteration_input
    jg confirmation

invalid_iteration_input:
    mov rax, 0
    mov rdi, invalid_input_feedback
    call printf
    jmp number_of_iterations


confirmation:
    mov rax, 0
    mov rdi, confirmation_message
    call printf


completion:
    mov rax, 0
    mov rdi, completion_message
    call printf

    mov rax, 0
    mov rdi, sin_function_message
    call printf

    mov rax, 0
    mov rdi, sin_complete_message
    call printf
    ; restore registers
    mov rax, 0

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