module type SEMIRING =
sig
	type t
	val add : t -> t -> t
	val mul : t -> t -> t
	val unit : t
	val zero : t
end

module type MATRIX =
	functor (T : SEMIRING) ->
	sig
		type t
		val transpose : t -> t
		val multiplication : t -> t -> t
	end

module Matrix : MATRIX =
functor (T: SEMIRING) ->
struct

type t = T.t list list 

exception Error


let rec transpose x =
	let rec get_first_ingredient x =
		match x with 
		| [[]] -> []
		| [] -> []
		| a :: xs -> 
			(match a with
			| [] -> []
			| b :: bs ->
				b :: get_first_ingredient xs)
	in
	let rec map_first_delete x =
		match x with
		| [[]] -> [[]]
		| [] -> []
		| a :: xs -> 
			match a with
			| [] -> raise Error
			| b :: bs ->
				bs @ map_first_delete xs
	in
	(get_first_ingredient x) @ (transpose (map_first_delete x))
 


let multiplication x y = 
	let z = transpose y in
	let rec inner_product x y =
		if (x = []) then (if(y = []) then T.zero)
		else
		match x with
			| [] -> raise Error
			| a :: xs ->
				match y with
					| [] -> raise Error
					| b :: ys -> T.add  (T.mul a b)	(inner_product xs ys)
	in
	(*一行と行列の積*)
	let rec inner x y =
		match y with
			| [[]] -> []
			| a :: ys -> (inner_product x a) :: inner x ys
	in

	match x with
		| [[]] -> []
		| a :: xs -> (inner a z) @ (multiplication xs z)	
	
end


module Bool_ring =
struct
	type t = bool
	let add x y = if x then True 
		else (if y then True else False)
	let mul x y = if x then (if y then True else False) else False
	let unit = True
	let zero = False

end

module Boolmatrix = Matrix(Bool_ring)


