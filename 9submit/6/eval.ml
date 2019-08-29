open Syntax
open TySyntax
open ConstraintSolver

exception Unbound

type env = (name * value) list

let empty_env = []
let extend x v env = (x, v) :: env

let rec lookup x env =
  try List.assoc x env with Not_found -> raise Unbound
exception EvalErr


exception UnboundErr of string
type constraints = (ty * ty) list
type tyenv = (name * ty_schema) list

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
    (*let a = new_tyvar() in
	let alpha = TyVar (a) in
	(alpha, [], [(name,([a],alpha))]) *)
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
  	 (match lookup x tenv with
	 | (l,TyRef(a)) -> (TyRef(a),[])
	 | v1 -> (instantiate(v1), []))
	 with
	 | Unbound -> raise (UnboundErr x))
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
  | EMatch (e1,e2) ->
  	let v1 = infer_expr tenv e1 in
	let newvar = TyVar (new_tyvar()) in
	(*e2 = (pattern * expr) list, find_pattern : pattern -> value -> (name * value list option*)
	let rec match_type exp const =
		(match exp with
		| (p,ex) :: rest -> 
			let (ti,ci,gammai) = find_match_type p in
			let vi = infer_expr (gammai @ tenv) ex in
			match_type rest (union [(newvar, (fst(vi)))] (union [((fst(v1)), ti)](union (snd(vi)) (union ci const))))
		| [] -> (newvar, const))
	in
	(match_type e2 (snd(v1)))
  | ERefSub (x,e) ->
  	(try
	 let (l,TyRef(a)) = lookup x tenv in
	 let v = infer_expr tenv e in
	 (a,(union [(a,(fst(v)))] (snd(v))))
	 with
	 | Unbound -> raise (UnboundErr x))
  | RefExclam (x) ->
  	(try
     let v1 = lookup x tenv in
     (instantiate(v1), [])
     with
     | Unbound -> raise (UnboundErr x))

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
	 let hikisuunokata = (try(lookup newvar1 (snd(infer))) with Unbound -> newvar1) in
	 let ans = unify (snd(infer)) in
	 (TyFun(hikisuunokata,ty_subst ans (fst(infer))),newtenv2))
  | CRef (e1,e2) ->
  	 let infer = infer_expr tenv e2 in
	 let ans = unify(snd(infer)) in
	 let newtenv = (union [(e1,([],(TyRef(fst(infer)))))] tenv) in
	 (TyRef(ty_subst ans (fst(infer))), newtenv)
		
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
       lookup x env
     with
     | Unbound -> raise EvalErr)
  | EAdd (e1,e2) ->
    let v1 = eval_expr env e1 in
    let v2 = eval_expr env e2 in
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
  	eval_expr (extend e1 (eval_expr env e2) env) e3
  | EFun (x, e) ->
	VFun (x, e, ref env) 
  | EApp (e1, e2) ->
	let VFun (x,e,oenv) = eval_expr env e1 in
	let v2 = eval_expr env e2 in
		eval_expr (extend x v2 (!oenv)) e
  | ELetRec (f, x, e1, e2) ->
    let oenv = ref [] in
	let v = VFun (x,e1,oenv) in
		(oenv := extend f v env;
		 eval_expr (extend f v env) e2)
  | EPair (e1,e2) ->
  	  VPair((eval_expr env e1),(eval_expr env e2))
  | ENil -> VNil
  | ECons (e1,e2) ->
  	  VCons ((eval_expr env e1),(eval_expr env e2))
  | EMatch (e1,e2) ->
  	let v1 = eval_expr env e1 in
	(*e2 = (pattern * expr) list, find_pattern : pattern -> value -> (name * value list option*)
	let rec search_match ex v =
	  match ex with
	  | a :: rest -> 
	  	(match (find_match (fst(a)) v) with
		  | Some b -> eval_expr (b @ env) (snd(a))
		  | None -> search_match rest v)
	  | [] -> raise EvalErr
	in
	search_match e2 v1
  | ERefSub (x,e) ->
	(try 
	   let VRef(a) = lookup x env in
	   let v = eval_expr env e in
	   a := v;
	   !a
	 with
	   | Unbound -> raise EvalErr)
  | RefExclam (x) ->
  	(try
       let VRef(a) = lookup x env in
	   !a
     with
     | Unbound -> raise EvalErr)
  	

let rec eval_command env tenv c =
  try 
  (let type_result = infer_cmd tenv c in
  match c with
  | CExp e -> 
  	Printf.printf "- : ";
	print_type(fst(type_result));
	Printf.printf "%s" " ";
	Printf.printf "%s " "=";
	print_value(eval_expr env e);
	("-", env, tenv)
  | CDecl (e1,e2) -> 
  	Printf.printf "val %s : " e1; 
  	print_type(fst(type_result));
	Printf.printf "%s" " ";
	Printf.printf "%s " "=";
    print_value(eval_expr env e2);
	(e1, (extend e1 (eval_expr env e2) env), (snd(type_result)))
  | CRecDecl (f, x, e) ->
  	(let oenv = ref [] in
	let v = VFun (x,e,oenv) in 
	oenv := extend f v env;
	Printf.printf "val %s : " f;
	print_type(fst(type_result));
	Printf.printf "%s" " ";
	Printf.printf "%s " "=";
	print_value(VFun(x,e,oenv));
	("-", (!oenv), (snd(type_result))))
  | CRef (e1,e2) ->
  	(let a = eval_expr env e2 in
	Printf.printf "val %s : " e1;
	print_type(fst(type_result));
	Printf.printf " %s" "{contents";
	Printf.printf " %s " "=";
	print_value(eval_expr env e2);
	Printf.printf "%s" "}";
	(e1, (extend e1 (VRef(ref a)) env), (snd(type_result)))
  	)
  )
  with  TyError -> raise EvalErr






