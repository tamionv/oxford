type list = pointer to cell;
  cell = record head: char; tail: list end;

proc reverse(a: list): list;
  var p, q, r: list;
begin
  p := a; q := nil;
  while p <> nil do
    r := p^.tail; p^.tail := q;
    q := p; p := r
  end;
  return q
end;

proc test();
  const mike = "mike";

  var i: integer; p, q: list;
begin
  p := nil; i := 0; 
  while mike[i] <> chr(0) do
    new(q);
    q^.head := mike[i];
    q^.tail := p;
    p := q; i := i+1
  end;

  p := reverse(p);

  q := p;
  while q <> nil do
    print_char(q^.head);
    q := q^.tail
  end;
  newline()
end;

begin test() end.

(*<<
mike
>>*)
(*[[
@ picoPascal compiler output
	.include "fixup.s"
	.global pmain

@ proc reverse(a: list): list;
	.text
_reverse:
	mov ip, sp
	stmfd sp!, {r0-r1}
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@   p := a; q := nil;
	ldr r4, [fp, #40]
	mov r5, #0
.L4:
@   while p <> nil do
	cmp r4, #0
	beq .L6
@     r := p^.tail; p^.tail := q;
	add r7, r4, #4
	ldr r6, [r7]
	str r5, [r7]
@     q := p; p := r
	mov r5, r4
	mov r4, r6
	b .L4
.L6:
@   return q
	mov r0, r5
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

@ proc test();
_test:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@   p := nil; i := 0; 
	mov r5, #0
	mov r4, #0
.L8:
@   while mike[i] <> chr(0) do
	set r7, g2
	add r0, r7, r4
	ldrb r0, [r0]
	cmp r0, #0
	beq .L10
@     new(q);
	mov r0, #8
	bl new
	mov r6, r0
@     q^.head := mike[i];
	add r0, r7, r4
	ldrb r0, [r0]
	strb r0, [r6]
@     q^.tail := p;
	str r5, [r6, #4]
@     p := q; i := i+1
	mov r5, r6
	add r4, r4, #1
	b .L8
.L10:
@   p := reverse(p);
	mov r0, r5
	bl _reverse
	mov r5, r0
@   q := p;
	mov r6, r5
.L11:
@   while q <> nil do
	cmp r6, #0
	beq .L13
@     print_char(q^.head);
	ldrb r0, [r6]
	bl print_char
@     q := q^.tail
	ldr r6, [r6, #4]
	b .L11
.L13:
@   newline()
	bl newline
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

pmain:
	mov ip, sp
	stmfd sp!, {r4-r10, fp, ip, lr}
	mov fp, sp
@ begin test() end.
	bl _test
	ldmfd fp, {r4-r10, fp, sp, pc}
	.ltorg

	.data
g2:
	.byte 109, 105, 107, 101
	.byte 0
@ End
]]*)
