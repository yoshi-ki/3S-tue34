let rec fold_right f l e =
        match l with
        | []       -> e
        | y :: ys -> f y (fold_right f ys e);;

let rec fold_left f e l =
        match l with
        | []      -> e
        | y :: ys -> fold_left f (f e y) ys
