global	ft_strcpy

section .text

ft_strcpy:
    push	rbp					; put the low-stack pointer to the top of the stack
    mov		rbp, rsp			; clean the stack (allocation of space in stack for rdi)
	push	rdi					; put rdi in the top of the stack (where space is allocated)

.copy:
    cmp		byte [rsi], 0		; check if the value in the address of rsi is 0 (8 bits)
    je		.quit				; jump equal to end
    mov		al, byte [rsi]		; coping the value in to address of rsi to al register (8 bits)
    mov		byte [rdi], al		; coping the value in al register to the address of rdi
    inc		rdi					; increment 1byte rdi address
    inc		rsi					; increment 1byte rsi address
	jmp		.copy				; loop

.quit:
	pop	rax						; put rax in the address of rdi
    pop rbp						; restore rbp (restore low-ptr stack)
    ret							; put rax value in the address of the function call