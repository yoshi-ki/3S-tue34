type name = string
type value =
| VInt of int
| VBool of bool
| VFun of name * expr * env
| VRecFun of name * name * expr * env | VPair of value * value
| VNil
| VCons of value * value
and env = (name * value) list

type pattern = PInt of int | PBool of bool
             | PVar of name
             | PPair of pattern * pattern
             | PNil | PCons of pattern * pattern

find_match : pattern -> value -> (name * value) list option

exception PatternError

let rec find_match p v =
	match p with
	| PInt a ->
		(match v with
		| VInt b -> if (a = b) then Some [] else None
		| _ -> None)
	| PBool a ->
		(match v with
		| VBool b -> if(a=b) then Some [] else None
		| _ -> None)
	| PVar a -> Some[(a,v)]
	| PPair (a,b) ->
		(match v with
		| VPair (c,d) -> 
			(match (find_match a c) with
			| Some x -> 
				(match (find_match b d) with
				| Some y -> Some (x @ y)
				| None -> None)
  			| None -> None)
		| _ -> None)
	| PNil -> 
		(match v with 
		| VNil -> Some []
		| _ -> None)
	| PCons (a,b) ->
		(match v with
		| VCons (c,d) -> 
			(match (find_match a c) with
            | Some x ->
                (match (find_match b d) with
                | Some y -> Some (x @ y)
                | None -> None)
            | None -> None)
        | _ -> None)

find_match (PPair (PVar ("x") , PInt (1))) (VPair(VInt (2), VInt(3)))
find_match (PInt 1) (VInt 1)
find_match (PVar ("x")) (VInt 1)
find_match (PPair (PVar ("x"), PVar("y"))) (VPair(VInt(1), (VPair( VInt(2), VInt(3)))))


