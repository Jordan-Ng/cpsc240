extern printf
extern scanf
extern stdin
extern fgets
extern strlen
extern atoi
extern fillRandomArray
extern printArray
extern quickSort
global executive

INPUT_LEN equ 256
ARRAY_CAPACITY equ 100

segment .data
name_prompt db "Please enter your name: ", 0
title_prompt db "Please enter your title (Mr, Mrs, Sargent, Chief, Project Leader, etc): ", 0
greeting_message db "Nice to meet you %s %s", 0x0a, 0

program_brief_message db 0x0a, "This program will generate 64-bit IEEE float numbers.", 0x0a, 0
array_size_prompt db "How many numbers do you want. Today's limit is 100 per customer: ", 0
array_size_confirmation db "Your %s numbers have been stored in an array. Here is that array.", 0x0a, 0
invalid_array_size_feedback db "Please enter an integer greater than 0", 0x0a, 0
exceeded_array_capacity_feedback db "Please enter an integer less than or equal to 100", 0x0a, 0
string_format db "%s", 0

sort_notification db 0x0a, "The array is now being sorted.", 0x0a, 0
updated_array_notification db "Here is the updated array.", 0x0a, 0
normalized_array_notification db 0x0a, "The random numbers will be normalized. Here is the normalized array.", 0x0a, 0

exit_message db 0x0a, "Good bye %s. You are welcome anytime", 0x0a, 0 

segment .bss
myArray resq ARRAY_CAPACITY
name resb INPUT_LEN
title resb INPUT_LEN
array_size resb INPUT_LEN

segment .text
executive:
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

    ; print name prompt
    mov rax, 0
    mov rdi, name_prompt
    call printf

    ; use fgets to scan input
    push qword 0
    mov rax, 0
    mov rdi, name
    mov rsi, INPUT_LEN
    mov rdx, [stdin]
    call fgets

    ; remove newline char from fgets input
    mov rax, 0
    mov rdi, name
    call strlen
    sub rax, 1
    mov byte [name+rax], 0
    pop rax

    ; print title prompt
    mov rax, 0
    mov rdi, title_prompt
    call printf

    ; scanf to record title input
    mov rax, 0
    mov rdi, string_format
    mov rsi, title
    call scanf

    ; print greeting message
    mov rax, 0
    mov rdi, greeting_message
    mov rsi, title 
    mov rdx, name
    call printf
    
    ; print program brief message + array size prompt
    mov rax, 0 
    mov rdi, program_brief_message
    call printf

; ============ validation for array size user input ====================
input_array_size:
    mov rax, 0
    mov rdi, array_size_prompt
    call printf

    ; get user input for desired array size
    mov rax, 0
    mov rdi, string_format
    mov rsi, array_size
    call scanf

    ; try to convert input to int with atoi
    ; push qword 0
    mov rax, 0 
    mov rdi, array_size
    call atoi
    mov r13, rax                ; array size will be stored in r13
    ; pop rax

    ; compare converted value, jump to labels as necessary
    ; push qword 0
    cmp r13, 100
    jg exceeded_array_capacity  ; input exceeding defined capacity
    cmp r13, 0                  
    js invalid_array_size       ; negative values
    je invalid_array_size       ; invalid conversion
    jg end_input_array_size_loop
    ; pop rax

invalid_array_size: 
    ; print invalid input feedback message
    ; push qword 0
    mov rax, 0
    mov rdi, invalid_array_size_feedback
    call printf
    jmp input_array_size
    ; pop rax

exceeded_array_capacity:
    ; print exceeded array capacity message
    ; push qword 0
    mov rax, 0 
    mov rdi, exceeded_array_capacity_feedback
    call printf
    jmp input_array_size
    ; pop rax

end_input_array_size_loop:
    ; print array size confirmation message
    ; push qword 0
    mov rax, 0
    mov rdi, array_size_confirmation
    mov rsi, array_size
    call printf
    ; pop rax

; =============== generate random numbers for array ======================
    ; delegate task to fill_random_array.asm to fill array with 64 bit random numbers
    ; push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r13
    call fillRandomArray
    ; pop rax

    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r13
    call printArray
    pop rax

; =============== sorting array with qsort ===========================
    ; notify user that array is now being sorted
    ; push qword 0
    mov rax, 0
    mov rdi, sort_notification
    call printf
    ; pop rax

    ; push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r13
    call quickSort
    ; pop rax

    ; push qword 0
    mov rax, 0
    mov rdi, updated_array_notification
    call printf
    ; pop rax

    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r13
    call printArray
    pop rax
; =============== normalizing array ================================
    ; print normalized array notification
    ; push qword 0
    mov rax, 0
    mov rdi, normalized_array_notification
    call printf
    ; pop rax

    mov r15, 0 

normalize:
    cmp r15, r13
    je printNormalizedArray

    ; push qword 0
    mov rcx, 1023
    shl rcx, 52
    
    mov rdx, [myArray+ r15*8]
    shl rdx, 12
    shr rdx, 12

    or rdx, rcx
    mov [myArray + r15*8], rdx
    ; pop rax

    inc r15
    jmp normalize

printNormalizedArray:
    push qword 0
    mov rax, 0
    mov rdi, myArray
    mov rsi, r13
    call printArray
    pop rax

    mov rax, 0
    mov rdi, exit_message
    mov rsi, title
    call printf

    ; return name back to driver
    mov rax, name

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