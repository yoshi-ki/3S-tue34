type order = LT | EQ | GT

module type ORDERED_TYPE =
sig
  type t
  val compare : t -> t -> order
end

module type MAP = 
sig
	type t
	val empty : t
	val add : T.t -> 'a -> t -> t
	val remove : T.t -> t -> t
	val lookup : T.t -> t -> 'a
end

module Map: MAP =
functor(T : ORDERED_TYPE) ->
struct
type t = T.t * 'a
