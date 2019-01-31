(* lab1/sqrt_2e8.p *)

begin
    v := 200000000;
    left := 0;
    right := 46340; (* i.e. largest # whose square fits on 32 bits *)

    (* Invariant: left <= right and left <= floor(sqrt(v)) < right *)
    while right - left > 1 do
        mid := (left + right) div 2;
        if mid * mid > v then
            right := mid
        else
            left := mid
        end
    end;

    print left ; newline
end.

(*<<
 14142
>>*)
