type order = LT | EQ | GT

module type ORDERED_TYPE =
sig
  type t
  val compare : t -> t -> order
end


module type MULTISET2 =
  functor (T : ORDERED_TYPE) ->
    sig
      type t
      val empty : t
      val add    : T.t -> t -> t
      val remove : T.t -> t -> t
      val count  : T.t -> t -> int
    end



module Multiset2 : MULTISET2=
functor (T: ORDERED_TYPE) -> 
struct
type t =
  | Leaf
  | Node of t * T.t  * t

exception Eval_error

let empty = Leaf
let rec add a tree =
    match  tree with
    | Leaf -> Node (Leaf, a, Leaf)
    | Node (left, k, right) ->
		(match T.compare a k with

        |LT -> Node ((add a left), k, right)
        |EQ -> Node (left, k, (add a right))
		|GT -> Node (left, k, (add a right)))
		
let rec remove a tree =
    match tree with
    | Leaf -> Leaf
    | Node (left, k, right) ->
        if ((T.compare a k) = LT) then Node ((remove a left), k, right)
        else if ((T.compare a k) = GT) then Node (left, k, (remove a right))
        else 
			(
			if (right = Leaf) then left
			else
			let rec searchmin tr =
                match tr with
                | Leaf -> raise Eval_error
                | Node (left, l, right) ->
                    if (left = Leaf) then l
                    else searchmin left
                in
				let mini = searchmin right
				in
                Node(left, mini, remove mini right)
			)

let rec count a tree =
    match tree with
    | Leaf -> 0
    | Node (left, k, right) ->
        if ((T.compare a k) = EQ) then 1 + (count a left) + (count a right)
        else (count a left) + (count a right)
end

module OrderedInt =
struct
    type t = int
    let compare x y = if (x > y) then   GT else if (x < y) then LT else EQ
end

module Bst = Multiset2 (OrderedInt)
	 
