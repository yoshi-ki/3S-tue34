type order = LT | EQ | GT

module type ORDERED_TYPE =
sig
  type t
  val compare : t -> t -> order
end


module type MULTISET2 =
  functor (T : ORDERED_TYPE) ->
    sig
      type 'a t
      val empty : 'a t
      val add    : T.t -> 'a -> 'a t -> 'a t
      val remove : T.t -> 'a t -> 'a t
      val lookup : T.t -> 'a t -> 'a 
    end



module Multiset2 : MULTISET2=
functor (T: ORDERED_TYPE) ->
struct
type 'a t =
  | Leaf
  | Node of 'a t * T.t * 'a  * 'a t

exception Eval_error

let empty = Leaf
let rec add a b tree =
    match  tree with
    | Leaf -> Node (Leaf, a, b, Leaf)
    | Node (left, k, l, right) ->
		(match T.compare a k with
        |LT -> Node ((add a  b left), k, l, right)
        |EQ -> Node (left, k, l, right)
		|GT -> Node (left, k, l, (add a b right)))

let rec remove a tree =
    match tree with
    | Leaf -> Leaf
    | Node (left, k, l, right) ->
        if ((T.compare a k) = LT) then Node ((remove a left), k, l, right)
        else if ((T.compare a k) = GT) then Node (left, k, l, (remove a right))
        else 
			(if (right = Leaf) then left
			else
				let rec searchmin tr =
                match tr with
                | Leaf -> raise Eval_error
                | Node (left, m, n, right) ->
                    if (left = Leaf) then (m, n)
                    else searchmin left
                in
				let mini = searchmin right in
                Node(left, fst(mini), snd(mini), remove (fst(mini))right))


let rec lookup a tree =
	match tree with
	| Leaf -> raise Eval_error
	| Node (left, k, l, right) ->
		if ((T.compare a k) = EQ) then l
		else if ((T.compare a k) = LT) then lookup a left
		else lookup a right	
end

module OrderedInt =
struct
    type t = int
    let compare x y = if (x > y) then   GT else if (x < y) then LT else EQ
end

module Map = Multiset2 (OrderedInt)
