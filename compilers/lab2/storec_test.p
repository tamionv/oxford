var v: array 10 of boolean;
begin
    v[1] := true;
    v[0] := false;
    if v[1] then print 1; newline else print 0; newline; end;
end.
(*<<
 1
>>*)
