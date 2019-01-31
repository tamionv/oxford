(* This parser step essentially erases comments *)

{ let open_comment_count = ref 0 }

rule token =
    parse
        "(*" { open_comment_count := !open_comment_count + 1 ; token lexbuf }
        | "*)" { open_comment_count := !open_comment_count - 1 ; token lexbuf }
        | _ as lxm { if !open_comment_count == 0 then print_char lxm else print_string ""; token lexbuf }
        | eof { }

{ let () = token (Lexing.from_channel stdin) }
