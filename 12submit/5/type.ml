(* Expressions *)
type exp =
    | TySym of string
	| TyVar of string
	| TyFun of string * (exp list)

(* Predicate *)
type predicate = string * (exp list)

(* Declarations *)
type dec =
    | Clause of exp * (exp list)  
    | Query of (exp list)        
