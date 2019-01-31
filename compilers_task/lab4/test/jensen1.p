(* Jensen's device, simple application, using local variables*)

proc test();
    var i : integer;
    var a: array 10 of integer;

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
    print_num(sum(i, 0, 9, a[i])); newline();
end;
begin
    test();
end.

(*<<
45
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc test();
	.text
_test:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #48
@     a[0] := 0;
	mov r0, #0
	str r0, [fp, #-44]
@     a[1] := 1;
	mov r0, #1
	str r0, [fp, #-40]
@     a[2] := 2;
	mov r0, #2
	str r0, [fp, #-36]
@     a[3] := 3;
	mov r0, #3
	str r0, [fp, #-32]
@     a[4] := 4;
	mov r0, #4
	str r0, [fp, #-28]
@     a[5] := 5;
	mov r0, #5
	str r0, [fp, #-24]
@     a[6] := 6;
	mov r0, #6
	str r0, [fp, #-20]
@     a[7] := 7;
	mov r0, #7
	str r0, [fp, #-16]
@     a[8] := 8;
	mov r0, #8
	str r0, [fp, #-12]
@     a[9] := 9;
	mov r0, #9
	str r0, [fp, #-8]
@     print_num(sum(i, 0, 9, a[i])); newline();
	str fp, [sp]
	set r3, __thunk_1
	mov r2, #9
	mov r1, #0
	add r0, fp, #-4
	mov r10, fp
	bl _sum
	bl print_num
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@     proc sum(var i: integer; left, right: integer; => v: integer): integer;
_sum:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@         retval := 0;
	mov r4, #0
@         i := left;
	ldr r0, [fp, #44]
	ldr r1, [fp, #40]
	str r0, [r1]
.L4:
@         while i <= right do
	ldr r0, [fp, #40]
	ldr r0, [r0]
	ldr r1, [fp, #48]
	cmp r0, r1
	bgt .L6
@             retval := retval + v;
	ldr r10, [fp, #56]
	ldr r0, [fp, #52]
	blx r0
	add r4, r4, r0
@             i := i+1;
	ldr r5, [fp, #40]
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	b .L4
.L6:
@         return retval;
	mov r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     test();
	bl _test
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	ldr r4, [fp, #24]
	add r0, r4, #-44
	ldr r1, [r4, #-4]
	lsl r1, r1, #2
	add r0, r0, r1
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ End
]]*)
