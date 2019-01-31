rule token = 
    parse
        '/''*'([^'*']|['\r''\n']|('*'*([^'/' '*']|['\r' '\n'])))*'*'+'/' { token lexbuf }
        | _ as lxm { print_char lxm ; token lexbuf }
        | eof {}

{ let () = token (Lexing.from_channel stdin) }

