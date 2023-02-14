global append

segment .data
; empty

segment .bss
; empty

segment .text
append:
    ;backup register
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

    ; copy address of array first indexes to GPR
    mov r10, rdi ; address of first index for array A
    mov r11, rsi ; address of first index for array B
    mov r12, rdx ; address of first index of a_append_b

    ; copy capacity of small array and appended array to GPR
    mov r13, rcx ; capacity of array A/B
    mov r14, 0 ; starting index of appended array
    mov r15, 0 ; starting index of array A/B

append_from_array_a:
    ; mov [r12 + r14*8], [r10 + r15*8]
    movsd xmm10, [r10 + r15*8]
    movsd [r12 + r14*8], xmm10
    inc r14
    inc r15

    ; check if still within bounds of array A
    cmp r15, r13
    jb append_from_array_a
    
    mov r15, 0 ;reset counter
    je append_from_array_b

append_from_array_b:
    ; mov [r12 + r14*8], [r11 + r15*8]
    movsd xmm10, [r11 + r15*8]
    movsd [r12 + r14*8], xmm10
    inc r14
    inc r15

    cmp r15, r13
    jb append_from_array_b
    je done

done:
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
