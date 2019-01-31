(* a test to check that call by name parameters are not assigned to *)

proc f(=>x : integer):integer;
begin
    x := 1;
end;
begin
    f(2);
    newline()
end.

(*<<
"test/by_name_not_assigned.p", line 5: x is a call by name parameter, and has no address
>>*)
(*[[
]]*)
