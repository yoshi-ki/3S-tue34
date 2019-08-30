type tyvar = int

type ty =
    | TyInt
    | TyBool
    | TyFun of ty * ty
    | TyVar of tyvar

type ty_schema = (tyvar list * ty) 

type subst = (tyvar * ty) list

let count = ref 0

let new_tyvar x = count := (!count) + 1; (!count)

let rec print_type ty =
	match ty with
	| TyInt -> (Printf.printf "%s" "int";)
	| TyBool -> (Printf.printf "%s " "bool";)
	| TyVar(a) -> (Printf.printf "%s" "a";Printf.printf "%d" a;) 
	| TyFun(a, b) -> (print_type a; Printf.printf "%s" "->"; print_type b;)

