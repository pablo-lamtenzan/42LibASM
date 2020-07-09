global _ft_list_push_front
extern ft_create_elem

section .text
_ft_list_push_front:
	test		rdi
	je			.end
	test		rsi
	je			.end
	push		rdi
	push		rsi
	sub			rsp, 8
	mov			rdi, rsi
	call		ft_create_elem
	add			rsp, 8
	pop			rsi
	pop			rdi
	test		rax
	je			.end
	mov			rdx, rdi
	test		rdx
	je			.empty_list
	mov			qword [rax + 8], rdx

.empty_list:
	mov			qword [rdi], rax

.end:
	ret
