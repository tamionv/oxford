(* a test designed to make sure that we jump to the end of the correct loop *)

var i, j : integer;
begin
    for i := 1 to 4 do;
        if i mod 3 = 0 then continue end;
        for j := 1 to 4 do;
            if (i + j) mod 2 = 0 then continue end;
            print_num(i);
            print_char(' ');
            print_num(j);
            newline()
        end
    end
end.

(*<<
1 2
1 4
2 1
2 3
4 1
4 3
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
@     for i := 1 to 4 do;
	mov r0, #1
	set r1, _i
	str r0, [r1]
	mov r5, #4
.L3:
	set r0, _i
	ldr r6, [r0]
	cmp r6, r5
	bgt .L2
@         if i mod 3 = 0 then continue end;
	mov r1, #3
	mov r0, r6
	bl int_mod
	cmp r0, #0
	beq .L5
@         for j := 1 to 4 do;
	mov r0, #1
	set r1, _j
	str r0, [r1]
	mov r4, #4
.L9:
	set r6, _j
	ldr r7, [r6]
	cmp r7, r4
	bgt .L5
@             if (i + j) mod 2 = 0 then continue end;
	set r8, _i
	mov r1, #2
	ldr r0, [r8]
	add r0, r0, r7
	bl int_mod
	cmp r0, #0
	beq .L11
@             print_num(i);
	ldr r0, [r8]
	bl print_num
@             print_char(' ');
	mov r0, #32
	bl print_char
@             print_num(j);
	ldr r0, [r6]
	bl print_num
@             newline()
	bl newline
.L11:
	set r6, _j
	ldr r0, [r6]
	add r0, r0, #1
	str r0, [r6]
	b .L9
.L5:
	set r6, _i
	ldr r0, [r6]
	add r0, r0, #1
	str r0, [r6]
	b .L3
.L2:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _i, 4, 4
	.comm _j, 4, 4
@ End
]]*)
