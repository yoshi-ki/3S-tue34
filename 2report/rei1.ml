type complex = {re : float; im: float};;

let prod {re = r1; im = i1} {re = r2; im = i2} = {re = (r1 *. r2) -. (i1 *. i2); im = (r1 *. i2) +. (i1 *. r2)};;

type str_tree = 
	| Leaf
	|Node of string * str_tree * str_tree
;;

type ib_list = INil
			|Icons of int * bi_list
and bi_list = BNil
			|BCons of bool * ib_list;;



			Node('a', Node('b', Node('d', Empty, Empty), Node('e', Empty, Empty)),




Node ("a",Node("a",Leaf,Leaf),Node("a",Leaf,Leaf));;
Node ("a",Node("a",Leaf,Node("a",Leaf,Leaf)),Node("a",Leaf,Leaf));;
Node ("a",Node("a",Leaf,Node("a",Leaf,Leaf)),Node("a",Leaf,Node("a",Leaf,Leaf)));;


Icons(1,BNil);;
Icons(1,BCons(true,INil));;
Icons(0,BCons(true,Icons(1,BNil)));;
