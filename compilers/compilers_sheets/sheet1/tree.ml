ype ast =
    IntLeaf of int
    | VarLeaf of string
    | UnaryOp of (int -> int) * ast
    | BinaryOp of (int -> int -> int) * ast * ast
    | Let of string * ast * ast

module MySet = Map.Make(String)

let rec eval_ast_in_context x ctxt =
    match x with
    | IntLeaf x -> x
    | UnaryOp (op, y) -> op (eval_ast_in_context y ctxt)
    | BinaryOp (op, y, z)
        -> op (eval_ast_in_context y ctxt) (eval_ast_in_context z ctxt)
    | Let (str, y, z) 
        -> let newctxt = MySet.add str (eval_ast_in_context y ctxt) ctxt
            in eval_ast_in_context z newctxt
    | VarLeaf str -> MySet.find str ctxt

let eval_ast x = eval_ast_in_context x (MySet.empty)
