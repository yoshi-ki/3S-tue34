let rec fold_right f l e =
        match l with
        | []       -> e
        | y :: ys -> f y (fold_right f ys e);;

let rec fold_left f e l =
        match l with
        | []      -> e
        | y :: ys -> fold_left f (f e y) ys;;

let reverse l =
        let rec inreverse l1 l2=
                match l1 with
                | [] -> l2
                | x :: rest -> inreverse rest (x :: l2) in
        inreverse l [];;

let append_left a b =
        fold_left (fun x y -> y :: x) b (reverse a);;

let append_right a b =
        fold_right (fun x y -> x :: y) a b;;
