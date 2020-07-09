global ft_list_size
section .text

ft_list_size:
	push		rbp
	mov			rbp, rsp
	xor			rax, rax

.loop:
	test		rdi, rdi
	je			.end
	inc			rax
	mov			rdi, qword [rdi + 8]
	jmp			.loop

.end:
	ret
