open Syntax
open TySyntax
open ConstraintSolver

exception Unbound


let empty_env = []
let extend x v env = (x, v) :: env

let rec lookup x env =
  try List.assoc x env with Not_found -> raise Unbound
exception EvalErr


exception UnboundErr
type constraints = (ty * ty) list
type tyenv = (name * ty_schema ) list

let ini_constraints = []

let rec setin ing set =
  match set with
  | a :: rest -> if(a = ing) then true else setin ing rest
  | [] -> false

let rec union tenv1 tenv2 =
  match tenv1 with
  | a :: rest -> if(setin a tenv2) then union rest tenv2 else union rest (a :: tenv2)
  | [] -> tenv2


(*patternを受け取って、型と制約と追加する型環境を返す関数*)
let rec find_match_type p =
  match p with
  | PInt (a) -> (TyInt,[],[]) 
  | PBool (a) -> (TyBool,[],[])
  | PVar (name) -> 
  	let alpha = TyVar (new_tyvar()) in 
  	(alpha, [], [(name,([],alpha))])
  | PPair(p1,p2) ->
  	let (t1,c1,gamma1) = find_match_type p1 in
	let (t2,c2,gamma2) = find_match_type p2	in
	(TyPair(t1,t2), (union c1 c2), (union gamma1 gamma2))
   | PNil -> 
   	let alpha = TyVar (new_tyvar()) in
	(TyList(alpha), [], [])
   | PCons (p1,p2) ->
   	let (t1,c1,gamma1) = find_match_type p1 in
	let (t2,c2,gamma2) = find_match_type p2 in
	let alpha = TyVar (new_tyvar()) in
	(TyList(alpha), (union (union [(alpha,t1);(TyList(alpha),t2);] c1) c2), union gamma1 gamma2)


let rec infer_expr tenv exp =
(*型と制約を返す*)
  match exp with
  | EConstInt i -> (TyInt, [])
  | EConstBool b -> (TyBool, [])
  | EVar x ->
  	(try
  	 let v1 = lookup x tenv in
	 (instantiate(v1), [])
	 with
	 | Unbound -> raise UnboundErr)
  | EAdd (e1,e2) -> 
  	(let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 (TyInt, (union [(fst(v1),TyInt);(fst(v2),TyInt)] (union (snd(v1)) (snd(v2))))))
  | ESub (e1,e2) -> 
  	(let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 (TyInt, (union [(fst(v1),TyInt);(fst(v2),TyInt)] (union (snd(v1)) (snd(v2))))))
  | EMul (e1,e2) ->
  	(let v1 = infer_expr tenv e1 in
     let v2 = infer_expr tenv e2 in
	 (TyInt, (union [(fst(v1),TyInt);(fst(v2),TyInt)] (union (snd(v1)) (snd(v2))))))
  | EDiv (e1,e2) ->
    (let v1 = infer_expr tenv e1 in
     let v2 = infer_expr tenv e2 in
     (TyInt, (union [(fst(v1),TyInt);(fst(v2),TyInt)] (union (snd(v1)) (snd(v2))))))
  | EEq (e1,e2) -> 
    (let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 	(TyBool, (union [(fst(v1),fst(v2));] (union (snd(v1)) (snd(v2))))))
  | ELt (e1,e2) ->
  	(let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 	(TyBool, (union [(fst(v1),fst(v2));] (union (snd(v1)) (snd(v2))))))
  | EIf (e1,e2,e3) ->
    (let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 let v3 = infer_expr tenv e3 in
	 (fst(v2), (union [(fst(v1), TyBool); (fst(v2), fst(v3));] (union (union (snd(v1)) (snd(v2))) (snd(v3))))))
  | ELet (e1,e2,e3) ->
  	(let v1 = infer_expr tenv e2 in
	 let sigma = unify(snd(v1)) in
	 let s1 = ty_subst sigma (fst(v1)) in
	 let delta = env_subst tenv sigma in
	 let newtenv = (union delta [(e1, (generalize delta s1))]) in
	 let v2 = infer_expr newtenv e3 in
	 (fst(v2), (union (snd(v2)) (snd(v1))))) 
  | EFun (e1,e2) ->
    (let newvar = TyVar (new_tyvar()) in
	 let newtenv = (e1,([],newvar)) :: tenv in
	 let v = infer_expr newtenv e2 in
	 (TyFun(newvar, fst(v)), snd(v)))
  | EApp (e1,e2) ->
  	(let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 let newvar = TyVar (new_tyvar()) in
	 (newvar, (union [(fst(v1),TyFun(fst(v2), newvar))] (union (snd(v1)) (snd(v2))))))
  | ELetRec (e1,e2,e3,e4) ->
  	(let newvar1 = TyVar (new_tyvar()) in 
	 let newvar2 = TyVar (new_tyvar()) in
	 let newtenv1 = [(e1,([],(TyFun(newvar1,newvar2)))); (e2, ([],newvar1))] @ tenv in
	 let v1 = infer_expr newtenv1 e3 in
	 let sigma = unify(snd(v1)) in
     let s1 = ty_subst sigma (fst(v1)) in
     let delta = env_subst newtenv1 sigma in
     let newtenv2 = (union delta [(e1, (generalize delta s1))]) in
	 let v2 = infer_expr newtenv2 e4 in
	 (fst(v2), (union [((fst(v1)),newvar2)] (union (snd(v1)) (snd(v2))))))
  | EPair(e1,e2) ->
  	(
	 let v1 = infer_expr tenv e1 in
	 let v2 = infer_expr tenv e2 in
	 (TyPair((fst(v1)),(fst(v2))), (union (snd(v1)) (snd(v2)))))
  | ENil ->
  	 let newvar = TyVar (new_tyvar()) in
	 (TyList(newvar), [])
  | ECons (e1,e2) ->
  	 let v1 = infer_expr tenv e1 in
     let v2 = infer_expr tenv e2 in
	 (TyList(fst(v1)), (union [(TyList(fst(v1)),(fst(v2)))] (union (snd(v1)) (snd(v2))))) 

let rec infer_cmd tenv cmd =
  match cmd with
  | CExp e1 ->
    (let infer = infer_expr tenv e1 in
	let ans = unify (snd(infer)) in 
	(ty_subst ans (fst(infer)), tenv))
  | CDecl (e1,e2) ->
    (let infer = infer_expr tenv e2 in
	 let sigma = unify(snd(infer)) in
     let s1 = ty_subst sigma (fst(infer)) in
     let delta = env_subst tenv sigma in
     let newtenv = (union delta [(e1, (generalize delta s1))]) in
	 let ans = unify (snd(infer)) in
	 (ty_subst ans (fst(infer)),newtenv))
  | CRecDecl (e1,e2,e3) ->
    (let newvar1 = TyVar (new_tyvar()) in
	 let newvar2 = TyVar (new_tyvar()) in
	 let newtenv1 = [(e1,([],(TyFun(newvar1,newvar2)))); (e2, ([],newvar1))] @ tenv in
	 let infer = infer_expr newtenv1 e3 in
	 let sigma = unify(snd(infer)) in
     let s1 = ty_subst sigma (fst(infer)) in
     let delta = env_subst newtenv1 sigma in
     let newtenv2 = (union delta [(e1, (generalize delta s1))]) in
	 let hikisuunokata = lookup newvar1 (snd(infer)) in
	 let ans = unify (snd(infer)) in
	 (TyFun(hikisuunokata,ty_subst ans (fst(infer))),newtenv2))
		
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


let rec eval_expr env e =
  match e with
  | EConstInt i ->
    VInt i
  | EConstBool b ->
    VBool b
  | EVar x ->
    (try
	   let searched = lookup x env in
       (match (! searched) with
	   | DThunk (exp_thunk, env_thunk) -> 
		 let v = eval_expr (env_thunk) (exp_thunk) in
		 searched := DVal(v);
		 v
	   | DVal (v) -> v)
     with
     | Unbound ->  raise EvalErr)
  | EAdd (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
	print_expr e;
    print_newline();
    (match v1, v2 with
     | VInt i1, VInt i2 -> VInt (i1 + i2)
     | _ -> raise EvalErr)
  | ESub (e1,e2) ->
  	let v1 = eval_expr env e1 in
	let v2 = eval_expr env e2 in
	(match v1, v2 with
	 | VInt i1, VInt i2 -> VInt (i1 - i2)
	 | _ -> raise EvalErr)
  | EMul (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    (match v1, v2 with
     | VInt i1, VInt i2 -> VInt (i1 * i2)
     | _ -> raise EvalErr)
  | EDiv (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    (match v1, v2 with
     | VInt i1, VInt i2 -> VInt (i1 / i2)
     | _ -> raise EvalErr)
  | EEq (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    (match v1, v2 with
     | VInt i1,  VInt i2  -> VBool (i1 = i2)
     | _ -> raise EvalErr)
  | ELt (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
    (match v1, v2 with
     | VInt i1,  VInt i2  -> VBool (i1 < i2)
     | _ -> raise EvalErr)
  | EIf (e1,e2,e3) ->
    let v1 = eval_expr env e1 in
    (match v1 with
     | VBool b ->
       if b then eval_expr env e2 else eval_expr env e3
     | _ -> raise EvalErr)
  | ELet (e1,e2,e3) -> 
  	eval_expr (extend e1 ((ref (DThunk(e2,env)))) env) e3
  | EFun (x, e) ->
	VFun (x, e, env)
  | EApp (e1, e2) ->
    (match (eval_expr env e1) with
	 | VFun(x1,expr1,env_thunk) ->
	   let dthunk1 = (ref (DThunk (e2,env))) in
	   eval_expr (extend x1 dthunk1 env_thunk) expr1 
	 | VRecFun (f,x,expr1,env_thunk) ->
	   let thunk1 = (ref (DThunk (ELecFun (f,x,expr1),env_thunk))) in
	   let thunk2 = (ref (DThunk (e2,env))) in
	   eval_expr (extend x thunk2 (extend f thunk1 env_thunk)) expr1)
  | ELecFun (f,x,exp) ->
  	  VRecFun(f,x,exp,env)
  | ELetRec (f, x, e1, e2) ->
  	  let newenv = extend f (ref (DThunk(ELecFun(f,x,e1), env))) env
	  in
	  eval_expr newenv e2
  | EPair (e1,e2) ->
  	  VPair((eval_expr env e1),(eval_expr env e2))
  | ENil -> VNil
  | ECons (e1,e2) ->
  	  VCons ((eval_expr env e1),(eval_expr env e2))

let rec eval_command env tenv c =
  try 
  (let type_result = infer_cmd tenv c in
  match c with
  | CExp e -> (print_type(fst(type_result));print_newline();("-", env, tenv, eval_expr env e))
  | CDecl (e1,e2) -> (print_type(fst(type_result));print_newline();(e1, (extend e1 (ref(DThunk (e2,env))) env), (snd(type_result)), eval_expr env e2))
  | CRecDecl (f, x, e) ->
  	let newenv = extend f (ref (DThunk(ELecFun(f,x,e),env))) env
  	in
	print_type(fst(type_result));
    print_newline();
	("-", newenv, (snd(type_result)), VRecFun(f,x,e,newenv)))
  with  TyError -> ("Error", env, tenv, VError("Unmatched type"))


