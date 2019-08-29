open Type

exception EvalError

let rec lookup x env =
    match env with
    | [] -> TyVar x
    | (a,b) :: rest -> if a = x then b else lookup x rest


let rec ty_subst sigma t =
    match t with
    | TySym s -> TySym s
    | TyVar v -> lookup v sigma
	| TyFun (t1,t2) ->
      let rec inner t2 = match t2 with
        | [] -> []
        | x :: rest -> (ty_subst sigma x) :: (inner rest)
        in TyFun (t1, inner t2)

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
    | TyFun(a,b) -> (*(include_check alpha a) ||*) (include_list alpha b)
    | _ -> false
and include_list beta b =
  match b with
  | [] -> false
  | x :: rest -> (include_check beta x) || (include_list beta rest)

let rec subst con li =
    match li with
    | (a,b) :: rest -> ((ty_subst con a),(ty_subst con b)) :: subst con rest
    | [] -> []

let rec unify const =
    match const with
    | [] -> []
    | (TySym s , TySym t) :: rest when s = t -> unify rest
    | (TyVar v ,TyVar u) :: rest when v = u -> unify rest
    | (TyFun(a,b),TyFun(c,d)) :: rest -> unify (union ([(TySym a,TySym c)] @ (List.combine b d)) rest)
    | (TyVar(alpha),t) :: rest -> if (include_check alpha t) then raise TyError else compose (unify (subst [(alpha,t)] rest)) [(alpha,t)]
    | (t,TyVar(alpha)) :: rest -> if (include_check alpha t) then raise TyError else compose (unify (subst [(alpha,t)] rest)) [(alpha,t)]
    | _ -> raise TyError



(*rule入れる。左辺に述語、右辺に述語list*)
let init_env = [
	   (("mother",[TyVar("A");TyVar("B")]),[("parent",[TyVar("A");TyVar("B")]),("female",TyVar("B"))])
	  ]

(*factを入れる*)
let init_l = [("male",[TySym("kobo")]);
      ("female",[TySym("miho")]);
	  ("parent",[TySym("kobo");TySym("miho")]);
      ] 

type res = ESuccess | EFail


(*ここでsucceedとかだす
goalから一つ取り出して、ruleを用いてunifyをtryする
全てのgoalに対してunifyができなかった場合はfailとなる。
もし、unifyできたら、unifyを行なって、
代入後のgoalと代入のpairをqueueに追加する
*)
let eval_goal l env g q theta =
  match g with
  | [] -> ESuccess
  | x :: rest ->
    try(
  	let newgoal = unify (g,l) in
	Queue.push (goal @ fst(newgoal), snd(newgoal))
    )
	with TyError -> 
	  if rest = [] then EFail 
	  else eval_goal l env rest q theta


(*goalとqueueを受け取って、書き換えたgoalとqueueを返す*)
let construct_node g q' q =
  if Queue.is_empty q' then (g,q)
  else 
    let (c,l) = Queue.take q' in
	let (a,b) = lookup c env in
	Queue.push (c,b) q; 
	construct_node g q' q 
	


(*幅優先探索をするためにqueueで扱う
まずqueueに対して、ルールの適用を行なって、
goalを探す*)
let rec search l env q =
  if Queue.is_empty q
  then None
  else 
    let (g, theta) = Queue.take q in
	let q' = Queue.copy q in
	let _ = Queue.clear q in
	let (g,q) = construct_node g q' q in
	match eval_goal l env g q theta with
	| ESuccess -> Some theta
	| EFail -> search l env q


(*制約を変数に対応づける*)
let rec gen_solution env theta =
  match env with
  | [] -> []
  | (name,v) :: xs ->
  	let s = (ty_subst theta (TyVar v)) in
	(name,s) :: (gen_solution xs theta)

(*解を探す。search関数を呼ぶ*)
let search_solution l env q =
  match search l env q with
  | None -> (l,env, Fail)
  | Some theta -> 
  	let s = gen_solution env theta in
	(l, env, Found(s,q))


let rec eval_command l command env =
	match command with 
	| Clause -> Printf.printf "add to environment"
	| Query (exp) ->
	  let q = Queue.create () in
	  Queue.push (exp,[]) q;
	  search_solution l env q
	


let _ = let (_,_,result) = eval_command init_l Query(TyFun("male",TyVar("X"))) init_env in
	match result with
	| Found(s,q) -> Printf.printf "%s" q
	| Fail -> Printf.printf "fail"


