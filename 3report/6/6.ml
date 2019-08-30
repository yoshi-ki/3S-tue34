module type EQ = 
sig
	type ('a, 'b) equal
	val refl : ('a, 'a) equal
	val symm : ('a, 'b) equal -> ('b, 'a) equal
	val trans : ('a, 'b) equal -> ('b, 'c) equal -> ('a, 'c) equal
	val apply : ('a, 'b) equal -> 'a -> 'b
end


module Eq =
struct
	type ('a, 'b) equal = ('a -> 'b) * ('b -> 'a)
	let refl : ('a, 'a) equal = ((fun x -> x),(fun x -> x))
	let symm : ('a, 'b) equal -> ('b, 'a) equal = (fun x -> (snd (x), fst (x)))
	let trans : ('a, 'b) equal -> ('b, 'c) equal -> ('a, 'c) equal = (fun x y ->(fun z ->  fst (y) (fst(x) z)), (fun z -> snd(x) (snd(y) z)))
	let apply : ('a, 'b) equal -> 'a -> 'b = (fun x y -> fst(x) y) 
end

type 'a value =
	| VBool of (bool, 'a) Eq.equal * bool
	| VInt of (int, 'a) Eq.equal * int
type 'a expr =
	| EConstInt of (int, 'a) Eq.equal * int
	| EConstBool of (bool, 'a) Eq.equal * bool
	| EAdd of (int, 'a) Eq.equal * int expr * int expr
	| EIf of bool expr * 'a expr * 'a expr
	| EEq of (bool, 'a) Eq.equal * int expr * int expr

exception Eval_Error

let rec eval : 'a. 'a expr -> 'a value =
	fun x ->
	match x with
	| EConstInt (a, b) -> VInt(a, b)
	| EConstBool (a,b) -> VBool(a,b)
	| EAdd (a, b, c) -> 
		(match (eval b) with
		| VBool (x,y) -> raise Eval_Error 
		| VInt (x,y) -> 
			(match (eval c) with
			| VBool (s,t) -> raise Eval_Error
			| VInt (s,t) -> VInt(a,(y+t))))	
	| EIf (a, b, c) -> 
		(match (eval a) with 
		| VInt (x,y) -> raise Eval_Error
		| VBool (x,y) -> if y then eval b else eval c)
	| EEq (a, b, c) ->
		(match (eval b) with
		| VBool (x,y) -> raise Eval_Error
		| VInt (x,y) -> 
			(match (eval c) with
			| VBool (s,t) -> raise Eval_Error
			| VInt (s,t) -> VBool(a,(y=t))));;



