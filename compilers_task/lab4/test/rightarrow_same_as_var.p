proc f(=> x, y : integer) : integer;
begin
    return x + y;
end;
begin
    print_num(f(1, 2));
    newline()
end.

(*<<
3
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc f(=> x, y : integer) : integer;
	.text
_f:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     return x + y;
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	ldr r10, [fp, #52]
	mov r4, r0
	ldr r0, [fp, #48]
	blx r0
	add r0, r4, r0
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     print_num(f(1, 2));
	mov r3, fp
	set r2, __thunk_2
	mov r1, fp
	set r0, __thunk_1
	bl _f
	bl print_num
@     newline()
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	mov r0, #1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	mov r0, #2
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ End
]]*)
