type token =
  | INT of (int)
  | VAR of (string)
  | BINOP of (int -> int -> int)
  | UNOP of (int -> int)
  | LET

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Tree.ast
