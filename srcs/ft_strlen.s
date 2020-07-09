global ft_strlen

section .text

ft_strlen:

	push		rcx
	xor			rcx, rcx		; save register and clean


.calc_len:

	cmp			[rdi], byte 0	; cmp actual byte with 0
	jz			.return_len		; jump if condition is true

	inc			rcx				; increment counter
	inc			rdi				; increment imput index
	jmp			.calc_len		; jump always

.return_len:

mov			rax, rcx		; setup return value
pop			rcx				; restore rcx
ret							; return
