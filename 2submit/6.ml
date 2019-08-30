type ('a, 'b) ty = 
	| NO
	| FIX of ((('a -> 'b) -> 'a -> 'b) -> 'a -> 'b );;

exception Error

let fix f x =
	let r = ref NO in 
		let func g y =
			match !r with
			| NO -> raise Error
			| FIX fi ->
				g (fi g) y in
					(r := FIX func;
					match !r with
					| NO -> raise Error
					| FIX fi ->
						fi f x);;
