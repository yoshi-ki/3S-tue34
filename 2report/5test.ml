type value = VInt of int | VBool of bool;;

type expr =
	| EConstInt of int
	| EAdd 		of expr * expr
	| ESub 		of expr * expr
	| EMul		of expr * expr
	| EDiv		of expr * expr
	| EConstBool of bool
	| Eeq		of expr * expr
	| Ethan		of expr * expr
	| Eif		of bool * expr * expr
;;

exception Eval_error;;

let rec eval x =
	match x with
	| EConstInt a -> VInt a
	| EAdd (a,b) ->
        (match (eval a) with
            | VBool i -> raise Eval_error
			| VInt i ->
            (match (eval b) with
                |VInt j -> VInt (i + j)
                |VBool j -> raise Eval_error))
	| ESub (a,b) ->
		match (eval a) with
            | VInt i ->
            match (eval b) with
                |VInt j -> VInt (i - j)
                |VBool j -> raise Eval_error
            | VBool i -> raise Eval_error
		
