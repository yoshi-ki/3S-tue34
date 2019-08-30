(*



*)

type pairofint = {


let curry f x y = f (x, y);;

let uncurry f (x, y) = f x y;;


let f x y = x + y;;
	
(*fの型は、('a -> 'b -> 'c)*)



let f = (fun () -> (fun x y -> 0))();;


let f = (fun () -> (fun x y -> fst(x)))();;


let f = (fun () -> (fun x y -> (fun () -> (fun x y -> x))()))();;


let f = (fun () -> (fun x y -> let x = ref y in x := "1"; !x))();;

let f = (fun () -> (fun x y -> let r = ref (1,2) in r := x; 0))();;



let h = (fun () -> (fun x y -> x + 2))();;

let h = (fun x -> x (let x = ref "0" in x := "1"; !x) (fun x y -> x + y) );;
