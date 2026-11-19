; Outside comment
extern fopen
extern fprintf
extern fclose

%define F "Grace_kid.s"
%define S "; Outside comment%3$cextern fopen%3$cextern fprintf%3$cextern fclose%3$c%3$c%%define F %4$cGrace_kid.s%4$c%3$c%%define S %4$c%1$s%4$c%3$c%%macro MAIN 0%3$cdefault rel%3$cglobal main%3$c%3$csection .rodata%3$cs: db S, 0%3$cname: db F, 0%3$cmode: db %4$cw%4$c, 0%3$c%3$csection .text%3$cmain:%3$c%2$cpush rbp%3$c%2$cmov rbp, rsp%3$c%2$cpush rbx%3$c%2$csub rsp, 8%3$c%2$clea rdi, [name]%3$c%2$clea rsi, [mode]%3$c%2$ccall fopen wrt ..plt%3$c%2$ctest rax, rax%3$c%2$cjz .err%3$c%2$cmov rbx, rax%3$c%2$cmov rdi, rbx%3$c%2$clea rsi, [s]%3$c%2$clea rdx, [s]%3$c%2$cmov ecx, 9%3$c%2$cmov r8d, 10%3$c%2$cmov r9d, 34%3$c%2$cxor eax, eax%3$c%2$ccall fprintf wrt ..plt%3$c%2$cmov rdi, rbx%3$c%2$ccall fclose wrt ..plt%3$c%2$cxor eax, eax%3$c%2$cjmp .end%3$c.err:%3$c%2$cmov eax, 1%3$c.end:%3$c%2$cadd rsp, 8%3$c%2$cpop rbx%3$c%2$cpop rbp%3$c%2$cret%3$c%3$csection .note.GNU-stack noalloc noexec nowrite progbits%3$c%%endmacro%3$c%3$cMAIN%3$c"
%macro MAIN 0
default rel
global main

section .rodata
s: db S, 0
name: db F, 0
mode: db "w", 0

section .text
main:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	lea rdi, [name]
	lea rsi, [mode]
	call fopen wrt ..plt
	test rax, rax
	jz .err
	mov rbx, rax
	mov rdi, rbx
	lea rsi, [s]
	lea rdx, [s]
	mov ecx, 9
	mov r8d, 10
	mov r9d, 34
	xor eax, eax
	call fprintf wrt ..plt
	mov rdi, rbx
	call fclose wrt ..plt
	xor eax, eax
	jmp .end
.err:
	mov eax, 1
.end:
	add rsp, 8
	pop rbx
	pop rbp
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
%endmacro

MAIN
