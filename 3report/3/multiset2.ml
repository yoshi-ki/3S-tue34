type 'a bst_tree =
  | Leaf
  | Node of 'a bst_tree * 'a * 'a bst_tree

exception Eval_error

let empty = Leaf
let rec add a tree =
    match  tree with
    | Leaf -> Node (Leaf, a, Leaf)
    | Node (left, k, right) ->
        if a < k then Node ((add a left), k, right)
        else Node (left, k, (add a right))

let rec remove a tree =
    match tree with
    | Leaf -> Leaf
    | Node (left, k, right) ->
        if a < k then Node ((remove a left), k, right)
        else if a > k then Node (left, k, (remove a right))
        else let rec searchmin tr =
                match tr with
                | Leaf -> raise Eval_error
                | Node (left, l, right) ->
                    if (left = Leaf) then l
                    else searchmin left
                in
            let rec deletemin tre =
                match tre with
                | Leaf -> Leaf
                | Node (left, r, right) ->
                    if (left = Leaf) then Leaf
                    else Node ((deletemin left), r, right)                  in
                Node(left, searchmin right, deletemin right )

let rec count a tree =
    match tree with
    | Leaf -> 0
    | Node (left, k, right) ->
        if (a = k) then 1 + (count a left) + (count a right)
        else (count a left) + (count a right)
