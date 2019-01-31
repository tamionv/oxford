{
    open Exercise8_parser
}

rule token = parse
    "let" { LET }
    | '+' { BINOP(fun x y -> x + y) }
    | '-' { BINOP(fun x y -> x - y) }
    | '*' { BINOP(fun x y -> x * y) }
    | '/' { BINOP(fun x y -> x / y) }
    | '~' { UNOP(fun x -> -x) }
    | ['0'-'9']+ as lxm { INT(int_of_string lxm) }
    | (['a'-'z']|['A'-'Z'])+ as lxm { VAR(lxm) }
    | _ { token lexbuf }
