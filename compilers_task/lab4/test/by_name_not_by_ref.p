(* a test to check that call by name parameters are not passed by reference *)

proc f(var x : integer):integer;
begin
    x := 1;
end;
proc g(=> x : integer):integer;
begin
    f(x)
end;
begin
    g(2);
    newline()
end.

(*<<
"test/by_name_not_by_ref.p", line 9: x is a call by name parameter, and has no address
>>*)
(*[[
]]*)
