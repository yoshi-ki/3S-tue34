type false_t = {t : 'a.'a};;
type 'a not_t = 'a -> false_t;;
type ('a, 'b) and_t = 'a * 'b;;
type ('a, 'b) or_t = L of 'a | R of 'b;;

let q1 x y = (fun s ->  y  ((fun z -> x z) s));;

let q2 = fun x ->
    match x with
      	| L a -> (L a, L a)
      	| R (b, c) -> (R b, R c);; 

let q3 = fun x ->
	match fst(x) with
	| L a ->
		(match snd(x) with
		| L b -> L a
		| R c -> L a) 
	| R d ->
		(match snd(x) with
		| L b -> L b
		| R c -> R (d,c));;

(*q4は直観主義論理において排中律は示せないため*)
(*call/ccを用いると直観主義論理でなく古典論理の自然演繹との対応がつけられるので示せるようになる*)

(*q5はaかつaでないが非自明なので不可能*)

(*q6も不可能である。パースの法則は排中律を仮定しないと示せないので*)


let rec callcc : (('a -> false_t) -> 'a) -> 'a = fun f -> callcc f;;

let q4 : (('a -> 'c) -> ('a not_t -> 'c) -> 'c) = fun x y -> x (callcc y);; 


let q6 : (('a, 'a not_t) or_t) -> ((('a -> 'b) -> 'a) -> 'a) =fun x y ->
  match x with	
    | L p -> p
    | R np -> y (fun p -> (np p).t)




