type token =
  | IDENT of (Tree.ident)
  | MONOP of (Keiko.op)
  | MULOP of (Keiko.op)
  | ADDOP of (Keiko.op)
  | RELOP of (Keiko.op)
  | NUMBER of (int)
  | SEMI
  | DOT
  | COLON
  | LPAR
  | RPAR
  | COMMA
  | MINUS
  | VBAR
  | ASSIGN
  | EOF
  | BADTOK
  | BEGIN
  | DO
  | ELSE
  | ELSEIF
  | END
  | IF
  | THEN
  | WHILE
  | PRINT
  | NEWLINE

open Parsing;;
let _ = parse_error;;
# 4 "exercise6.mly"
 
open Keiko
open Tree
# 37 "exercise6.ml"
let yytransl_const = [|
  263 (* SEMI *);
  264 (* DOT *);
  265 (* COLON *);
  266 (* LPAR *);
  267 (* RPAR *);
  268 (* COMMA *);
  269 (* MINUS *);
  270 (* VBAR *);
  271 (* ASSIGN *);
    0 (* EOF *);
  272 (* BADTOK *);
  273 (* BEGIN *);
  274 (* DO *);
  275 (* ELSE *);
  276 (* ELSEIF *);
  277 (* END *);
  278 (* IF *);
  279 (* THEN *);
  280 (* WHILE *);
  281 (* PRINT *);
  282 (* NEWLINE *);
    0|]

let yytransl_block = [|
  257 (* IDENT *);
  258 (* MONOP *);
  259 (* MULOP *);
  260 (* ADDOP *);
  261 (* RELOP *);
  262 (* NUMBER *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\003\000\003\000\004\000\004\000\004\000\004\000\
\004\000\004\000\007\000\007\000\007\000\006\000\006\000\008\000\
\008\000\008\000\009\000\009\000\010\000\010\000\010\000\010\000\
\010\000\005\000\000\000"

let yylen = "\002\000\
\004\000\001\000\001\000\003\000\000\000\003\000\002\000\001\000\
\005\000\005\000\005\000\003\000\001\000\001\000\003\000\001\000\
\003\000\003\000\001\000\003\000\001\000\001\000\002\000\002\000\
\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\027\000\026\000\000\000\000\000\000\000\
\008\000\000\000\002\000\000\000\000\000\000\000\022\000\000\000\
\000\000\021\000\000\000\000\000\000\000\019\000\000\000\000\000\
\000\000\000\000\000\000\023\000\000\000\024\000\000\000\000\000\
\000\000\000\000\000\000\000\000\001\000\004\000\000\000\025\000\
\000\000\000\000\000\000\000\000\020\000\000\000\000\000\000\000\
\013\000\009\000\010\000\000\000\000\000\012\000\000\000\000\000\
\011\000"

let yydgoto = "\002\000\
\004\000\010\000\011\000\012\000\018\000\019\000\050\000\020\000\
\021\000\022\000"

let yysindex = "\007\000\
\251\254\000\000\002\255\000\000\000\000\133\255\133\255\133\255\
\000\000\015\255\000\000\039\255\033\255\133\255\000\000\133\255\
\133\255\000\000\009\255\049\255\047\255\000\000\046\255\060\255\
\058\255\002\255\133\255\000\000\004\255\000\000\133\255\002\255\
\133\255\133\255\133\255\002\255\000\000\000\000\060\255\000\000\
\049\255\065\255\047\255\047\255\000\000\052\255\002\255\133\255\
\000\000\000\000\000\000\057\255\012\255\000\000\002\255\065\255\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\024\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\071\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\093\255\036\255\000\000\000\000\255\254\
\000\000\018\255\000\000\000\000\000\000\000\000\000\000\018\255\
\000\000\000\000\000\000\024\255\000\000\000\000\051\255\000\000\
\110\255\000\000\056\255\076\255\000\000\000\000\024\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\018\255\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\231\255\042\000\000\000\253\255\250\255\026\000\057\000\
\227\255\255\255"

let yytablesize = 146
let yytable = "\013\000\
\023\000\024\000\005\000\043\000\044\000\007\000\042\000\001\000\
\031\000\029\000\046\000\003\000\028\000\031\000\040\000\030\000\
\031\000\007\000\007\000\007\000\039\000\052\000\013\000\006\000\
\005\000\007\000\008\000\009\000\013\000\056\000\005\000\032\000\
\013\000\045\000\055\000\025\000\005\000\005\000\005\000\016\000\
\016\000\053\000\016\000\013\000\005\000\026\000\016\000\027\000\
\016\000\035\000\031\000\013\000\033\000\016\000\016\000\016\000\
\016\000\006\000\016\000\017\000\017\000\034\000\017\000\036\000\
\031\000\037\000\017\000\038\000\017\000\006\000\006\000\006\000\
\051\000\017\000\017\000\017\000\017\000\054\000\017\000\018\000\
\018\000\057\000\018\000\047\000\048\000\049\000\018\000\041\000\
\018\000\003\000\003\000\003\000\000\000\018\000\018\000\018\000\
\018\000\014\000\018\000\014\000\000\000\000\000\000\000\014\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\000\014\000\
\014\000\014\000\015\000\014\000\015\000\000\000\000\000\000\000\
\015\000\000\000\000\000\000\000\000\000\000\000\000\000\015\000\
\015\000\015\000\015\000\000\000\015\000\005\000\014\000\000\000\
\000\000\000\000\015\000\000\000\000\000\000\000\016\000\000\000\
\000\000\017\000"

let yycheck = "\003\000\
\007\000\008\000\001\001\033\000\034\000\007\001\032\000\001\000\
\005\001\016\000\036\000\017\001\014\000\005\001\011\001\017\000\
\005\001\019\001\020\001\021\001\027\000\047\000\026\000\022\001\
\007\001\024\001\025\001\026\001\032\000\055\000\007\001\023\001\
\036\000\035\000\023\001\021\001\019\001\020\001\021\001\004\001\
\005\001\048\000\007\001\047\000\021\001\007\001\011\001\015\001\
\013\001\003\001\005\001\055\000\004\001\018\001\019\001\020\001\
\021\001\007\001\023\001\004\001\005\001\013\001\007\001\018\001\
\005\001\008\001\011\001\026\000\013\001\019\001\020\001\021\001\
\021\001\018\001\019\001\020\001\021\001\021\001\023\001\004\001\
\005\001\056\000\007\001\019\001\020\001\021\001\011\001\031\000\
\013\001\019\001\020\001\021\001\255\255\018\001\019\001\020\001\
\021\001\005\001\023\001\007\001\255\255\255\255\255\255\011\001\
\255\255\255\255\255\255\255\255\255\255\255\255\018\001\019\001\
\020\001\021\001\005\001\023\001\007\001\255\255\255\255\255\255\
\011\001\255\255\255\255\255\255\255\255\255\255\255\255\018\001\
\019\001\020\001\021\001\255\255\023\001\001\001\002\001\255\255\
\255\255\255\255\006\001\255\255\255\255\255\255\010\001\255\255\
\255\255\013\001"

let yynames_const = "\
  SEMI\000\
  DOT\000\
  COLON\000\
  LPAR\000\
  RPAR\000\
  COMMA\000\
  MINUS\000\
  VBAR\000\
  ASSIGN\000\
  EOF\000\
  BADTOK\000\
  BEGIN\000\
  DO\000\
  ELSE\000\
  ELSEIF\000\
  END\000\
  IF\000\
  THEN\000\
  WHILE\000\
  PRINT\000\
  NEWLINE\000\
  "

let yynames_block = "\
  IDENT\000\
  MONOP\000\
  MULOP\000\
  ADDOP\000\
  RELOP\000\
  NUMBER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'stmts) in
    Obj.repr(
# 25 "exercise6.mly"
                                        ( Program _2 )
# 204 "exercise6.ml"
               : Tree.program))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmt_list) in
    Obj.repr(
# 28 "exercise6.mly"
                                        ( seq _1 )
# 211 "exercise6.ml"
               : 'stmts))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'stmt) in
    Obj.repr(
# 31 "exercise6.mly"
                                        ( [_1] )
# 218 "exercise6.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'stmt) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'stmt_list) in
    Obj.repr(
# 32 "exercise6.mly"
                                        ( _1 :: _3 )
# 226 "exercise6.ml"
               : 'stmt_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 35 "exercise6.mly"
                                        ( Skip )
# 232 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'name) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "exercise6.mly"
                                        ( Assign (_1, _3) )
# 240 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 37 "exercise6.mly"
                                        ( Print _2 )
# 247 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    Obj.repr(
# 38 "exercise6.mly"
                                        ( Newline )
# 253 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'stmts) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'elseif_list) in
    Obj.repr(
# 41 "exercise6.mly"
                                        ( IfStmt (_2, _4, _5) )
# 262 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'stmts) in
    Obj.repr(
# 42 "exercise6.mly"
                                        ( WhileStmt (_2, _4) )
# 270 "exercise6.ml"
               : 'stmt))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'stmts) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'elseif_list) in
    Obj.repr(
# 45 "exercise6.mly"
                                       ( IfStmt (_2, _4, _5) )
# 279 "exercise6.ml"
               : 'elseif_list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'stmts) in
    Obj.repr(
# 46 "exercise6.mly"
                     ( stmts )
# 286 "exercise6.ml"
               : 'elseif_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "exercise6.mly"
          ( Skip )
# 292 "exercise6.ml"
               : 'elseif_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'simple) in
    Obj.repr(
# 50 "exercise6.mly"
                                        ( _1 )
# 299 "exercise6.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Keiko.op) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'simple) in
    Obj.repr(
# 51 "exercise6.mly"
                                        ( Binop (_2, _1, _3) )
# 308 "exercise6.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 54 "exercise6.mly"
                                        ( _1 )
# 315 "exercise6.ml"
               : 'simple))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'simple) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Keiko.op) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 55 "exercise6.mly"
                                        ( Binop (_2, _1, _3) )
# 324 "exercise6.ml"
               : 'simple))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'simple) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'term) in
    Obj.repr(
# 56 "exercise6.mly"
                                        ( Binop (Minus, _1, _3) )
# 332 "exercise6.ml"
               : 'simple))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 59 "exercise6.mly"
                                        ( _1 )
# 339 "exercise6.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'term) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : Keiko.op) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 60 "exercise6.mly"
                                        ( Binop (_2, _1, _3) )
# 348 "exercise6.ml"
               : 'term))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'name) in
    Obj.repr(
# 63 "exercise6.mly"
                                        ( Variable _1 )
# 355 "exercise6.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 64 "exercise6.mly"
                                        ( Constant _1 )
# 362 "exercise6.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : Keiko.op) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 65 "exercise6.mly"
                                        ( Monop (_1, _2) )
# 370 "exercise6.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'factor) in
    Obj.repr(
# 66 "exercise6.mly"
                                        ( Monop (Uminus, _2) )
# 377 "exercise6.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 67 "exercise6.mly"
                                        ( _2 )
# 384 "exercise6.ml"
               : 'factor))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : Tree.ident) in
    Obj.repr(
# 70 "exercise6.mly"
                                        ( make_name _1 !Lexer.lineno )
# 391 "exercise6.ml"
               : 'name))
(* Entry program *)
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
let program (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Tree.program)
