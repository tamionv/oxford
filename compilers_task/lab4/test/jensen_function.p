(* Jensen's device, functional application *)

var i : integer;

proc sum(var i: integer; left, right: integer; => v: integer): integer;
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

begin
    print_num(sum(i, 0, 9, i * i * i * i)); newline();
end.

(*<<
15333
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc sum(var i: integer; left, right: integer; => v: integer): integer;
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

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #8
@     print_num(sum(i, 0, 9, i * i * i * i)); newline();
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
	set r0, _i
	ldr r4, [r0]
	mul r0, r4, r4
	mul r0, r0, r4
	mul r0, r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _i, 4, 4
@ End
]]*)
