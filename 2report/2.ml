type 'a tree = 
	|Leaf 
	|Node of 'a * 'a tree * 'a tree
;;


ex_tree = Node('a', Node('b', Node('d', Leaf, Leaf), Node('e', Leaf, Leaf)), Node('c', Leaf, Node('f', Node('g', Leaf, Leaf), Leaf)));;

let rec pre_order x =
	match x with 
	|Leaf -> []  
	|Node (a, b, c) -> a :: ((pre_order b) @ (pre_order c))
;;

let rec in_order x =
    match x with
    |Leaf -> []
    |Node (a, b, c) -> (in_order b) @ (a :: (in_order c))
;;

let rec post_order x =
    match x with
    |Leaf -> []
    |Node (a, b, c) -> (post_order b) @ ((post_order c) @ [a])
;;
