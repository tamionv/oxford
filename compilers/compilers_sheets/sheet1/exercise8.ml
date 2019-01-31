open Tree

let () = 
    let lexbuf = Lexing.from_channel stdin in
    let curr_ast = Exercise8_parser.expr Exercise8_lexer.token lexbuf in
    print_int (eval_ast curr_ast)
