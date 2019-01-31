(* lab1/kgen.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

open Tree
open Keiko

let optflag = ref false

(* |gen_expr| -- generate code for an expression *)
let rec gen_expr =
    function
        Constant x ->
            CONST x
    | Variable x ->
            SEQ [LINE x.x_line; LDGW x.x_lab]
    | Monop (w, e1) ->
            SEQ [gen_expr e1; MONOP w]
    | Binop (w, e1, e2) ->
            SEQ [gen_expr e1; gen_expr e2; BINOP w]

            (* |gen_cond| -- generate code for short-circuit condition *)
let rec gen_cond e tlab flab =
    (* Jump to |tlab| if |e| is true and |flab| if it is false *)
    match e with
      Constant x ->
          if x <> 0 then JUMP tlab else JUMP flab
    | Binop ((Eq|Neq|Lt|Gt|Leq|Geq) as w, e1, e2) ->
            SEQ [gen_expr e1; gen_expr e2; JUMPC (w, tlab); JUMP flab]
    | Monop (Not, e1) ->
            gen_cond e1 flab tlab
    | Binop (And, e1, e2) ->
            let lab1 = label () in
            SEQ [gen_cond e1 lab1 flab; LABEL lab1; gen_cond e2 tlab flab]
    | Binop (Or, e1, e2) ->
            let lab1 = label () in
            SEQ [gen_cond e1 tlab lab1; LABEL lab1; gen_cond e2 tlab flab]
    | _ ->
            SEQ [gen_expr e; CONST 0; JUMPC (Neq, tlab); JUMP flab]

            (* |gen_stmt| -- generate code for a statement *)
let rec gen_stmt loop_exit_lab s =
    match s with
      Skip -> NOP
    | Seq stmts -> SEQ (List.map (gen_stmt loop_exit_lab) stmts)
    | Assign (v, e) ->
            SEQ [LINE v.x_line; gen_expr e; STGW v.x_lab]
    | Print e ->
            SEQ [gen_expr e; CONST 0; GLOBAL "lib.print"; PCALL 1]
    | Newline ->
            SEQ [CONST 0; GLOBAL "lib.newline"; PCALL 0]
    | IfStmt (test, thenpt, elsept) ->
            let lab1 = label () and lab2 = label () and lab3 = label () in
            SEQ [gen_cond test lab1 lab2; 
          LABEL lab1; gen_stmt loop_exit_lab thenpt ; JUMP lab3;
          LABEL lab2; gen_stmt loop_exit_lab elsept ; LABEL lab3]
    | WhileStmt (test, body) ->
            let lab1 = label () and lab2 = label () and lab3 = label () in
            SEQ [JUMP lab2; LABEL lab1; gen_stmt loop_exit_lab body ; 
          LABEL lab2; gen_cond test lab1 lab3; LABEL lab3]
    | RepeatStmt (body, test) ->
            let lab1 = label () and lab2 = label () in
            SEQ [ LABEL lab1; gen_stmt loop_exit_lab body  ; gen_cond test lab2 lab1 ; LABEL lab2]
    | ExitStmt -> (match loop_exit_lab with
        Some lab -> JUMP lab
    | None -> failwith "Exit not within a loop")
    | LoopStmt body ->
            let lab1 = label() and lab2 = label() in
            SEQ [ LABEL lab1; gen_stmt (Some lab2) body; JUMP lab1 ; LABEL lab2 ]
    | CaseStmt (switch, cases, default) ->
            let labs =
                List.map (fun x -> label ()) cases in
            let vals_to_labs =
                List.concat
                (List.map (function ((ls, stmt), lab) -> List.map (fun x -> (x, lab)) ls)
                (List.combine cases labs)) in
            let lab_stmt_pairs =
                List.map (function ((ls, stmt), lab) -> (lab, stmt))
                (List.combine cases labs) in
            let def_lab = label() and case_exit_lab = label () in
            let casearms =
                List.map (function (v, l) -> CASEARM (v, l)) vals_to_labs in
            let cases =
                List.map (function (lab, stmt) ->
                    SEQ [ LABEL lab; gen_stmt loop_exit_lab stmt; JUMP case_exit_lab ])
                lab_stmt_pairs in
            SEQ [ gen_expr switch
            ; CASEJUMP (List.length vals_to_labs)
            ; SEQ casearms
            ; JUMP def_lab
            ; SEQ cases
            ; LABEL def_lab
            ; gen_stmt loop_exit_lab default
            ; LABEL case_exit_lab ]

open List

let intersect2 xs ys = filter (fun x -> mem x xs) ys
let intersect (xs :: xss) = fold_right intersect2 xss xs 

(* f takes an expression and returns the variaboes it uses
 * g takes a statement and returns a tuple: the variables it
 * needs to be initialised prior, and the variables it
 * initialises *)
let test_stmt = 
    let rec f = function
        Constant _ -> []
        | Variable x -> [x.x_lab]
        | Monop (_, e) -> f e
        | Binop (_, e1, e2) -> f e1 @ f e2 in
    let rec g = function
        Skip -> ([], [])
        | Seq (x :: xs) ->
            let (usedl, defsl) = g x
            and (usedr, defsr) = g (Seq xs)
            in (usedl @ (filter (fun x -> not (mem x defsl)) usedr), defsl @ defsr)
        | Seq [] -> ([], [])
        | Assign (v, e) -> (f e, [v.x_lab])
        | Print e -> (f e, [])
        | Newline -> ([], [])
        | IfStmt (test, thenpt, elsept) ->
            let used1 = f test
            and (used2, defs2) = g thenpt
            and (used3, defs3) = g elsept
            in (used1 @ used2 @ used3, filter (fun x -> mem x defs2) defs3)
        | WhileStmt (test, body) ->
            let used1 = f test
            and (used2, _) = g body
            in (used1 @ used2, [])
        | RepeatStmt (body, test) ->
            let used1 = f test
            and (used2, defs) = g body
            in (used1 @ used2, defs)
        | ExitStmt -> ([], [])
        | LoopStmt body ->
            let (used, _) = g body
            in (used, [])
        | CaseStmt (switch, cases, default) ->
            let used1 = f switch
            and used2 = concat (map fst (map g (map snd cases)))
            and defs2 = map snd (map g (map snd cases))
            and (used3, defs3) = g default
            in (used1 @ used2 @ used3, intersect (defs3 :: defs2))
    in function x -> length (fst (g x)) == 0


(* |translate| -- generate code for the whole program *)
let translate (Program ss) =
    (* to cleanly deal with the "exit without a loop exits the main function" specification
     * simply wrap the entire program in a loop that ends with an exit:
         * If no exit occurs, then a peephole optimiser will remove this
   * (since it's just a JUMP L ; LABEL L sequence)
   * Otherwise, the peephole optimiser will remove the
   * JUMP L from this sequence, and will keep the label, as required. *)
(* let code = gen_stmt None (LoopStmt(Seq([ss; ExitStmt]))) in *)
let code = gen_stmt None ss in
Keiko.output (if !optflag then Peepopt.optimise code else code)
