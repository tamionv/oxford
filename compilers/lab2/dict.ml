(* lab2/dict.ml *)
(* Copyright (c) 2017 J. M. Spivey *)

(* Environments are implemented using a library module that 
   represents mappings by balanced binary trees. *)

type ident = string

type ptype = 
    Integer 
  | Boolean 
  | Array of int * ptype
  | Void

(* |def| -- definitions in environment *)
type def = 
  { d_tag: ident;               (* Name *)
    d_type: ptype;              (* Type *)
    d_lab: string }             (* Global label *)

module IdMap = Map.Make(struct type t = ident  let compare = compare end)

type environment = Env of def IdMap.t

let can f x = try f x; true with Not_found -> false

(* |define| -- add a definition *)
let define d (Env e) = 
  if can (IdMap.find d.d_tag) e then raise Exit;
  Env (IdMap.add d.d_tag d e)

(* |lookup| -- find definition of an identifier *)
let lookup x (Env e) = IdMap.find x e

(* |init_env| -- empty environment *)
let init_env = Env IdMap.empty

let rec type_size = function
    Integer -> 4
    | Boolean -> 1
    | Array (x, t) -> x * type_size t
    | Void -> failwith "Error: Void type has no size"

let array_size = function
    Array(x, t) -> x
    | _ -> failwith "Only arrays have an array_size"

let is_array = function
    Array _ -> true
    | _ -> false

let base_type = function
    Array (_, t) -> t
    | _ -> failwith "Error: non-array has no base type"
