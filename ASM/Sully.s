default rel
global main
extern snprintf
extern strcmp
extern fopen
extern fprintf
extern fclose
extern system

section .data
n: dd 5

section .rodata
s: db "default rel%3$cglobal main%3$cextern snprintf%3$cextern strcmp%3$cextern fopen%3$cextern fprintf%3$cextern fclose%3$cextern system%3$c%3$csection .data%3$cn: dd %5$d%3$c%3$csection .rodata%3$cs: db %4$c%1$s%4$c, 0%3$cfile: db __FILE__, 0%3$csrc_fmt: db %4$cSully_%%d.s%4$c, 0%3$cbin_fmt: db %4$cSully_%%d%4$c, 0%3$cmode: db %4$cw%4$c, 0%3$ccc_fmt: db %4$cnasm -f elf64 %%1$s -o %%2$s.o && gcc %%2$s.o -o %%2$s && rm -f %%2$s.o%4$c, 0%3$crun_fmt: db %4$c./%%s%4$c, 0%3$c%3$csection .bss%3$cself: resb 64%3$csrc: resb 64%3$cbin: resb 64%3$ccmd: resb 256%3$c%3$csection .text%3$cmain:%3$c%2$cpush rbp%3$c%2$cmov rbp, rsp%3$c%2$cpush rbx%3$c%2$csub rsp, 8%3$c%2$clea rdi, [self]%3$c%2$cmov esi, 64%3$c%2$clea rdx, [src_fmt]%3$c%2$cmov ecx, [n]%3$c%2$cxor eax, eax%3$c%2$ccall snprintf wrt ..plt%3$c%2$clea rdi, [self]%3$c%2$clea rsi, [file]%3$c%2$ccall strcmp wrt ..plt%3$c%2$ctest eax, eax%3$c%2$cjnz .check%3$c%2$cdec dword [n]%3$c.check:%3$c%2$ccmp dword [n], 0%3$c%2$cjl .ok%3$c%2$clea rdi, [src]%3$c%2$cmov esi, 64%3$c%2$clea rdx, [src_fmt]%3$c%2$cmov ecx, [n]%3$c%2$cxor eax, eax%3$c%2$ccall snprintf wrt ..plt%3$c%2$clea rdi, [bin]%3$c%2$cmov esi, 64%3$c%2$clea rdx, [bin_fmt]%3$c%2$cmov ecx, [n]%3$c%2$cxor eax, eax%3$c%2$ccall snprintf wrt ..plt%3$c%2$clea rdi, [src]%3$c%2$clea rsi, [mode]%3$c%2$ccall fopen wrt ..plt%3$c%2$ctest rax, rax%3$c%2$cjz .err%3$c%2$cmov rbx, rax%3$c%2$cmov rdi, rbx%3$c%2$clea rsi, [s]%3$c%2$clea rdx, [s]%3$c%2$cmov ecx, 9%3$c%2$cmov r8d, 10%3$c%2$cmov r9d, 34%3$c%2$cmov eax, [n]%3$c%2$csub rsp, 8%3$c%2$cpush rax%3$c%2$cxor eax, eax%3$c%2$ccall fprintf wrt ..plt%3$c%2$cadd rsp, 16%3$c%2$cmov rdi, rbx%3$c%2$ccall fclose wrt ..plt%3$c%2$clea rdi, [cmd]%3$c%2$cmov esi, 256%3$c%2$clea rdx, [cc_fmt]%3$c%2$clea rcx, [src]%3$c%2$clea r8, [bin]%3$c%2$cxor eax, eax%3$c%2$ccall snprintf wrt ..plt%3$c%2$clea rdi, [cmd]%3$c%2$ccall system wrt ..plt%3$c%2$ctest eax, eax%3$c%2$cjnz .err%3$c%2$clea rdi, [cmd]%3$c%2$cmov esi, 256%3$c%2$clea rdx, [run_fmt]%3$c%2$clea rcx, [bin]%3$c%2$cxor eax, eax%3$c%2$ccall snprintf wrt ..plt%3$c%2$clea rdi, [cmd]%3$c%2$ccall system wrt ..plt%3$c%2$ctest eax, eax%3$c%2$cjnz .err%3$c.ok:%3$c%2$cxor eax, eax%3$c%2$cjmp .end%3$c.err:%3$c%2$cmov eax, 1%3$c.end:%3$c%2$cadd rsp, 8%3$c%2$cpop rbx%3$c%2$cpop rbp%3$c%2$cret%3$c%3$csection .note.GNU-stack noalloc noexec nowrite progbits%3$c", 0
file: db __FILE__, 0
src_fmt: db "Sully_%d.s", 0
bin_fmt: db "Sully_%d", 0
mode: db "w", 0
cc_fmt: db "nasm -f elf64 %1$s -o %2$s.o && gcc %2$s.o -o %2$s && rm -f %2$s.o", 0
run_fmt: db "./%s", 0

section .bss
self: resb 64
src: resb 64
bin: resb 64
cmd: resb 256

section .text
main:
	push rbp
	mov rbp, rsp
	push rbx
	sub rsp, 8
	lea rdi, [self]
	mov esi, 64
	lea rdx, [src_fmt]
	mov ecx, [n]
	xor eax, eax
	call snprintf wrt ..plt
	lea rdi, [self]
	lea rsi, [file]
	call strcmp wrt ..plt
	test eax, eax
	jnz .check
	dec dword [n]
.check:
	cmp dword [n], 0
	jl .ok
	lea rdi, [src]
	mov esi, 64
	lea rdx, [src_fmt]
	mov ecx, [n]
	xor eax, eax
	call snprintf wrt ..plt
	lea rdi, [bin]
	mov esi, 64
	lea rdx, [bin_fmt]
	mov ecx, [n]
	xor eax, eax
	call snprintf wrt ..plt
	lea rdi, [src]
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
	mov eax, [n]
	sub rsp, 8
	push rax
	xor eax, eax
	call fprintf wrt ..plt
	add rsp, 16
	mov rdi, rbx
	call fclose wrt ..plt
	lea rdi, [cmd]
	mov esi, 256
	lea rdx, [cc_fmt]
	lea rcx, [src]
	lea r8, [bin]
	xor eax, eax
	call snprintf wrt ..plt
	lea rdi, [cmd]
	call system wrt ..plt
	test eax, eax
	jnz .err
	lea rdi, [cmd]
	mov esi, 256
	lea rdx, [run_fmt]
	lea rcx, [bin]
	xor eax, eax
	call snprintf wrt ..plt
	lea rdi, [cmd]
	call system wrt ..plt
	test eax, eax
	jnz .err
.ok:
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
