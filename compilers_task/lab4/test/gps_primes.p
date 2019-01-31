(* Knuth and Merner general problem solver, from ALGOL 60 confidential; original text:
"
real procedure GPS(I, N, Z, V); real I, N, Z, V;
   begin for I := 1 step 1 until N do Z := V; GPS := 1 end;

Method for finding primes with the gps:
I := GPS(I, if I=0 then -1.0 else I, P, if I=1 then 1.0 else
   if GPS(A, I, Z, if A=1 then 1.0 else
      if entier(A)*(entier(I)/entier(A))=entier(I) ^ A<I
      then 0.0 else Z) = Z then
      (if P<m then P+1 else I*GPS(A, 1.0, I, -1.0)) else P)
"
*)
 
proc gps(var i : integer; => n : integer; var z : integer; => v : integer) : integer;
    var limit : integer;
begin
    i := 1;
    while i <= n do
        z := v;
        i := i+1;
    end;
    return 1;
end;

proc f1(var i : integer) : integer;
begin
    if i = 0 then
        return -1;
    else
        return i;
    end;
end;

proc f2(var a, i : integer; var z: integer) : integer;
begin
    if a = 1 then
        return 1;
    else
        if ((a * (i div a) = i) and (a < i)) then
            return 0;
        else
            return z;
        end;
    end;
end;

proc f3(=> p : integer; var a : integer; => m : integer; var i : integer; var z : integer) : integer;
    var tmp_i: integer;
begin
    if i = 1 then
        return 1
    else
        if gps(a, i, z, f2(a, i, z)) = z then
            if p < m then
                return p + 1;
            else 
                (* This temporary is necessary since I can't force the lhs to be evaluated before the rhs *)
                tmp_i := i;
                return tmp_i * gps(a, 1, i, -1)
            end;
        else
            return p;
        end;
    end;
end;

proc find_prime(m : integer) : integer;
    var i, z, p, a : integer;
begin
    i := gps(i, f1(i), p, f3(p, a, m, i, z));
    return p;
end;

var i : integer;
begin
    i := 1;
    while i < 20 do
        print_num(find_prime(i)); newline();
        i := i+1;
    end;
    print_num(find_prime(100)); newline();
end.

(*<<
2
3
5
7
11
13
17
19
23
29
31
37
41
43
47
53
59
61
67
541
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc gps(var i : integer; => n : integer; var z : integer; => v : integer) : integer;
	.text
_gps:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     i := 1;
	mov r0, #1
	ldr r1, [fp, #40]
	str r0, [r1]
.L3:
@     while i <= n do
	ldr r10, [fp, #48]
	ldr r0, [fp, #44]
	blx r0
	ldr r1, [fp, #40]
	ldr r1, [r1]
	cmp r1, r0
	bgt .L5
@         z := v;
	ldr r10, [fp, #60]
	ldr r0, [fp, #56]
	blx r0
	ldr r1, [fp, #52]
	str r0, [r1]
@         i := i+1;
	ldr r5, [fp, #40]
	ldr r0, [r5]
	add r0, r0, #1
	str r0, [r5]
	b .L3
.L5:
@     return 1;
	mov r0, #1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc f1(var i : integer) : integer;
_f1:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     if i = 0 then
	ldr r0, [fp, #40]
	ldr r0, [r0]
	cmp r0, #0
	bne .L8
@         return -1;
	mov r0, #-1
	b .L6
.L8:
@         return i;
	ldr r0, [fp, #40]
	ldr r0, [r0]
.L6:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc f2(var a, i : integer; var z: integer) : integer;
_f2:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     if a = 1 then
	ldr r0, [fp, #40]
	ldr r0, [r0]
	cmp r0, #1
	bne .L12
@         return 1;
	mov r0, #1
	b .L10
.L12:
@         if ((a * (i div a) = i) and (a < i)) then
	ldr r0, [fp, #40]
	ldr r4, [r0]
	mov r1, r4
	ldr r0, [fp, #44]
	ldr r0, [r0]
	bl int_div
	ldr r1, [fp, #44]
	ldr r5, [r1]
	mul r0, r4, r0
	cmp r0, r5
	bne .L15
	ldr r0, [fp, #40]
	ldr r0, [r0]
	cmp r0, r5
	bge .L15
@             return 0;
	mov r0, #0
	b .L10
.L15:
@             return z;
	ldr r0, [fp, #48]
	ldr r0, [r0]
.L10:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc f3(=> p : integer; var a : integer; => m : integer; var i : integer; var z : integer) : integer;
_f3:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #8
@     if i = 1 then
	ldr r0, [fp, #60]
	ldr r0, [r0]
	cmp r0, #1
	bne .L20
@         return 1
	mov r0, #1
	b .L18
.L20:
@         if gps(a, i, z, f2(a, i, z)) = z then
	str fp, [sp, #4]
	set r0, __thunk_4
	str r0, [sp]
	ldr r3, [fp, #64]
	mov r2, fp
	set r1, __thunk_3
	ldr r0, [fp, #48]
	bl _gps
	ldr r1, [fp, #64]
	ldr r1, [r1]
	cmp r0, r1
	bne .L23
@             if p < m then
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	ldr r10, [fp, #56]
	mov r5, r0
	ldr r0, [fp, #52]
	blx r0
	cmp r5, r0
	bge .L26
@                 return p + 1;
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	add r0, r0, #1
	b .L18
.L26:
@                 tmp_i := i;
	ldr r5, [fp, #60]
	ldr r4, [r5]
@                 return tmp_i * gps(a, 1, i, -1)
	str fp, [sp, #4]
	set r0, __thunk_2
	str r0, [sp]
	mov r3, r5
	mov r2, fp
	set r1, __thunk_1
	ldr r0, [fp, #48]
	bl _gps
	mul r0, r4, r0
	b .L18
.L23:
@             return p;
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
.L18:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc find_prime(m : integer) : integer;
_find_prime:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #24
@     i := gps(i, f1(i), p, f3(p, a, m, i, z));
	str fp, [sp, #4]
	set r0, __thunk_6
	str r0, [sp]
	add r3, fp, #-12
	mov r2, fp
	set r1, __thunk_5
	add r0, fp, #-4
	bl _gps
	str r0, [fp, #-4]
@     return p;
	ldr r0, [fp, #-12]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     i := 1;
	mov r0, #1
	set r1, _i
	str r0, [r1]
.L30:
@     while i < 20 do
	set r4, _i
	ldr r5, [r4]
	cmp r5, #20
	bge .L32
@         print_num(find_prime(i)); newline();
	mov r0, r5
	bl _find_prime
	bl print_num
	bl newline
@         i := i+1;
	ldr r0, [r4]
	add r0, r0, #1
	str r0, [r4]
	b .L30
.L32:
@     print_num(find_prime(100)); newline();
	mov r0, #100
	bl _find_prime
	bl print_num
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	mov r0, #1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	mov r0, #-1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_3:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r0, [r0, #60]
	ldr r0, [r0]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_4:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r4, [fp, #24]
	ldr r2, [r4, #64]
	ldr r1, [r4, #60]
	ldr r0, [r4, #48]
	bl _f2
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_5:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	add r0, r0, #-4
	bl _f1
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_6:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #16
	ldr r4, [fp, #24]
	add r0, r4, #-8
	str r0, [sp, #8]
	add r0, r4, #-4
	str r0, [sp, #4]
	str fp, [sp]
	set r3, __thunk_8
	add r2, r4, #-16
	mov r1, fp
	set r0, __thunk_7
	bl _f3
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_7:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r0, [r0, #24]
	ldr r0, [r0, #-12]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_8:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r0, [r0, #24]
	ldr r0, [r0, #40]
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.comm _i, 4, 4
@ End
]]*)
