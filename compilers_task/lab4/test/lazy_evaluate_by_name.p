(* Tests that call by name parameters are only evaluated when needed *)

proc f(=> x : integer);
begin
    print_string("hello");
    newline();
end;

proc h(var x : integer) : integer;
begin
    x := x + 1;
    return x;
end;

var x : integer;
begin
    x := 0;
    f(h(x));
    print_num(x);
    newline()
end.

(*<<
hello
0
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc f(=> x : integer);
	.text
_f:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     print_string("hello");
	mov r1, #5
	set r0, g2
	bl print_string
@     newline();
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc h(var x : integer) : integer;
_h:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     x := x + 1;
	ldr r4, [fp, #40]
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
@     return x;
	ldr r0, [fp, #40]
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     x := 0;
	set r4, _x
	mov r0, #0
	str r0, [r4]
@     f(h(x));
	mov r1, fp
	set r0, __thunk_1
	bl _f
@     print_num(x);
	ldr r0, [r4]
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
	set r0, _x
	bl _h
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _x, 4, 4
	.data
g2:
	.byte 104, 101, 108, 108, 111
	.byte 0
@ End
]]*)
