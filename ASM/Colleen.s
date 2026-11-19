; Outside comment
default rel
global main
extern printf

section .rodata
s: db "; Outside comment%3$cdefault rel%3$cglobal main%3$cextern printf%3$c%3$csection .rodata%3$cs: db %4$c%1$s%4$c, 0%3$c%3$csection .text%3$cfoo:%3$c%2$cpush rbp%3$c%2$cmov rbp, rsp%3$c%2$cmov rsi, rdi%3$c%2$cmov edx, 9%3$c%2$cmov ecx, 10%3$c%2$cmov r8d, 34%3$c%2$cxor eax, eax%3$c%2$ccall printf wrt ..plt%3$c%2$cpop rbp%3$c%2$cret%3$c%3$cmain:%3$c%2$c; Inside comment%3$c%2$cpush rbp%3$c%2$cmov rbp, rsp%3$c%2$clea rdi, [s]%3$c%2$ccall foo%3$c%2$cxor eax, eax%3$c%2$cpop rbp%3$c%2$cret%3$c%3$csection .note.GNU-stack noalloc noexec nowrite progbits%3$c", 0

section .text
foo:
	push rbp
	mov rbp, rsp
	mov rsi, rdi
	mov edx, 9
	mov ecx, 10
	mov r8d, 34
	xor eax, eax
	call printf wrt ..plt
	pop rbp
	ret

main:
	; Inside comment
	push rbp
	mov rbp, rsp
	lea rdi, [s]
	call foo
	xor eax, eax
	pop rbp
	ret

section .note.GNU-stack noalloc noexec nowrite progbits
