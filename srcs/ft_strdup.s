global	ft_strdup
global	ft_strncpy

extern	malloc
extern	ft_strlen

section	.text

ft_strncpy:				
	mov		rax, rdi			; put addr rdi in rax
	mov		rcx, rdx			; put lenght in iterator register
	cld							; Clear DF / go forward
	rep		movsb				; copy the rcx bytes of rsi and put it rdi
	ret							; put rax addr (who is equal to rdi address) in the address of the function call

ft_strdup:
	push	rdi					; put rdi in the top of the stack (save it for ft_strncpy)
	call	ft_strlen			; call strlen, rax takes to value stored in function call address
	inc		rax					; intrement rax for \0 (the lenght returnd by strlen)
	mov		rdi, rax			; set the size for malloc using the incremented rax
	push	rax					; put the size in the top of the stack
	sub		rsp, 8				; allocate space in the stack for address of the function call
	call	malloc wrt ..plt	; call malloc, rax takes a pointer of the first address in the first memory block stored in the function call address
	add		rsp, 8				; restore the allocated size for the function call pointer
	pop		rdx					; takes tack from the stack the size
	pop		rsi					; will be used for the src of ft_strncpy
	test	rax, rax			; check if the pointer of memory blocks 
	jz		.end				; jump equal == 0 go end 
	mov		rdi, rax			; put the pointer of the memory blocks allocated in rdi (who will be used in ft_strncpy)
	sub		rsp, 8				; allocate space for the function call addr
	call	ft_strncpy			; rax == to a pointer of the allocated mem block (rdi), where rsi value was be copied using rcx size
	add		rsp, 8				; restore the allocation for function call pointer
.end:
	ret							; puts a pointer of allocated string in the function call pointer