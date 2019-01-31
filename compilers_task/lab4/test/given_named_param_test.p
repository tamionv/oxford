(* The test given in the task description for named parameters *)
var g: integer;
proc println (x:integer);
begin
    print_num(x);
    newline()
end;
proc p (=> x:integer): integer;
begin
    g := g+1;
    return x+x
end;
begin
    g := 0;
    (* evaluates 2+3 twice and prints out 10 *)
    println(p(2+3));
    (* g=1 at this point *)
    (* when p needs the value of g, it will be equal to 2, so p will return 4 *)
    println(p(g));
    (* g=2 at this point *)
    (* 28 will be printed out *)
    println(p(p(7)));
    (* g=5 at this point *)
    println(g)
end.

(*<<
10
4
28
5
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc println (x:integer);
	.text
_println:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     print_num(x);
	ldr r0, [fp, #40]
	bl print_num
@     newline()
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc p (=> x:integer): integer;
_p:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     g := g+1;
	set r4, _g
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
@     return x+x
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	ldr r10, [fp, #44]
	mov r4, r0
	ldr r0, [fp, #40]
	blx r0
	add r0, r4, r0
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     g := 0;
	set r4, _g
	mov r0, #0
	str r0, [r4]
@     println(p(2+3));
	mov r1, fp
	set r0, __thunk_1
	bl _p
	bl _println
@     println(p(g));
	mov r1, fp
	set r0, __thunk_2
	bl _p
	bl _println
@     println(p(p(7)));
	mov r1, fp
	set r0, __thunk_3
	bl _p
	bl _println
@     println(g)
	ldr r0, [r4]
	bl _println
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	mov r0, #5
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	set r0, _g
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_3:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	mov r1, fp
	set r0, __thunk_4
	bl _p
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_4:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	mov r0, #7
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _g, 4, 4
@ End
]]*)
