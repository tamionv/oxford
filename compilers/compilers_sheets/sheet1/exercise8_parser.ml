type token =
  | INT of (int)
  | VAR of (string)
  | BINOP of (int -> int -> int)
  | UNOP of (int -> int)
  | LET

open Parsing;;
let _ = parse_error;;
# 2 "exercise8_parser.mly"
open Tree
# 13 "exercise8_parser.ml"
let yytransl_const = [|
  261 (* LET *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* VAR *);
  259 (* BINOP *);
  260 (* UNOP *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\003\000\004\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\001\000\002\000\000\000\000\000\000\000\006\000\
\000\000\003\000\000\000\004\000\000\000\005\000"

let yydgoto = "\002\000\
\008\000"

let yysindex = "\001\000\
\008\255\000\000\000\000\000\000\008\255\008\255\001\255\000\000\
\008\255\000\000\008\255\000\000\008\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\251\255"

let yytablesize = 13
let yytable = "\009\000\
\010\000\001\000\011\000\012\000\000\000\013\000\000\000\014\000\
\003\000\004\000\005\000\006\000\007\000"

let yycheck = "\005\000\
\006\000\001\000\002\001\009\000\255\255\011\000\255\255\013\000\
\001\001\002\001\003\001\004\001\005\001"

let yynames_const = "\
  LET\000\
  "

let yynames_block = "\
  INT\000\
  VAR\000\
  BINOP\000\
  UNOP\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 16 "exercise8_parser.mly"
        ( IntLeaf _1 )
# 76 "exercise8_parser.ml"
               : Tree.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 17 "exercise8_parser.mly"
          ( VarLeaf _1 )
# 83 "exercise8_parser.ml"
               : Tree.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : int -> int) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : Tree.ast) in
    Obj.repr(
# 18 "exercise8_parser.mly"
                ( UnaryOp (_1, _2) )
# 91 "exercise8_parser.ml"
               : Tree.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : int -> int -> int) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Tree.ast) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : Tree.ast) in
    Obj.repr(
# 19 "exercise8_parser.mly"
                      ( BinaryOp (_1, _2, _3) )
# 100 "exercise8_parser.ml"
               : Tree.ast))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : Tree.ast) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : Tree.ast) in
    Obj.repr(
# 20 "exercise8_parser.mly"
                        ( Let (_2, _3, _4) )
# 109 "exercise8_parser.ml"
               : Tree.ast))
(* Entry expr *)
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
let expr (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Tree.ast)
