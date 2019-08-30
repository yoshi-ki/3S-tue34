type 'a tree = 
	|Leaf 
	|Node of 'a * 'a tree * 'a tree
;;



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
