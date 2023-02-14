global magnitude
extern printf

segment .data
    test_message db "ok up till here", 0x0a, 0
    int_format db "%i", 0
;empty

segment .bss
;empty

segment .text
magnitude:
    ; backup registers
    push rbp
    push rbx
    push rcx
    push rdx
    push rsi
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push r14
    push r15
    pushf

    ; store arguments from caller function
    mov r13, rdi
    mov r14, rsi

    mov r15, 0

    push qword 0
    movsd xmm10, [rsp]
    pop rax


    ; loop through array and add to xmm10 register
loop:
    ; mathematical operations to add squared value of current index to xmm10
    push qword 0
    movsd xmm11, [r13 + r15*8]
    mulsd xmm11, xmm11
    addsd xmm10, xmm11
    inc r15
    pop rax

    ; compare next index and jump as required
    cmp r15, r14
    jb loop
    je done
    
done:
    ; root total and store in xmm0 register
    sqrtsd xmm0, xmm10

    ; restore registers
    popf
    pop r15
    pop r14
    pop r13
    pop r12
    pop r11
    pop r10 
    pop r9
    pop r8
    pop rsi 
    pop rdx
    pop rcx
    pop rbx
    pop rbp
ret