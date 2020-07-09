%ifidn __OUTPUT_FORMAT__, elf64
	%assign WRITE_CALL	0x1
	%define ERRNO		__errno_location
	%macro JERR 1
		mov		rdx, rax		; Get error code
		neg		rdx				; Negate error code
		test	rax, rax		; Check for error (Linux)
		js		%1
	%endmacro
%elifidn __OUTPUT_FORMAT__, macho64
	%assign WRITE_CALL	0x2000004
	%define ERRNO		__error
	%macro JERR 1
		mov		rdx, rax		; Get error code
		jc		%1				; Check for error (BSD)
	%endmacro
%endif

global	ft_write
extern	ERRNO

section	.text

ft_write:
	mov		rax, WRITE_CALL		; write Syscall code in rax
	syscall						; System is called and reads rax
	JERR	.error				; check in value of write call pointer if error code is returned by write all
	ret							; put the return value in the function call pointer
.error:
	sub		rsp, 8				; allocates 64bits in the stack for the fuction call pointer
	call	ERRNO wrt ..plt 	; rax takes ernno's ret pointer
	add		rsp, 8				; restore the stack allocated for the function call address
	mov		[rax], rdx			; set the error code
	mov		rax, -1				; rax = -1 (ERROR)
	ret							; put the return value in the function call pointer