global  ft_strdup
extern  ft_strlen, malloc, ft_strcpy

section .text

_ft_strdup:
	push r12
	mov	r12, rdi
	call ft_strlen
	mov	rdi, rax
	inc	rdi
	push rax
	
	call malloc
	cmp rax, 0
	je exit

	mov rdi, rax
	mov rsi, r12
	pop rax

	call ft_strcpy

exit:
	pop r12
	ret


