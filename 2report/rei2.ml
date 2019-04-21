type iexpr =
	| EConstInt of int
	| EAdd      of iexpr * iexpr
	| ESub		of iexpr * iexpr
	| EMul		of iexpr * iexpr
;;

let rec eval x = 
	match x with
	| EConstInt a -> a
	| EAdd (a, b) -> (eval a) + (eval b)
	| ESub (a, b) -> (eval a) - (eval b)
	| EMul (a, b) -> (eval a) * (eval b)
;;
