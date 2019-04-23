	type 'a t = 'a list
	exception Eval_error
	let pop x = 
		match x with 
		| a :: xs -> (a,xs)
		|[] -> raise Eval_error
		
	let push a x =
		a :: x
	let empty = []
	let size x = 
		let rec length y z =
			match y with
			| [] -> z
			| a :: ys -> length ys (z+1)
			in length x 0
