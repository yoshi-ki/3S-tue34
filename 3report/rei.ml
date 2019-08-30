module OrderedInt =
struct
	type t = int
	let compare x y = if (x > y) then 						GT else if (x < y) then LT else EQ
end


module IntMultiset =  Multiset2 (OrderedInt)
	let a = IntMultiset.empty;;
	let b = IntMultiset.add (5) a;;
	let c = IntMultiset.add (5) b;;
	IntMultiset.count (5) c;;
