type name = string

type value = VInt of int | VBool of bool;;

type expr =
  | EConstInt  of int
  | EConstBool of bool
  | EVar       of name
  | EAdd       of expr * expr
  | ESub       of expr * expr
  | EMul       of expr * expr
  | EDiv       of expr * expr
  | EEq        of expr * expr
  | ELt        of expr * expr
  | EIf        of expr * expr * expr

type environment = (name * value) list

exception Eval_error;;


let rec eval_command env x = 
	match x with
	| EVar var -> 
	(let rec lookup e a =
    match e with
    | [] -> raise Eval_error
    | (k,v) :: rest -> if k = a then VInt v else lookup rest a
	in
	lookup env var)
	| EConstInt a -> VInt a
	| EAdd (a,b) ->
        (match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j -> VInt (i + j)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| ESub (a,b) ->
		(match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j -> VInt (i - j)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| EMul (a,b) ->
		(match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j -> VInt (i * j)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| EDiv (a,b) ->
		(match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j -> VInt (i / j)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| EConstBool a -> VBool a
	| EEq (a,b) ->
		(match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j ->
					(if (a = b) then VBool true
					else VBool false)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| ELt (a,b) ->
		(match (eval_command env a) with
            | VInt i ->
            (match (eval_command env b) with
                |VInt j ->
                    (if (a < b) then VBool true
                    else VBool false)
                |VBool j -> raise Eval_error)
            | VBool i -> raise Eval_error)
	| EIf (a,b,c) ->
       	 (match (eval_command env a) with
           	 | VBool i ->
                	(if (i) then (eval_command env b)
            	    else (eval_command env c))
           	 | VInt j -> raise Eval_error);;
