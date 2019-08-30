type tyvar = int

type ty =
	| TyInt
	| TyBool
	| TyFun of ty * ty
	| TyVar of tyvar

type subst = (tyvar * ty) list

let count = ref 0

let new_tyvar x = count := (!count) + 1; TyVar(!count)

let rec print_type ty =
    match ty with
    | TyInt -> (Printf.printf "%s" "int";)
    | TyBool -> (Printf.printf "%s " "bool";)
    | TyVar(a) -> (Printf.printf "%s" "a";Printf.printf "%d" a;)
    | TyFun(a, b) -> (print_type a; Printf.printf "%s" "->"; print_type b;)

let rec lookup x env =
	match env with
	| [] -> TyVar(x)
	| (a,b) :: rest -> if a = x then b else lookup x rest

let rec ty_subst sigma t =
	match t with
	| TyInt -> TyInt
	| TyBool -> TyBool
	| TyVar (alpha) -> (lookup alpha sigma)
	| TyFun (t1,t2) -> TyFun ((ty_subst sigma t1), (ty_subst sigma t2))

(*先頭要素を順に見て行って存在すればtrue,存在しなければfalseを返す関数*)
let rec first_check x li =
	match li with
	| [] -> false 
	| (a,b) :: rest -> if a = x then true else first_check x rest 

let compose sig1 sig2 =
	let rec list_subst sigma li =
	(match li with
	| [] -> []
	| ((alpha, t) :: rest) -> ((alpha, (ty_subst sigma t)) :: (list_subst sigma rest)))
	in
	let substituted = list_subst sig1 sig2
	in
	let rec list_erase li1 li2 = 
	(match li1 with
	| [] -> li2 
	| ((alpha, t) :: rest) -> if (first_check alpha li2) then (list_erase rest li2) else ((alpha, t) :: (list_erase rest li2)))
	in
	(list_erase sig1 substituted)

exception TyError

let rec setin ing set =
  match set with
  | a :: rest -> if(a = ing) then true else setin ing rest
  | [] -> false

let rec union tenv1 tenv2 =
  match tenv1 with
  | a :: rest -> if(setin a tenv2) then union rest tenv2 else union rest (a :: tenv2)
  | [] -> tenv2

let rec include_check alpha t =
	match t with
	| TyVar(beta) -> if (alpha = beta) then true else false
	| TyFun(a,b) -> (include_check alpha a) || (include_check alpha b)
	| _ -> false  

(*list li の各要素に対し、conで表された代入を行う*)
let rec subst con li =
	match li with
	| (a,b) :: rest -> ((ty_subst con a),(ty_subst con b)) :: subst con rest
	| [] -> [] 

let rec ty_unify const =
	match const with
	| [] -> []
	| (TyInt, TyInt) :: rest -> ty_unify rest
	| (TyBool,TyBool) :: rest -> ty_unify rest
	| (TyFun(a,b),TyFun(c,d)) :: rest -> ty_unify (union [(a,c);(b,d)] rest)
	| (TyVar(alpha),t) :: rest -> if (include_check alpha t) then raise TyError else compose (ty_unify (subst [(alpha,t)] rest)) [(alpha,t)]
	| (t,TyVar(alpha)) :: rest -> if (include_check alpha t) then raise TyError else compose (ty_unify (subst [(alpha,t)] rest)) [(alpha,t)]
	| _ -> raise TyError
		

