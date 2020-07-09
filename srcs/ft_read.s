%ifidn __OUTPUT_FORMAT__, elf64
	%assign READ_CALL	0x0
	%define ERRNO		__errno_location
	%macro JERR 1
		mov		rdx, rax	; Get error code
		neg		rdx			; Negate error code
		test	rax, rax	; Check for error (Linux)
		js		%1
	%endmacro
%elifidn __OUTPUT_FORMAT__, macho64
	%assign READ_CALL	0x2000003
	%define ERRNO		__error
	%macro JERR 1
		mov		rdx, rax	; Get error code
		jc		%1			; Check for error (BSD)
	%endmacro
%endif

section	.text
global	ft_read
extern	__errno_location

ft_read:					; RDI, RSI, RDX
	mov		rax, READ_CALL	; Read Call #
	syscall					; Call the system
	JERR	.error
	ret
.error:
	sub		rsp, 8			; Align stack to 16 bytes
	call	__errno_location wrt ..plt; Get errno pointer
	add		rsp, 8			; Restore alignment
	mov		[rax], rdx		; Set errno to error code
	mov		rax, -1			; Return -1
	ret