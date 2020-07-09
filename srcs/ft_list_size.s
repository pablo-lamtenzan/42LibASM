global ft_list_size

section .text

ft_list_size:
	xor		rax,	rax			; init rax as iterator having value of 0
.loop:
	test	rdi,	rdi			; check if rdi is NULL
	jz		.end				; jump equal end
	inc		rax					; increment iterator rax
	mov		rdi,	[rdi + 8]	; goes 64bits further (1 address size of)
	jmp		.loop				; loop
.end:
	ret							; put iterator rax value in the fct call address
