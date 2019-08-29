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


let rec eval_command env tenv c =
  try 
  (let type_result = infer_cmd tenv c in
  match c with
  | CExp e -> (print_type(fst(type_result));print_newline();("-", env, tenv, eval_expr env e))
  | CDecl (e1,e2) -> (print_type(fst(type_result));print_newline();(e1, (extend e1 (eval_expr env e2) env), (snd(type_result)), eval_expr env e2))
  | CRecDecl (f, x, e) ->
  	let oenv = ref [] in
	let v = VFun (x,e,oenv) in 
		oenv := extend f v env;
	print_type(fst(type_result));
	print_newline();
	("-", (!oenv), (snd(type_result)), VFun(x,e,oenv))	
  )
  with  TyError -> ("Error", env, tenv, VError("Unmatched type"))


