global inputArray
extern scanf
extern printf

segment .data
    float_form db "%lf", 0 
    int_form db "%i", 0

segment .text
inputArray:
    ;backup registers
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


    ;store arguments from caller function
    mov r13, rdi
    mov r14, rsi

    ;initilaize index 0
    mov r15, 0

scan:
    ; scan user input
    push qword 0
    mov rax, 0
    mov rdi, float_form
    mov rsi, rsp
    call scanf

    ; jump to end_of_transmission label if user signals end of transmission (ctrl+D)
    cdqe
    cmp rax, -1
    je end_of_transmission

    ; else copy input value to corresponding index and increment index
    pop rbx
    mov [r13 + r15*8], rbx
    inc r15

    cmp r15, r14
    jb scan
    je done

end_of_transmission:
    pop rbx

done:
    ;restore registers
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