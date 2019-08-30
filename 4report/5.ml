type 'a m = ('a -> unit) -> unit

let (>>=) : ('a m -> ('a -> 'b m) -> 'b m) = (fun a b c -> a (fun z -> b z c))
let return : ('a -> 'a m) = (fun a b -> b a)

let guard b = if b then return () else (fun _ -> ())
let upto l u = 
	let rec unfold g s f =
  	match g s with
   		| None        -> ()
    	| Some (x, s) -> (f x ; unfold g s f)
	in
		unfold (fun l -> if l < u then Some (l, l+1) else None) l


let pythagoras n =
  upto 1 (n+1) >>= (fun a ->
  upto a (n+1) >>= (fun b ->
  guard ((a * a) + (b * b) <= (n * n)) >>= (fun _ ->
  upto b (n+1) >>= (fun c ->
  guard ((a * a) + (b * b) = (c * c)) >>= (fun _ ->
  return (a, b, c))))))

let n = 13

let () =
  (pythagoras n)
    (fun (a, b, c) -> Printf.printf "%d %d %d\n" a b c)
