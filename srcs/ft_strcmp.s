global ft_strcmp

section .text

ft_strcmp:

	mov			rax, -1						; set error value (-1)
	test		rdi, rdi					; check if the value in the address of rdi is NULL
	jz			.return						; if NULL return error
	test		rsi, rsi					; check if the value in the address of rsi is NULL
	jz			.return						; if NULL return error


.init:

	mov			r8, rdi						; save dest addr to free register
	mov			r9, rsi						; save src adrr to free register

	xor			rcx, rcx					; rcx ^ rcx (iterator register)
	xor			rax, rax					; rax ^ rax (return is 0 by default)
	xor			rbx, rbx					; going to store the result in low-stack pointer (init to 0)


.cmp_loop:

	mov			al, byte [rdi + rcx]		; move value in address rdi + rcx to al register (8 bits) (can't cmp 2 memory registers)
	mov			bl, byte [rsi + rcx]		; move value in address rsi + rcx to bl register (8 bits)
	test		al, al						; check if the value stored in al is NULL
	je			.cmp_calc					; jump equal to calc diff
	test		bl, bl 						; check if the value stored in bl is NULL
	je			.cmp_calc					; jump equal to calc diff
	inc			rcx							; increment rcx
	cmp			al, bl						; check if al and bl has the same value
	je			.cmp_loop					; jump equal loop


.cmp_calc:

	sub			rax, rbx					; diff btween al and bl is stored in rbx
	mov			rdi, r8						; restore start addr
	mov			rsi, r9						; restore start addr


.return:

	ret										; put the value of the return in the address of the function call
