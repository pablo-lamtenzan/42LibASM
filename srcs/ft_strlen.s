global ft_strlen

section .text

ft_strlen:

	push		rcx				; put rcx top stack
	xor			rcx, rcx		; rcx ^ rcx


.calc_len:

	cmp			[rdi], byte 0	; check if address of rdi is 0
	jz			.return_len		; if true jump to end

	inc			rcx				; lenght iterator, will be returned
	inc			rdi				; incremet the address of rdi 1 byte
	jmp			.calc_len		; loop

.return_len:

mov			rax, rcx			; move value in rcx address to the address of rax
pop			rcx					; pull rxc from the stack
ret								; stores the value in rax in the address of the function call
