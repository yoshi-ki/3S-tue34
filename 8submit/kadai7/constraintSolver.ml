open TySyntax

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
	| TyPair (t1,t2) -> TyPair((ty_subst sigma t1), (ty_subst sigma t2))
	| TyList (t1) -> TyList(ty_subst sigma t1)
	| TyRepeat (t1) -> ty_subst sigma t1

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

let rec subst con li =
    match li with
    | (a,b) :: rest -> ((ty_subst con a),(ty_subst con b)) :: subst con rest
    | [] -> []

let rec unify const =
    match const with
    | [] -> []
    | (TyInt, TyInt) :: rest -> unify rest
    | (TyBool,TyBool) :: rest -> unify rest
    | (TyFun(a,b),TyFun(c,d)) :: rest -> unify (union [(a,c);(b,d)] rest)
    | (TyVar(alpha),t) :: rest -> if (include_check alpha t) then raise TyError else compose (unify (subst [(alpha,t)] rest)) [(alpha,t)]
    | (t,TyVar(alpha)) :: rest -> if (include_check alpha t) then raise TyError else compose (unify (subst [(alpha,t)] rest)) [(alpha,t)]
	| (TyPair(a,b), TyPair(c,d)) :: rest -> unify (union [(a,c);(b,d)] rest)
	| (TyList(a), TyList(b)) :: rest -> unify (union [(a,b)] rest) 
	| _ -> raise TyError


(*型のなかの型変数を集めてくる関数*)
let rec get_type_vars ty =
    (match ty with
    | TyVar(a) -> [a]
    | TyFun(a,b) -> (get_type_vars a) @ (get_type_vars b)
    | _ -> [])

(*第一引数のlistに含まれていて第二引数のlistに含まれてないもののリストを返す*)
let rec comp_list_list li1 li2 =
	let rec comp_var_list var li =
	(match li with
	| a :: rest -> if (a = var) then [] else comp_var_list var rest
	| [] -> [var])
	in
	(match li1 with
	| a :: rest -> (comp_var_list a li2) @ (comp_list_list rest li2)
	| [] -> [])

(*schemaから、第一引数に含まれていて、第二に含まれていない変数(現れる変数)をとる関数*)
(* tyvar list * ty -> tyvar list *)
let pick_var_from_schema schema =
	(comp_list_list (get_type_vars(snd(schema))) (fst(schema)))

(*これは型環境に含まれるtype_shemaについてひたすらpick_var_from_schemaをする*)
(* ('a * (tyvar list * ty)) list -> tyvar list *)
let rec create_p tenv =
	match tenv with
	| a :: rest -> (union (pick_var_from_schema(snd(a))) (create_p rest))
	| [] -> []

(*型環境になくて型にある変数をスキームにする*)
(* ('a * (tyvar list * ty)) list -> ty -> tyvar list * ty *)
let rec generalize tenv s1 =
	(
	(comp_list_list (get_type_vars(s1)) (create_p(tenv)))
	,
	s1)

(*型スキームに型を入れる関数*)
let instantiate schema =
    (*tyvar listからsubstを作る関数*)
    let rec create_substitution li =
    (match li with
    | a :: rest -> [(a, (TyVar(new_tyvar())))] @ (create_substitution rest)
    | [] -> [])
    in
    let substitution = create_substitution(fst(schema))
    in
    ty_subst substitution (snd(schema))

(*listに含まれているかをboolで返す関数*)
let rec bool_list_in a li = 
	match li with
	| x :: rest -> if(x = a) then true else bool_list_in a rest
	| [] -> false

(*sigmaの代入について、liに含まれている変数の代入だけの式にする*)
let rec pick_out_sigma li sigma =
	match sigma with
	| (a,b) :: rest -> if(bool_list_in a li) then ([(a,b)] @ pick_out_sigma li rest) else pick_out_sigma li rest
	| [] -> []

(*lets_substituteに代入するべきもののリストを取得*)
let env_subst_hitotu ganma sigma =
	let lets_substitute = comp_list_list (get_type_vars(snd(snd(ganma)))) (fst(snd(ganma))) in
	let sigma2 = pick_out_sigma lets_substitute sigma in
	((fst(ganma)), ((fst(snd(ganma))),(ty_subst sigma2 (snd(snd(ganma))))))

let rec env_subst ganma sigma = 
	match ganma with
	| a :: rest -> [(env_subst_hitotu a sigma)] @ env_subst rest sigma
	| [] -> []

	
