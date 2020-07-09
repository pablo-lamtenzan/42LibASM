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

.final_ret:
    
    mov         rax, r13                ; ret = aux2;
    mul         rbx
    pop         rbp
    ret