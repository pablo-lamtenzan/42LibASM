global ft_atoi_base
extern  ft_strlen 
section .text
ft_atoi_base:
    push        rbp
    mov         rbp, rsp
    xor         rcx, rcx
    mov         rbx, -1
    xor         r14, r14
    xor         r13, r13
    mov         rax, 1
    jmp         .skip_in_nb
.inc_r12:
    inc r12
    inc rcx
    jmp .skip_in_nb
.inc_r122:
    inc r12
    inc rcx
    jmp .skip_sign
.inc_r14:
    inc r14
    jmp .conversion0
.inc_r142:
    inc r14
    jmp .conversion
.inc_rcx:
    inc rcx
.calc_sign:                             ; count nb of minus to calc final sign
    mul         rbx
    inc         rcx
    je          .skip_sign 
.skip_in_nb:                            ; skip whitespaces in s
    xor         r12, r12                ; bool = 0;
    cmp         byte [rdi + rcx], 0
    je          .error
    cmp         byte [rdi + rcx], 9          ; if (s[i] == ws) {bool = 1;}
    je          .inc_r12
    cmp         byte [rdi + rcx], 10
    je          .inc_r12
    cmp         byte [rdi + rcx], 11
    je          .inc_r12
    cmp         byte [rdi + rcx], 12
    je          .inc_r12
    cmp         byte [rdi + rcx], 13
    je          .inc_r12
    cmp         byte [rdi + rcx], 32
    je          .inc_r12
    cmp         r12, 0                  ; if (bool == 0) {goto .skip_in_nb ; i++}
    je          .skip_sign
.skip_sign:                                 ; skip "+" or "-" in s and calc sign
    xor         r12, r12                ; bool = 0;
    cmp         byte [rdi + rcx], 0
    je          .error
    cmp         byte [rdi + rcx], 43         ; if (s[i] == +-) {bool = 1; goto .calc_sign;})
    je          .inc_r12
    cmp         byte [rdi + rcx], 45
    je          .calc_sign
.check_base:                                ; check base (wp + !db)
    xor         r12, r12                ; bool = 0; i = 0 in header ;
    cmp         byte [rsi + r14], 0          ; if (!base[i]) {goto .check_base_len;}
    je          .check_base_len
    mov         dl, byte [rsi + r14]               ; y = i ; used in .double_char
    cmp         dl, 9          ; if (base[i] == +- or wp) {bool++;}
    je          .inc_r12
    cmp         dl, 10
    je          .inc_r12
    cmp         dl, 11
    je          .inc_r12
    cmp         dl, 12
    je          .inc_r12
    cmp         dl, 13
    je          .inc_r12
    cmp         dl, 32
    je          .inc_r12
    cmp         dl, 43
    je          .inc_r12
    cmp         dl, 45
    je          .inc_r12
    cmp         r12, 1
    je          .error
    inc         r14
    mov         r8, r14
    jmp         .double_char            ; CHECK IF AFTER JUMP CODES FOLLOW WHEN I CALLED IT OR BEFORE THE JUMP FCT CODE
.double_char:                           ; y = i - 1;
    cmp          byte [rsi + r8], 0
    je           .check_base
	cmp          byte [rsi + r8], dl
    je          .error
	INC          r8
    jmp         .double_char
.check_base_len:                        ; check obiouslly if base len  > 2
    cmp         r14, 2                  ; i < 2 ? Error
    jl          .error
    xor         r14, r14
    xor         r8, r8
.pre_conversion:                        ; r15 = len(base);
    mov         rbx, rax                    ; rbx = -1 for neg or 1 for posi
    xor         r15, r15
    mov         r15, rdi                
    mov         rdi, rsi
    call        ft_strlen              ;rax = ft_strlen(base);
    mov         rdi, r15
    mov         r15, rax
.conversion0:                            ; where the magic happends
                                        ; rax = rax * base_len + get_nb(s[i], base);
    cmp         byte [rdi + rcx], 0
    je          .error
    mov         al, byte [rdi + rcx]
    mov         dl, byte [rsi + r14]
    cmp         dl, 0          ; Pas present dans la base ?
    je          .error
    cmp         al, dl         ; if (s[y] != base[z]) {z++; }
    jne         .inc_r14
    add         r13, r14                ; aux2 += get_nb(str[i], base])
    inc         rcx                     ; i++;
    mov         r8, 1
    xor         r14, r14
    jmp         .conversion
.conversion:                            ; where the magic happends
                                        ; rax = rax * base_len + get_nb(s[i], base);
    cmp         byte [rdi + rcx], 0
    je          .final_ret
    mov         rax, r15                ; rax = len(base);
    mov         dl, byte [rsi + r14]
    cmp         dl, 0          ; Pas present dans la base ?
    je          .error
    cmp         byte [rdi + rcx], dl         ; if (s[y] != base[z]) {z++; }
    jne         .inc_r142
    mul         r13                     ; rax = rax * base_len
    mov         r13, rax
    add         r13, r14                ; aux2 += get_nb(str[i], base])
    inc         rcx                     ; i++;
    xor         r14, r14
    jmp         .conversion
.error:                                 ; return must be 0 in error case
    xor         rax, rax                ; ret = 0;
    pop         rbp
    ret
	push		rbp
	mov			rbp, rsp
	xor			rcx, rcx
	mov			rbx, 1
	xor			r14, r14
	xor			rax, rax


.skip_in_nb:							; skip whitespaces in s

	xor			r12, r12				; bool = 0;

	cmp			[rdi + rcx], 9			; if (s[i] == ws) {bool = 1;}
	je			inc, r12
	cmp			[rdi + rcx], 10
	je			inc, r12
	cmp			[rdi + rcx], 11
	je			inc, r12
	cmp			[rdi + rcx], 12
	je			inc, r12
	cmp			[rdi + rcx], 13
	je			inc, r12
	cmp			[rdi + rcx], 32
	je			inc, r12

	cmp			r12, 1					; if (bool == 1) {i++ ; goto .skip_in_nb ;}
	je			inc, rcx
	cmp			r12, 1
	je			.skip_in_nb


.skip_sign:									; skip "+" or "-" in s and calc sign

	xor			r12, r12				; bool = 0;

	cmp			[rdi + rcx], 43			; if (s[i] == +-) {bool = 1; goto .calc_sign;})
	je			inc, r12
	cmp			[rdi + rcx], 45
	je			inc, r12
	cmp			[rdi + rcx], 45
	je			.calc_sign

	cmp			r12, 1					; if (bool == 1) {i++; goto .skip_sign}
	je			inc, rcx
	cmp			r12, 1
	je			.skip_sign


.calc_sign:								; count nb of minus to calc final sign

	cmp			rbx, 0					; rbx == 0 ? rbx += 2 - 1 = 1
	je			inc, rbx
	inc			rbx
	cmp			rbx, 1					; rbx == 1 ? rbx =- 2 + 1 = 0

	je			dec, rbx
	dec			rbx


.check_base:								; check base (wp + !db)

	xor			r12, r12				; bool = 0; i = 0 in header ;

	cmp			[rsi + r14], 0			; if (!base[i]) {goto .check_base_len;}
	je			.check_base_len:

	mov			r13, r14				; y = i ; used in .double_char

	cmp			[rsi + r14], 9			; if (base[i] == +- or wp) {bool++;}
	je			inc, r12
	cmp			[rsi + r14], 10
	je			inc, r12
	cmp			[rsi + r14], 11
	je			inc, r12
	cmp			[rsi + r14], 12
	je			inc, r12
	cmp			[rsi + r14], 13
	je			inc, r12
	cmp			[rsi + r14], 32
	je			inc, r12
	cmp			[rsi + r14], 43
	je			inc, r12
	cmp			[rsi + r14], 45
	je			inc, r12

	cmp			r12, 1					; if (bool == 1) {i++;}
	je			inc, r14				; now y = i - 1
	jmp			.double_char			; CHECK IF AFTER JUMP CODES FOLLOW WHEN I CALLED IT OR BEFORE THE JUMP FCT CODE

	cmp			r12, 1
	je			.error


.double_char:							; y = i - 1;

	mov			ax, [rsi + r14]

	cmp			r13, -1					; when y < 0 all is checked ,we continue
	je			.check_base

	cmp			[rsi + r13] , ax		; base[i] == base[y] ? double_char founded
	je			.error

	dec			r13						; y--;
	jmp			.double_char


.check_base_len:						; check obiouslly if base len  > 2

	cmp			r14, 2					; i < 2 ? Error
	jl			.error
	mov			r13, rcx				; r13 = s counter


.char_in_base:

	cmp			[rsi + r14], 0			; while (base[i++]) {occurence ? convert : return
	je			.final_ret
	mov			ax, [rsi + r14]
	cmp			[rdi + r13], ax
	jne			inc, r14
	cmp			[rdi + r13], ax
	jne			.char_in_base


.conversion:							; where the magic happends
										; rax = rax * base_len + get_nb(s[i], base);
	xor			r14, r14				; char_in_base conter
	jmp			.char_in_base			; CHECK IF AFTER JUMP CODES FOLLOW WHEN I CALLED IT RF BEFORE THE JUMP FCT CODE

	xor			ax, ax

    mov			r15, rax				; aux = rax;

    call		_ft_strlen				; rax = ft_strlen(base);
    mov			r12, rax				; aux2 = rax;

    mov			rax, r15				; rax = aux;
    mulq		r12						; rax *= aux2;

    mov			r13, rcx				; y = i;
    xor			r14, r14				; z = 0;
    mov			ax, [rdi + r13]			; ax = s[y];

    jmp			.get_nb					;  CHECK IF AFTER JUMP CODES FOLLOW WHEM I CALLED IT OR BEFORE THE JUMP FCT CODE

    add			r12, r14				; aux2 += get_nb(str[i], base])
    inc			rcx						; i++;
    jmp			.conversion


.get_nb:								; z = 0;

    cmp			[rsi + r14], 0			; !base[z] ? error
    je			.error
    cmp			ax, [rsi + r14]			; if (s[y] != base[z]) {z++; }
    jne			inc, r14
    cmp			ax, [rsi + r14 - 1]		; calc loop condition without incrementation
    jne			.get_nb


.error:									; return must be 0 in error case

	pop			rbp
	xor			rax, rax				; ret = 0;
	ret

.final_ret:
    mov         rax, r13                ; ret = aux2;
    mul         rbx
    pop         rbp
    ret
