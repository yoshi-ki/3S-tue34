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
		val create : T.t list list -> t
		val addition : t -> t -> t
		val multiplication : t -> t -> t
		val show : t -> T.t list list
	end

module Matrix : MATRIX =
functor (T: SEMIRING) ->
struct

type t = T.t list list 


exception Error
exception Error1
exception Error2


let create x = x

let rec addition x y =
	let rec addition_vector x y =
	(* this type is int list -> int list -> int list*)
		match x with
			| [] -> (match y with [] -> [] | _::_ -> raise Error)
			| a :: xs ->
				(match y with
					| [] -> raise Error
					| b :: ys ->
						(T.add a b) :: (addition_vector xs ys))
		in
	match x with
		| [[]] -> (match y with [[]] -> [[]] | _::_ -> raise Error | [] -> raise Error)
		| [] -> (match y with [] -> [] | _ :: _ -> raise Error)
		| a :: xs ->
			(match y with
				| [[]] -> raise Error
				| [] -> raise Error
				| b :: ys -> addition_vector a b :: addition xs ys);;
let rec transpose x =
	let rec get_first_ingredient x =
		(* this type is 'a list list -> 'a list*)
		match x with
		| [[]] -> []
		| [] -> []
		| a :: xs ->
			match a with
			| [] -> raise Error
			| b :: bs ->
				b :: get_first_ingredient xs
	in
	let rec map_first_delete x =
		(* this type is 'a list list -> 'a list list *)
		match x with
		| [[]] -> [[]]
		| [] -> []
		| a :: xs ->
			match a with
			| [] -> raise Error
			| b :: bs ->
				bs :: map_first_delete xs
	in
	match x with
	| [[]] -> []
	| [] -> []
	| [] :: _ -> []
	| _ :: _ -> (get_first_ingredient x) :: (transpose (map_first_delete x))

let multiplication x y =
	let rec inner_product x y =
		(* this type is int list -> int list -> int*)
		match x with
			| [] -> (match y with [] -> T.zero | _ :: _ -> raise Error)
			| a :: xs ->
				match y with
					| [] -> raise Error
					| b :: ys -> T.add (T.mul a b) (inner_product xs ys)
	in
	(*一行と行列の積*)
	let rec inner x y =
		(* this type is int list -> int list list -> int list *)
		match y with
			| [[]] -> []
			| [] -> []
			| a :: ys -> (inner_product x a) :: inner x ys
	in
	let rec multiplication2 x z =
	match x with
		| [[]] -> (match z with [[]] -> [[]] | _::_ -> raise Error | [] -> raise Error)
		| [] -> []
		| a :: xs -> (inner a z) :: (multiplication2 xs z)

	in
	multiplication2 x (transpose y)

	let show x = x

end

module Bool_ring =
struct
	type t = bool
	let add x y = if x then true 
		else (if y then true else false)
	let mul x y = if x then (if y then true else false) else false
	let unit = true
	let zero = false

end

module Boolmatrix = Matrix(Bool_ring)


module Tropical_ring =
struct
	type t = 
		| Int of int
		| Inf
	let add x y =
		(match x with
			| Inf -> (match y with | Inf -> Inf | Int a -> Int a)
			| Int a ->
				(match y with
					| Inf -> Int a
					| Int b -> (if (a > b) then Int b else Int a)))
	let mul x y =
		(match x with
			| Inf -> Inf
			| Int a ->
				(match y with
					| Inf -> Inf
					| Int b -> Int (a + b)))
	let unit = Int 0
	let zero = Inf
end


module Tmatrix = Matrix(Tropical_ring)
