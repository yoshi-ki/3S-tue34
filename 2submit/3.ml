type 'a tree =
	|Leaf
	|Node of 'a * 'a tree * 'a tree
;;

let level_order x =
	let rec level y acc =
	match y with
	|[] -> acc
	|z :: rest ->
		match z with
		|Leaf -> level rest acc
		|Node (a, b, c) -> level (rest @ [b;c]) (acc @ [a])
	in
	level [x] []
;;

