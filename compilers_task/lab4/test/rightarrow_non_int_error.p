(* a test to check that only integers can be call by name parameters *)

type arr = array 10 of integer;

proc f(=> x : arr) : integer;
begin
    return x[2];
end;
var x : arr;
begin
    x[2] := 1;
    print_num(f(x));
    newline()
end.

(*<<
"test/rightarrow_non_int_error.p", line 5: Call by name parameter must be an integer
>>*)
(*[[
]]*)
