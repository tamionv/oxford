(* Tests that local variables can be passed as call by name parameters *)

proc f(=> x : integer) : integer;
begin
    return x;
end;
proc g() : integer;
    var x : integer;
begin
    x := 42;
    return f(x);
end;
var x : integer;
begin
    print_num(g());
    newline();
end.

(*<<
42
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

@ proc g() : integer;
_g:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     x := 42;
	mov r4, #42
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
@     print_num(g());
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
	mov r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _x, 4, 4
@ End
]]*)
