var a : array 10 of integer;
var i : integer;
begin
    i := 0;
    while true do
        a[i] := 0;
        i := i+1;
    end;
end.

(*<<
Runtime error: array bound error in module Main
In procedure MAIN
>>*)
