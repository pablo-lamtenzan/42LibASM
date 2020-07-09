%ifidn __OUTPUT_FORMAT__, elf64
	%assign READ_CALL	0x0
	%define ERRNO		__errno_location
	%macro JERR 1
		mov		rdx, rax				; Get error code
		neg		rdx						; Negate error code
		test	rax, rax				; Check for error (Linux)
		js		%1
	%endmacro
%elifidn __OUTPUT_FORMAT__, macho64
	%assign READ_CALL	0x2000003
	%define ERRNO		__error
	%macro JERR 1
		mov		rdx, rax				; Get error code
		jc		%1						; Check for error (BSD)
	%endmacro
%endif

section	.text
global	ft_read
extern	__errno_location

ft_read:
	mov		rax, READ_CALL				; put Syscall read code in arx
	syscall								; reads from rax and rax takes the value of the function call address
	JERR	.error						; check if error in rax
	ret									; no error: put rax value in function pointer addr
.error:
	sub		rsp, 8						; allocates 64bits in the stack for function call pointer
	call	__errno_location wrt ..plt	; call errno, errno code from fct call addr stored in rax
	add		rsp, 8						; restores the stack from the allocated fct call addr
	mov		[rax], rdx					; sellect errno code in rax
	mov		rax, -1						; put -1 in rax
	ret									; put rax value in the funct call address