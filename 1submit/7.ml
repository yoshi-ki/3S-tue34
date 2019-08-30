let rec fold_left f e l =
        match l with
        | []      -> e
        | y :: ys -> fold_left f (f e y) ys;;
let rec filter condf l =
        match l with
        |[] -> l
        |x :: rest -> if (condf x) then x :: filter condf rest
                      else filter condf rest;;
let rec filterfunc func l=
        match l with
        | [] -> l
        |x :: rest -> func x :: (filterfunc func rest);;

let rec perm l =
        match l with
        | [] -> [[]]
        | x :: [] -> [[x]]
        | x -> fold_left (fun acc a -> acc @ (filterfunc (fun y -> a :: y) (perm (filter (fun z -> if (z = a) then false else true) x)))) [] x;;

