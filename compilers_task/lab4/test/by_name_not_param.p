(* a test to check if functions with call by name parameters used as parameters leads to errors *)

proc f(proc g(=> y:integer):integer):integer;
begin
    return 0;
end;
begin
    println("hello");
    newline()
end.

(*<<
"test/by_name_not_param.p", line 3: Functions that use call by name parameters cannot be parameters
>>*)
(*[[
]]*)
