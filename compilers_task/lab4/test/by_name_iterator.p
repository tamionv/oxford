(* This tests an "iterator-like" construct that can be made using call by name *)

(* This will continuously print iterator, until done is non-zero *)
proc print(=> iterator, done: integer);
begin
    while done = 0 do
        print_num(iterator);
        newline()
    end;
end;

(* An example that uses arrays *)
proc array_iterator(a: array 20 of integer; var i: integer):integer ;
    var ret: integer;
begin
    ret := a[i];
    i := i+1;
    return ret
end;

proc array_done(n: integer; i: integer): integer;
begin
    if i >= n then
        return 1
    else
        return 0
    end;
end;

proc do_array_test();
    var arr: array 20 of integer;
    var i: integer;
begin
    i := 0;
    while i < 20 do
        arr[i] := i;
        i := i+1
    end;
    i := 0;
    print(array_iterator(arr, i), array_done(20, i))
end;

(* An example that uses linked lists *)
type
    list_ptr = pointer to list;
    list = record data: integer; next: list_ptr end;

proc list_iterator(var p: list_ptr): integer;
    var ret: integer;
begin
    ret := p^.data;
    p := p^.next;
    return ret
end;

proc list_done(p: list_ptr): integer;
begin
    if p = nil then
        return 1
    else
        return 0
    end;
end;

proc do_list_test();
    var i: integer;
    var p: list_ptr;
    var q: list_ptr;
begin
    i := 0;
    p := nil;

    while i < 20 do
        q := p;
        new(p);
        p^.next := q;
        p^.data := i;
        i := i+1
    end;

    q := p;
    print(list_iterator(q), list_done(q));
end;

begin
    do_list_test();
    do_array_test()

end.
(*<<
19
18
17
16
15
14
13
12
11
10
9
8
7
6
5
4
3
2
1
0
0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc print(=> iterator, done: integer);
	.text
_print:
	mov ip, sp
	stmfd sp!, {r0-r3}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
.L3:
@     while done = 0 do
	ldr r10, [fp, #52]
	ldr r0, [fp, #48]
	blx r0
	cmp r0, #0
	bne .L5
@         print_num(iterator);
	ldr r10, [fp, #44]
	ldr r0, [fp, #40]
	blx r0
	bl print_num
@         newline()
	bl newline
	b .L3
.L5:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc array_iterator(a: array 20 of integer; var i: integer):integer ;
_array_iterator:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     ret := a[i];
	ldr r5, [fp, #44]
	ldr r6, [r5]
	ldr r0, [fp, #40]
	lsl r1, r6, #2
	add r0, r0, r1
	ldr r4, [r0]
@     i := i+1;
	add r0, r6, #1
	str r0, [r5]
@     return ret
	mov r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc array_done(n: integer; i: integer): integer;
_array_done:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     if i >= n then
	ldr r0, [fp, #44]
	ldr r1, [fp, #40]
	cmp r0, r1
	blt .L9
@         return 1
	mov r0, #1
	b .L7
.L9:
@         return 0
	mov r0, #0
.L7:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc do_array_test();
_do_array_test:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #88
@     i := 0;
	mov r0, #0
	str r0, [fp, #-84]
.L12:
@     while i < 20 do
	ldr r4, [fp, #-84]
	cmp r4, #20
	bge .L14
@         arr[i] := i;
	add r0, fp, #-80
	lsl r1, r4, #2
	add r0, r0, r1
	str r4, [r0]
@         i := i+1
	ldr r0, [fp, #-84]
	add r0, r0, #1
	str r0, [fp, #-84]
	b .L12
.L14:
@     i := 0;
	mov r0, #0
	str r0, [fp, #-84]
@     print(array_iterator(arr, i), array_done(20, i))
	mov r3, fp
	set r2, __thunk_2
	mov r1, fp
	set r0, __thunk_1
	bl _print
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc list_iterator(var p: list_ptr): integer;
_list_iterator:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     ret := p^.data;
	ldr r5, [fp, #40]
	ldr r6, [r5]
	ldr r4, [r6]
@     p := p^.next;
	ldr r0, [r6, #4]
	str r0, [r5]
@     return ret
	mov r0, r4
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc list_done(p: list_ptr): integer;
_list_done:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     if p = nil then
	ldr r0, [fp, #40]
	cmp r0, #0
	bne .L18
@         return 1
	mov r0, #1
	b .L16
.L18:
@         return 0
	mov r0, #0
.L16:
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc do_list_test();
_do_list_test:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	sub sp, sp, #8
@     i := 0;
	mov r4, #0
@     p := nil;
	mov r5, #0
.L21:
@     while i < 20 do
	cmp r4, #20
	bge .L23
@         q := p;
	str r5, [fp, #-4]
@         new(p);
	mov r0, #8
	bl new
	mov r5, r0
@         p^.next := q;
	ldr r0, [fp, #-4]
	str r0, [r5, #4]
@         p^.data := i;
	str r4, [r5]
@         i := i+1
	add r4, r4, #1
	b .L21
.L23:
@     q := p;
	str r5, [fp, #-4]
@     print(list_iterator(q), list_done(q));
	mov r3, fp
	set r2, __thunk_4
	mov r1, fp
	set r0, __thunk_3
	bl _print
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@     do_list_test();
	bl _do_list_test
@     do_array_test()
	bl _do_array_test
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_1:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ 
	ldr r4, [fp, #24]
	add r1, r4, #-84
	add r0, r4, #-80
	bl _array_iterator
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_2:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r1, [r0, #-84]
	mov r0, #20
	bl _array_done
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_3:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	add r0, r0, #-4
	bl _list_iterator
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

__thunk_4:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
	ldr r0, [fp, #24]
	ldr r0, [r0, #-4]
	bl _list_done
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ End
]]*)
