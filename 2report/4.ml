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
	| Eif		of expr * expr * expr
;;
