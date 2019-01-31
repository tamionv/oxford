type token =
  | Year of (year)
  | Actor of (actor)
  | Comma

val file :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (year list * actor) list
