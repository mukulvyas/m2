section .bss
    output_string resb 12   ; Buffer to store the ASCII string (up to 11 digits + null terminator)

section .text
    global _start

_start:
    ; Read an integer from the user
    mov eax, 3                ; syscall number for sys_read
    mov ebx, 0                ; file descriptor 0 (stdin)
    mov ecx, output_string    ; buffer to store the input
    mov edx, 12               ; maximum number of bytes to read
    int 0x80                  ; invoke the syscall

    ; Convert the integer to an ASCII string
    mov eax, 4                ; syscall number for sys_write
    mov ebx, 1                ; file descriptor 1 (stdout)
    mov ecx, output_string    ; pointer to the ASCII string
    add ecx, 11               ; move the pointer to the end of the buffer
    mov byte [ecx], 0         ; null terminator for the ASCII string
    dec ecx                   ; point ECX to the last character of the string

convert_loop:
    xor edx, edx             ; clear EDX for the division operation
    mov ebx, 10              ; divisor (10 for decimal conversion)
    div ebx                  ; divide EAX by 10, quotient in EAX, remainder in EDX
    add dl, '0'              ; convert the remainder to ASCII character
    mov [ecx], dl            ; store the character in the output buffer
    dec ecx                  ; move the pointer to the next character
    test eax, eax            ; check if quotient is zero
    jnz convert_loop         ; if not zero, continue the loop

    ; Write the ASCII string to stdout
    sub ecx, 11              ; point ECX back to the beginning of the string
    mov edx, 11              ; number of bytes to write (excluding null terminator)
    int 0x80                 ; invoke the syscall

    ; Exit the program
    mov eax, 1               ; syscall number for sys_exit
    xor ebx, ebx             ; exit code 0
    int 0x80                 ; invoke the syscall

