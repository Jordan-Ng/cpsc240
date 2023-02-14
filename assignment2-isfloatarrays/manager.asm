global manager
extern printf
extern callf
extern inputArray
extern displayArray
extern magnitude
extern append

segment .data
welcome_message db "This program will manage your arrays of 64-bit floats", 0x0a, 0
prompt_a db "For array A enter a sequence of 64-bit floats separated by white space", 0x0a, 0
prompt_b db "For array B enter a sequence of 64-bit floats separated by white space", 0x0a, 0
prompt_line2 db "After the last input press enter followed by Control+D", 0x0a, 0
magnitude_message_a db "the magnitude of this array A is %1.4lf", 0x0a, 0
magnitude_message_b db "the magnitude of this array B is %1.4lf", 0x0a, 0
magnitude_message_a_append_b db "the magnitude of this array A+B is %1.4lf", 0x0a, 0
display_message db "These values were added to the array", 0x0a, 0
max equ 3
append_max equ 6
int_form db "%i", 0

segment .bss
mydata resq max
myArrayB resq max
a_append_b resq append_max

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

; =============== array 1 ========================
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
    push qword 0
    mov rax, 0
    mov rdi, mydata
    mov rsi, max
    call displayArray
    pop rax

    ; delegate task to magnitude.asm to calculate user inputs
    push qword 0
    mov rax, 0
    mov rdi, mydata
    mov rsi, max
    call magnitude
    pop rax

    ; print output after calculation
    mov rax, 1
    mov rdi, magnitude_message_a
    push qword 0
    call printf
    pop rax

    ; =============== array 2 ========================
    ; print prompt a message and line 2
    mov rax, 0
    mov rdi, prompt_b
    call printf

    mov rax, 0
    mov rdi, prompt_line2
    call printf

    ; delegate task to input_array.asm to scan for input
    push qword 0
    mov rax, 0
    mov rdi, myArrayB
    mov rsi, max
    call inputArray
    pop rax

    ; print display message
    mov rax, 0
    mov rdi, display_message
    push qword 0
    call printf
    pop rax

    ; delegata task to display_array.cpp to show inputs
    push qword 0
    mov rax, 0
    mov rdi, myArrayB
    mov rsi, max
    call displayArray
    pop rax

    ; delegate task to magnitude.asm to calculate user inputs
    push qword 0
    mov rax, 0
    mov rdi, myArrayB
    mov rsi, max
    call magnitude
    pop rax

    ; print output after calculation
    mov rax, 1
    mov rdi, magnitude_message_b
    push qword 0
    call printf
    pop rax

    ; =============== array 1 append array 2 ========================
    ; delegate task to append.asm to append arrays A and B
    push qword 0
    mov rax, 0
    mov rdi, mydata
    mov rsi, myArrayB
    mov rdx, a_append_b
    mov rcx, max
    call append
    pop rax

    ; delegate task to display_array.cpp to show inputs
    push qword 0
    mov rax, 0
    mov rdi, a_append_b
    mov rsi, append_max
    call displayArray
    pop rax

    ; delegate task to magnitude.asm to calculate magnitude of array a_append_b
    push qword 0
    mov rax, 0
    mov rdi, a_append_b
    mov rsi, append_max
    call magnitude
    pop rax

    ; copy computed value in general purpose SSE for safe keeping
    movsd xmm10, xmm0

    ; print output after calculation
    mov rax, 1
    mov rdi, magnitude_message_a_append_b
    push qword 0
    call printf
    pop rax

    movsd xmm0, xmm10

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