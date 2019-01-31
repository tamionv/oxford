(* multiple continue statements in a single loop *)

var i : integer;
begin
    for i := 1 to 20 do;
        if i mod 2 = 0 then continue else end;
        if i mod 3 = 0 then continue else end;
        if i mod 5 = 0 then continue else end;
        print_num(i);
        print_char(' ')
    end;
    newline()
end.

(*<<
1 7 11 13 17 19 
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

	.text
pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     for i := 1 to 20 do;
	mov r0, #1
	set r1, _i
	str r0, [r1]
	mov r4, #20
.L3:
	set r5, _i
	ldr r6, [r5]
	cmp r6, r4
	bgt .L4
@         if i mod 2 = 0 then continue else end;
	mov r1, #2
	mov r0, r6
	bl int_mod
	cmp r0, #0
	beq .L5
@         if i mod 3 = 0 then continue else end;
	mov r1, #3
	ldr r0, [r5]
	bl int_mod
	cmp r0, #0
	beq .L5
@         if i mod 5 = 0 then continue else end;
	mov r1, #5
	ldr r0, [r5]
	bl int_mod
	cmp r0, #0
	beq .L5
@         print_num(i);
	ldr r0, [r5]
	bl print_num
@         print_char(' ')
	mov r0, #32
	bl print_char
.L5:
	set r5, _i
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	b .L3
.L4:
@     newline()
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _i, 4, 4
@ End
]]*)
