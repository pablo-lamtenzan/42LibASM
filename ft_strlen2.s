global _ft_strlen2

section .text

_ft_strlen2:

push        rbx                     ; save registers
push        rcx                     ;

mov         rbx, rdi                ;take fisrt address of argv[1]

xor         al, al                  ;al = 0, so i gonna use it to cmp to rdi value with scasb

mov         rcx, 0xffffffff       ;set the max it loop for repne (4gb)

repne       scasb                   ; while [rdi] != al keep scaning

sub         rdi, rdx                ; final address - dest address = len
mov         rax, rdi                ; put len in return

pop         rcx                     
pop         rbx                     ; restore registers

ret                                 ; return len
