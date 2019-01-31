type token =
  | Year of (year)
  | Actor of (actor)
  | Comma

open Parsing;;
let _ = parse_error;;
let yytransl_const = [|
  259 (* Comma *);
    0|]

let yytransl_block = [|
  257 (* Year *);
  258 (* Actor *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\003\000\003\000\000\000"

let yylen = "\002\000\
\000\000\002\000\003\000\001\000\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\004\000\006\000\000\000\000\000\002\000\000\000\
\005\000\003\000"

let yydgoto = "\002\000\
\004\000\005\000\006\000"

let yysindex = "\001\000\
\002\255\000\000\000\000\000\000\002\255\001\255\000\000\255\254\
\000\000\000\000"

let yyrindex = "\000\000\
\005\000\000\000\000\000\000\000\005\000\000\000\000\000\000\000\
\000\000\000\000"

let yygindex = "\000\000\
\002\000\000\000\000\000"

let yytablesize = 7
let yytable = "\009\000\
\010\000\001\000\003\000\008\000\001\000\000\000\007\000"

let yycheck = "\001\001\
\002\001\001\000\001\001\003\001\000\000\255\255\005\000"

let yynames_const = "\
  Comma\000\
  "

let yynames_block = "\
  Year\000\
  Actor\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    Obj.repr(
# 7 "exercise9.mly"
                   ( [ ] )
# 64 "exercise9.ml"
               : (year list * actor) list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'record) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : (year list * actor) list) in
    Obj.repr(
# 8 "exercise9.mly"
                  ( _1 :: _2 )
# 72 "exercise9.ml"
               : (year list * actor) list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'years) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : actor) in
    Obj.repr(
# 10 "exercise9.mly"
                           ( (_1, _3) )
# 80 "exercise9.ml"
               : 'record))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : year) in
    Obj.repr(
# 13 "exercise9.mly"
         ( [_1] )
# 87 "exercise9.ml"
               : 'years))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'years) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : year) in
    Obj.repr(
# 14 "exercise9.mly"
                       ( _1 @ [_3] )
# 95 "exercise9.ml"
               : 'years))
(* Entry file *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let file (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : (year list * actor) list)
