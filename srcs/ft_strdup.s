section	.text
global	ft_strdup
extern	malloc
extern	ft_strlen
global	ft_strncpy

ft_strncpy:			; RDI, RSI, RDX - RAX, RCX
	mov		rax, rdi	; Set RAX to dest
	mov		rcx, rdx	; Set RCX to RDX
	cld					; Clear DF / go forward
	rep		movsb		; Copy RCX bytes from RSI to RDI
	ret

ft_strdup:						; RDI - RAX, RDX, RDI
	push	rdi					; Save src
	call	ft_strlen			; ft_strlen(RDI)
	inc		rax					; Increment len
	mov		rdi, rax			; Set RDI to size
	push	rax					; Save size
	sub		rsp, 8				; Align stack to 16 bytes
	call	malloc wrt ..plt	; malloc(RDI)
	add		rsp, 8				; Restore alignment
	pop		rdx					; Set RDX to size
	pop		rsi					; Set RSI to src
	test	rax, rax			; Check for NULL
	jz		.end				; Abort and return NULL
	mov		rdi, rax			; Set RDI to dst
	sub		rsp, 8				; Align stack to 16 bytes
	call	ft_strncpy			; ft_strncpy(RDI, RSI, RDX)
	add		rsp, 8				; Restore alignment
.end:
	ret