let rec fold_right f l e =
        match l with
        | []       -> e
        | y :: ys -> f y (fold_right f ys e);;

let rec fold_left f e l =
        match l with
        | []      -> e
        | y :: ys -> fold_left f (f e y) ys;;

let fold_l_using_r f e l=
	(fold_right
	 (fun x h -> (fun y -> h ((fun z -> f z x) y)))
	 l
	 (fun id -> id)) e;;

let fold_r_using_l f l e =
	(fold_left
		(fun h x -> (fun y -> h ((fun z -> f x z) y)))
		(fun id -> id)
		l) e;;
