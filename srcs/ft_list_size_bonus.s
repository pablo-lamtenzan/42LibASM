global _ft_list_size
sectiom .text

_ft_list_size:
	push		rbp
	mov			rbp, rsp
	xor			rax, rax

.loop:
	test		rdi
	je			.end
	inc			rax
	mov			rdi, qword [rdi + 8]
	jmp			.loop

.end:
	ret
