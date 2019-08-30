let reverse l =
        let rec inreverse l1 l2=
                match l1 with
                | [] -> l2
                | x :: rest -> inreverse rest (x :: l2) in
        inreverse l [];;

let rec fold_right f l e =
        match l with
        | []       -> e
        | y :: ys -> f y (fold_right f ys e);;

let reverse_right l =
        (fold_right (fun x h -> ( fun y -> h ((fun list -> x :: list) y) )) 
		l 
		(fun e -> e)) [];;

