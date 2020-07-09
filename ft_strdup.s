global _ft_strdup

extern _ft_strlen
extern _ft_strcpy
extern _malloc

section .text

_ft_strdup:

	mov			rbx, rdi		; save str imput address

	call		ft_strlen
	mov			rdx, rax
	inc			rax				; + 1 for '/0'
	mov			rdi, rax		; set ret in imput
	push		rax				; push rax to the top of the stack

	call		malloc
	cmp			rax, 0
	je			.return
	mov			rdi, rax		; malloc str in rbi
	mov			rsi, rbx		; first imput str to 2nd arg
	pop			rbx			; restore registers

	call		ft_strcpy		; uses malloc str (1st arg) and 1st imput (2nd arg)


.return:

	ret
