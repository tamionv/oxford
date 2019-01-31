rule comment =
    parse 
        "*)" {}
        | "(*" { comment lexbuf ; comment lexbuf }
        | _ { comment lexbuf }
and token =
    parse
        "(*" { comment lexbuf ; token lexbuf }
        | _ as lxm { print_char lxm ; token lexbuf }
        | eof { }

{ let () = token (Lexing.from_channel stdin) }
