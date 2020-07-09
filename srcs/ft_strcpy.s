global _ft_strcpy

section .text

_ft_strcpy:

	push		rbp
	mov			rbp, rsp
	xor			rcx, rcx		; save registers and clean


.ft_strcpy_loop:

	cmp			[rdi + rcx], byte 0
	jz			.ft_strcpy_end
	mov			ax, [rsi + rcx]
	mov			[rdi + rcx], ax
	inc			rcx
	jmp		.ft_strcpy_loop


.ft_strcpy_end:

mov			rax, rdi		; setup ret
pop			rbp				; restore registers
ret
