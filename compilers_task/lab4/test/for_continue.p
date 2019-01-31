(* A continue statement inside a for loop *)

var i : integer;
begin
    for i := 0 to 100 do
        if i mod 2 = 0 then continue end;
        print_num(i);
        print_char(' ')
    end;
    newline()
end.

(*<<
1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91 93 95 97 99 
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
@     for i := 0 to 100 do
	mov r0, #0
	set r1, _i
	str r0, [r1]
	mov r4, #100
.L3:
	set r5, _i
	ldr r6, [r5]
	cmp r6, r4
	bgt .L4
@         if i mod 2 = 0 then continue end;
	mov r1, #2
	mov r0, r6
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
