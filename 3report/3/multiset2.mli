type order = LT | EQ | GT

type t
val empty : t
val add    : T.t -> t -> t
val remove : T.t -> t -> t
val count  : T.t -> t -> int
