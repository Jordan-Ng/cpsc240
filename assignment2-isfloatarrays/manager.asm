global manager
extern printf
extern callf
extern inputArray
extern displayArray

segment .data
welcome_message db "This program will manage your arrays of 64-bit floats", 0x0a, 0
prompt_a db "For array A enter a sequence of 64-bit floats separated by white space", 0x0a, 0
prompt_line2 db "After the last input press enter followed by Control+D", 0x0a, 0
display_message db "These values were added to the array", 0x0a, 0
max equ 3

segment .bss
mydata resq max

segment .text
manager:
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

    ; print prompt a message and line 2
    mov rax, 0
    mov rdi, prompt_a
    call printf

    mov rax, 0
    mov rdi, prompt_line2
    call printf

    ; delegate task to input_array.asm to scan for input
    push qword 0
    mov rax, 0
    mov rdi, mydata
    mov rsi, max
    call inputArray
    pop rax

    ; print display message
    mov rax, 0
    mov rdi, display_message
    push qword 0
    call printf
    pop rax

    ; delegata task to display_array.asm to show inputs
    mov rax, 0
    mov rdi, mydata
    mov rsi, max
    push qword 0
    call displayArray
    pop rax

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