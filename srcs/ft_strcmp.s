global _ft_strcmp

section .text

_ft_strcmp:

	mov			rax, -1
	test		rdi, rdi
	jz			.return
	test		rsi, rsi
	jz			.return


.init:

	mov			r8, rdi
	mov			r9, rsi

	xor			rcx, rcx
	xor			rax, rax
	xor			rbx, rbx


.cmp_loop:

	mov			al, byte [rdi + rcx]
	mov			bl, byte [rsi + rcx]
	cmp			al, 0x0
	je			.cmp_calc
	cmp			bl, 0x0
	je			.cmp_calc
	add			rcx, 1
	cmp			al, bl
	je			.cmp_loop


.cmp_calc:

	sub			rax, rbx				; diff btween al and bl is stored in rbx
	mov			rdi, r8
	mov			rsi, r9


.return:

	ret
