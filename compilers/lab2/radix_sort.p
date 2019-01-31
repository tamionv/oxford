var v: array 20 of integer;
var ret: array 20 of integer;
var w: array 100 of integer;
var i, n: integer;
begin
    n := 20;
    v[0] := 23;
    v[1] := 24;
    v[2] := 78;
    v[3] := 31;
    v[4] := 51;
    v[5] := 87;
    v[6] := 11;
    v[7] := 13;
    v[8] := 16;
    v[9] := 21;
    v[10] := 26;
    v[11] := 28;
    v[12] := 32;
    v[13] := 23;
    v[14] := 86;
    v[15] := 11;
    v[16] := 18;
    v[17] := 23;
    v[18] := 25;
    v[19] := 28;
    i := 0;
    while i < 100 do
        w[i] := 0;
        i := i+1;
    end; 
    i := 0;
    while i < n do
        w[v[i]] := w[v[i]] + 1;
        i := i+1;
    end;
    i := 1;
    while i < 100 do
        w[i] := w[i] + w[i-1];
        i := i+1;
    end;
    i := 100 - 1;
    while i > 0 do
        w[i] := w[i-1];
        i := i-1;
    end;
    w[0] := 0;

    i := 0;
    while i < n do
        ret[w[v[i]]] := v[i];
        w[v[i]] := w[v[i]] + 1;
        i := i + 1;
    end;

    i := 0;
    while i < n do
        print ret[i]; newline;
        i := i+1;
    end;
end.

(*<<
 11
 11
 13
 16
 18
 21
 23
 23
 23
 24
 25
 26
 28
 28
 31
 32
 51
 78
 86
 87
>>*)
