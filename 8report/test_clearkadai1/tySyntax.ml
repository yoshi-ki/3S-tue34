type tyvar = int

type ty =
    | TyInt
    | TyBool
    | TyFun of ty * ty
    | TyVar of tyvar

type subst = (tyvar * ty) list

let count = ref 0

let new_tyvar x = count := (!count) + 1; (!count)



