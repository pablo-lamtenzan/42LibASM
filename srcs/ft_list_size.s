global ft_list_size
section .text

ft_list_size:
	push		rbp
	mov			rbp, rsp
	xor			rax, rax

.loop:
	test		rdi, rdi
	jz			.end

	mov			rdi, [rdi + 8]
	inc			rax
	jmp			.loop

.end:
	ret
