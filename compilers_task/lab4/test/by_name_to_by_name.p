(* Tests that call by name parameters can be passed as call by name parameters *)

proc f(=> x : integer) : integer;
begin
    return x;
end;
proc g(=> x : integer) : integer;
begin
    return f(x);
end;
var x : integer;
begin
    x := 49;
    print_num(g(x));
    newline();
end.

(*<<
49
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc f(=> x : integer) : integer;
	.text
_f:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     return x;
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc g(=> x : integer) : integer;
_g:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     return f(x);
	mov r1, fp
	set r0, __thunk_1
	bl _f
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     x := 49;
	mov r0, #49
	set r1, _x
	str r0, [r1]
@     print_num(g(x));
	mov r1, fp
	set r0, __thunk_2
	bl _g
	bl print_num
@     newline();
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	ldr r4, [fp, #24]
	ldr r10, [r4, #44]
	ldr r0, [r4, #40]
	blx r0
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	set r0, _x
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _x, 4, 4
@ End
]]*)
