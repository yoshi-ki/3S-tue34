module type EQ2 = sig
	type ('a, 'b) equal
	val refl : ('a, 'a) equal
	val symm : ('a, 'b) equal -> ('b, 'a) equal
	val trans : ('a, 'b) equal -> ('b, 'c) equal -> ('a, 'c) equal
	val apply : ('a, 'b) equal -> 'a -> 'b
	module Lift : functor (F: sig type 'a t end) ->
	sig
		val f : ('a, 'b) equal -> ('a F.t, 'b F.t) equal
	end
end

module Eq2 =
struct
	type ('a, 'b) equal = ('a -> 'b) * ('b -> 'a)
    let refl : ('a, 'a) equal = ((fun x -> x),(fun x -> x))
    let symm : ('a, 'b) equal -> ('b, 'a) equal = (fun x -> (snd (x), fst (x)))
    let trans : ('a, 'b) equal -> ('b, 'c) equal -> ('a, 'c) equal = (fun x y ->(fun z ->  fst (y) (fst(x) z)), (fun z -> snd(x) (snd(y) z)))
    let apply : ('a, 'b) equal -> 'a -> 'b = (fun x y -> fst(x) y)

	
end 
