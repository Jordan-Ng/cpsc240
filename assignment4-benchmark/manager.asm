extern printf
extern scanf
extern getfreq
extern getRadicand
extern atoi
extern atof
global manager

section .data
    greeting_message db "Welcome to Square Root Benchmarks by Jia Wei Ng", 0x0a, 0
    support_message db "For customer service, please contact be at JiaWei.Ng@csu.fullerton.edu", 0x0a, 0
    cpu_information db 0x0a, "Your CPU is %s", 0x0a, 0
    clock_speed_prompt db 0x0a, "Please enter the maximum clock speed for your machine: ", 0
    invalid_clock_speed_feedback db "Please try again. the typical max clock speed is 3500 Mhz to 8430 MHz", 0x0a, 0
    clock_speed_information db 0x0a, "Your max clock speed is %1.2lf GHz", 0x0a, 0
    computed_root_message db "The square root of %1.4lf is %1.4lf", 0x0a, 0
    iteration_number_prompt db 0x0a, "Next enter the number of times iteration should be performed: ", 0
    invalid_input_feedback db "Invalid input detected. Please enter a valid value greater than 0", 0x0a, 0
    timestamp_before_benchmark_message db 0x0a, "The time on the clock is %llu tics.", 0x0a, 0
    benchmark_in_progress_message db "The benchmark of the sqrtsd instructions is in progress", 0x0a, 0
    benchmark_complete_message db 0x0a, "The time on the clock is %llu tics and the benchmark is completed", 0x0a, 0
    elapse_time_message db 0x0a, "The elapse time was %llu tics", 0x0a, 0
    result_message db 0x0a, "The time for one square root computation is %1.5lf tics which equals %1.5lf ns.", 0x0a, 0
    string_format db "%s"
    char_format db "%c", 0x0a

section .bss
    vendor_information resb 100
    max_cpu_frequency resb 10
    no_of_iterations resb 100

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

    ; print greeting and support message
    mov rax, 0
    mov rdi, greeting_message
    call printf

    mov rax, 0
    mov rdi, support_message
    call printf

    ; === getting CPU information ===
    
    ; store first 4 of CPU information 
    mov rax, 0x80000002
    cpuid

    mov [vendor_information], rax
    mov [vendor_information+4], rbx
    mov [vendor_information+8], rcx
    mov [vendor_information+12], rdx

    ; store next 4 of CPU information
    mov rax, 0x80000003
    cpuid

    mov [vendor_information+16], rax
    mov [vendor_information+20], rbx
    mov [vendor_information+24], rcx
    mov [vendor_information+28], rdx

    ; store last 4 of CPU information
    mov rax, 0x80000004
    cpuid

    mov [vendor_information+32], rax
    mov [vendor_information+36], rbx
    mov [vendor_information+40], rcx
    mov [vendor_information+44], rdx

    ; === print CPU information ===
    mov rax, 0
    mov rdi, cpu_information
    mov rsi, vendor_information
    call printf

    ; mov rbx, [vendor_information+32]
    ; mov [max_cpu_frequency], rbx
    
    ; mov rax, 0
    ; mov rdi, max_cpu_frequency
    ; call atof
    ; movsd xmm12, xmm0     ; storing max cpu frequency in xmm12

    ; mov rax, 0
    ; mov rdi, char_format
    ; mov rsi, [vendor_information+33]
    ; call printf

    ; === get maximum CPU clock speed ===
    ; mov rax, 0
    ; call getfreq
    ; movsd xmm14, xmm0

    ; ;; movsd xmm0, xmm12
    ; mov rax, 1
    ; movsd xmm0, xmm14
    ; mov rdi, clock_speed_information
    ; call printf

cpu_freq_validation:
    mov rax, 0
    mov rdi, clock_speed_prompt
    call printf

    mov rax, 0
    mov rdi, string_format
    mov rsi, max_cpu_frequency
    call scanf

    mov rax, 0
    mov rdi, max_cpu_frequency
    call atoi

    cmp rax, 3500
    jb invalid_cpu_clock_speed
    cmp rax, 8430
    jg invalid_cpu_clock_speed
    
    mov r12, rax

    push qword 0
    mov rax, r12
    cvtsi2sd xmm12, rax     ; max clock speed
    mov rax, 1000           
    cvtsi2sd xmm11, rax 
    divsd xmm12, xmm11
    pop rax

    mov rax, 1
    movsd xmm0, xmm12
    mov rdi, clock_speed_information
    call printf

    jmp get_radicand

invalid_cpu_clock_speed:
    mov rax, 0
    mov rdi, invalid_clock_speed_feedback
    call printf
    jmp cpu_freq_validation

get_radicand:
    ; === getting user input for floating radicand ===
    mov rax, 0
    call getRadicand
    movsd xmm15, xmm0   ; storing input to operate on in xmm15

    ; === print computed square root of entered input ===
    sqrtsd xmm13, xmm15

    movsd xmm0 ,xmm15
    movsd xmm1 ,xmm13
    mov rax, 2
    mov rdi, computed_root_message
    call printf

    ; === getting user input for number of iterations ===
iteration_input:
    mov rax, 0 
    mov rdi, iteration_number_prompt
    call printf
    
    mov rax, 0 
    mov rdi, string_format
    mov rsi, no_of_iterations
    call scanf

    ; validations
    mov rax, 0
    mov rdi, no_of_iterations 
    call atoi
    cmp rax, 0
    jg get_timestamp

    mov rax, 0
    mov rdi, invalid_input_feedback
    call printf
    jmp iteration_input

get_timestamp:
    mov r15, rax    ; storing number of iterations in r15
    xor rdx, rdx
    xor rax, rax
    cpuid
    rdtsc
    shl rdx, 32
    add rdx, rax
    mov r14, rdx   ; storing before timestamp in r14

    mov rax, 0
    mov rdi, timestamp_before_benchmark_message
    mov rsi, r14
    call printf

    mov rax, 0
    mov rdi, benchmark_in_progress_message
    call printf

    mov r13, 0  ; initialize counter

benchmarking:
    cmp r13, r15
    je benchmarking_done

    sqrtsd xmm0, xmm15
    inc r13 
    jmp benchmarking

benchmarking_done:
    ; get timestamp after benchmarking
    xor rdx, rdx
    xor rax, rax
    cpuid
    rdtsc
    shl rdx, 32
    add rdx, rax
    mov r13, rdx   ; storing after timestamp in r13

result_analysis:
    ; printing timestamp after benchmark
    mov rax, 0
    mov rdi, benchmark_complete_message
    mov rsi, r13
    call printf

    ; calculating elapsed time
    sub r13, r14
    mov rax, 0
    mov rdi, elapse_time_message
    mov rsi, r13
    call printf 

    ; calculating time taken for one operation
    mov rax, r13
    cvtsi2sd xmm14, rax     ; elapsed time
    mov rax, r15
    cvtsi2sd xmm13, rax     ; number of iterations

    divsd xmm14, xmm13      ; time taken (tics) for one opertaion

    ; push qword 0
    ; mov rax, r12
    ; cvtsi2sd xmm12, rax     ; max clock speed
    ; mov rax, 1000           
    ; cvtsi2sd xmm11, rax     ; 
    ; divsd xmm12, xmm11
    ; pop rax

    movsd xmm15, xmm14
    divsd xmm15, xmm12      ; 

    mov rax, 1
    movsd xmm0, xmm14
    movsd xmm1, xmm15
    mov rdi, result_message
    call printf

    movsd xmm0, xmm15
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