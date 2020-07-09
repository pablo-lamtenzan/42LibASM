global ft_list_size
section .text


;ft_list_size:
;	push		rbp
;	mov			rbp, rsp
;	xor			rax, rax
;
;.loop:
;	test		rdi, rdi
;	jz			.end
;
;	mov			rdi, [rdi + 8]
;	inc			rax
;	jmp			.loop

;.end:
;	ret


ft_list_size:					; RDI - RAX
	sub		rax,	rax			; Clear RCX
.loop:
	test	rdi,	rdi			; Check for NULL
	jz		.end
	mov		rdi,	[rdi + 8]	; Load next pointer
	inc		rax
	jmp		.loop					; Loop
.end:
	ret
