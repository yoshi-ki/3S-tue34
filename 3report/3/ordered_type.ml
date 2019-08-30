type t = int
	let compare x y = if (x > y) then 			GT else if (x < y) then LT else EQ
