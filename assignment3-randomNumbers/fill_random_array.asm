extern isNan
global fillRandomArray

segment .data
;empty

segment .bss
;empty

segment .text
fillRandomArray:
    ; backup register (courtesy)
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

    mov r13, rdi    ; address of array first index
    mov r14, rsi    ; size of array
    mov r15, 0      ; initialize counter

generate:
    cmp r15, r14
    je done
    rdrand r12

    ; delegate task to isNaN.asm to validate generated value for NaN
    mov rax, 0
    mov rdi, r12
    call isNan

    ; compare values and re-generate number is isNan
    cmp rax, 1  
    je generate

    ; else fill array at given index
    mov [r13 + r15*8], r12
    inc r15
    jmp generate

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