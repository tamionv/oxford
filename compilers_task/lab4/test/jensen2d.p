(* Jensen's device, 2d application, using local variables*)

proc test();
    var i, j: integer;

    var a: array 10 of array 10 of integer;

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
    i := 0;
    while i < 10 do
        j := 0;
        while j < 10 do
            a[i][j] := i * j;
            j := j + 1;
        end;
        i := i+1;
    end;

    print_num(sum(i, 0, 9, sum(j, 0, 9, a[i][j]))); newline();
end;
begin
    test();
end.

(*<<
2025
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
	sub sp, sp, #416
@     i := 0;
	mov r0, #0
	str r0, [fp, #-4]
.L3:
@     while i < 10 do
	ldr r0, [fp, #-4]
	cmp r0, #10
	bge .L5
@         j := 0;
	mov r0, #0
	str r0, [fp, #-8]
.L6:
@         while j < 10 do
	ldr r4, [fp, #-8]
	cmp r4, #10
	bge .L8
@             a[i][j] := i * j;
	ldr r5, [fp, #-4]
	mul r0, r5, r4
	add r1, fp, #-408
	mov r2, #40
	mul r2, r5, r2
	add r1, r1, r2
	lsl r2, r4, #2
	add r1, r1, r2
	str r0, [r1]
@             j := j + 1;
	ldr r0, [fp, #-8]
	add r0, r0, #1
	str r0, [fp, #-8]
	b .L6
.L8:
@         i := i+1;
	ldr r0, [fp, #-4]
	add r0, r0, #1
	str r0, [fp, #-4]
	b .L3
.L5:
@     print_num(sum(i, 0, 9, sum(j, 0, 9, a[i][j]))); newline();
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
.L10:
@         while i <= right do
	ldr r0, [fp, #40]
	ldr r0, [r0]
	ldr r1, [fp, #48]
	cmp r0, r1
	bgt .L12
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
	b .L10
.L12:
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
	sub sp, sp, #8
@ 
	ldr r4, [fp, #24]
	str fp, [sp]
	set r3, __thunk_2
	mov r2, #9
	mov r1, #0
	add r0, r4, #-8
	mov r10, r4
	bl _sum
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r4, [r0, #24]
	add r0, r4, #-408
	ldr r1, [r4, #-4]
	mov r2, #40
	mul r1, r1, r2
	add r0, r0, r1
	ldr r1, [r4, #-8]
	lsl r1, r1, #2
	add r0, r0, r1
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ End
]]*)
