(* Jensen's device, more involved application, using global variables*)

var i : integer;

var a: array 10 of integer;

proc sum(var i: integer; left, right:integer; => v: integer): integer;
    var retval: integer;
begin
    retval := 0;
    i := left;
    while i <= right do
        retval := retval + v;
        i := i+1;
    end;
    return retval;
end;

proc print_and_ret(x : integer): integer;
begin
    print_num(x);
    newline();
    return x;
end;

begin
    a[0] := 0;
    a[1] := 1;
    a[2] := 2;
    a[3] := 3;
    a[4] := 4;
    a[5] := 5;
    a[6] := 6;
    a[7] := 7;
    a[8] := 8;
    a[9] := 9;
    print_num(sum(i, 0, 9, print_and_ret(a[i] * a[i]))); newline();
end.

(*<<
0
1
4
9
16
25
36
49
64
81
285
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc sum(var i: integer; left, right:integer; => v: integer): integer;
	.text
_sum:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     retval := 0;
	mov r4, #0
@     i := left;
	ldr r0, [fp, #44]
	ldr r1, [fp, #40]
	str r0, [r1]
.L3:
@     while i <= right do
	ldr r0, [fp, #40]
	ldr r0, [r0]
	ldr r1, [fp, #48]
	cmp r0, r1
	bgt .L5
@         retval := retval + v;
	ldr r10, [fp, #56]
	ldr r0, [fp, #52]
	blx r0
	add r4, r4, r0
@         i := i+1;
	ldr r5, [fp, #40]
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	b .L3
.L5:
@     return retval;
	mov r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc print_and_ret(x : integer): integer;
_print_and_ret:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     print_num(x);
	ldr r0, [fp, #40]
	bl print_num
@     newline();
	bl newline
@     return x;
	ldr r0, [fp, #40]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #8
@     a[0] := 0;
	set r4, _a
	mov r0, #0
	str r0, [r4]
@     a[1] := 1;
	mov r0, #1
	str r0, [r4, #4]
@     a[2] := 2;
	mov r0, #2
	str r0, [r4, #8]
@     a[3] := 3;
	mov r0, #3
	str r0, [r4, #12]
@     a[4] := 4;
	mov r0, #4
	str r0, [r4, #16]
@     a[5] := 5;
	mov r0, #5
	str r0, [r4, #20]
@     a[6] := 6;
	mov r0, #6
	str r0, [r4, #24]
@     a[7] := 7;
	mov r0, #7
	str r0, [r4, #28]
@     a[8] := 8;
	mov r0, #8
	str r0, [r4, #32]
@     a[9] := 9;
	mov r0, #9
	str r0, [r4, #36]
@     print_num(sum(i, 0, 9, print_and_ret(a[i] * a[i]))); newline();
	str fp, [sp]
	set r3, __thunk_1
	mov r2, #9
	mov r1, #0
	set r0, _i
	bl _sum
	bl print_num
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	set r0, _a
	set r1, _i
	ldr r1, [r1]
	lsl r1, r1, #2
	add r0, r0, r1
	ldr r4, [r0]
	mul r0, r4, r4
	bl _print_and_ret
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _i, 4, 4
	.comm _a, 40, 4
@ End
]]*)
