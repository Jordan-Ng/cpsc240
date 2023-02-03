; Name: Jia Wei Ng
; Email: JiaWei.Ng@csu.fullerton.edu
; cwid: 887351328
; Course: CPSC240-07, assignment1

global hypotenuse
extern printf
extern scanf

segment .data
  prompt_message_1 db "Enter the length of the first side of the triangle: ", 0
  prompt_message_2 db "Enter the length of the second side of the triangle: ",0
  double_float db "%lf",0
  feedback db "Negative values not allowed. Try again: ", 0
  confirmation db 0x0a, "Thank you. you entered two sides: %1.6lf and %1.6lf", 0x0a, 0
  result db "The length of the hypotenuse is %1.6lf", 0x0a, 0

segment .text
hypotenuse:
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

  ; print prompt message 1
  mov rax, 0
  mov rdi, prompt_message_1
  push qword 0
  call printf
  pop rax

  ; storing 0 in xmm register to be compared later
  push qword 0
  movsd xmm10, [rsp]
  pop rax

  ; retrieve input from user
  mov rax, 0
  mov rdi, double_float
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm12, [rsp]
  pop rax

validate_1:
  ; validate input, jump to prompt 2 if positive
  ucomisd xmm10, xmm12 
  jb prompt_2

  ; if negative number, display feedback message and prompt user for input
  mov rax, 0
  mov rdi, feedback
  push qword 0
  call printf
  pop rax

  mov rax, 0
  mov rdi, double_float
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm12, [rsp]
  pop rax
  jmp validate_1

prompt_2:
  ; print prompt message 2
  mov rax, 0
  mov rdi, prompt_message_2
  push qword 0
  call printf
  pop rax

  ; retrieve input from user
  mov rax,0
  mov rdi, double_float
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm13, [rsp]
  pop rax

validate_2:
  ; validate input, jump to calculations if positive
  ucomisd xmm10, xmm13
  jb calculation

  ; if negative number, display feedback message and prompt user for input
  mov rax, 0
  mov rdi, feedback
  push qword 0
  call printf
  pop rax

  mov rax, 0
  mov rdi, double_float
  push qword 0
  mov rsi, rsp
  call scanf
  movsd xmm13, [rsp]
  pop rax

  jmp validate_2

calculation:
  ; print input confirmation message
  mov rax, 2
  mov rdi, confirmation
  movsd xmm0, xmm12
  movsd xmm1, xmm13
  push qword 0
  call printf
  pop rax

  ; calculate hypotenuse
  mulsd xmm12, xmm12
  mulsd xmm13, xmm13
  addsd xmm12, xmm13
  sqrtsd xmm14, xmm12

  ; print result to console
  mov rax, 1
  mov rdi, result
  movsd xmm0, xmm14
  push qword 0
  call printf
  pop rax
  
  movsd xmm0, xmm14

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
