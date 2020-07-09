section	.text
	global	ft_strdup
	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy

ft_strdup:
	push	rbp
	mov		rbp, rsp
	push	rdi
	call	ft_strlen

	mov		rdi, rax
	push	rdi
	call	malloc
	cmp		rax, 0x0
	je		.ret

	mov		rdi, rax
	mov		r8, rdi
	pop		rdx
	pop		rsi
	call	ft_strcpy
	mov		rax, r8

.ret:
	leave
	ret


