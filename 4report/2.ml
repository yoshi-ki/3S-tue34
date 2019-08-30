(* Definition of "the" list monad *)
type 'a m = 'a list

(** (>>=) : 'a m -> ('a -> 'b m) -> 'b m *)
let (>>=) (x : 'a m) (f : 'a -> 'b m) =
  List.concat (List.map f x)

(** return : 'a -> 'a m *)
let return (x : 'a) = [x]

(** guard : bool -> unit m *)
let guard (x : bool) =
  if x then return () else []





(** check if "banana + banana = sinamon" *)
let test_banana ba na si mo n =
  (100 * ba + 10 * na + na
   + 100 * ba + 10 * na + na
   = 1000 * si + 100 * na + 10 * mo + n)

(** check if "send + more = money" *)
let test_money s e n d m o r y =
  (1000 * s + 100 * e + 10 * n + d
   + 1000 * m + 100 * o + 10 * r + e
   = 10000 * m + 1000 * o + 100 * n + 10 * e + y)



let simple f =
[1;2;3;4;5;6;7;8;9;0]   >>= (fun a ->
[1;2;3;4;5;6;7;8;9;0]   >>= (fun b ->
[1;2;3;4;5;6;7;8;9;0]   >>= (fun c ->
[1;2;3;4;5;6;7;8;9;0]   >>= (fun d ->
[1;2;3;4;5;6;7;8;9;0]   >>= (fun e ->
(guard (f a b c d e))	>>=	(fun _ ->
return (a, b, c, d, e)))))))


let rec remove l x =
	(match x with
	| [] -> l
	| x :: rest -> remove (List.filter(fun z -> if z = x then false else true) l) rest)

let complex f =
[1;2;3;4;5;6;7;8;9]		>>= (fun a ->
(remove [1;2;3;4;5;6;7;8;9;0] [a]) >>= (fun b ->
(remove [1;2;3;4;5;6;7;8;9;0] [a;b]) >>= (fun c ->
(remove [1;2;3;4;5;6;7;8;9;0] [a;b;c]) >>= (fun d ->
(remove [1;2;3;4;5;6;7;8;9] [a;b;c;d]) >>= (fun e ->
(remove [1;2;3;4;5;6;7;8;9;0] [a;b;c;d;e]) >>= (fun g ->
(remove [1;2;3;4;5;6;7;8;9;0] [a;b;c;d;e;g]) >>= (fun h ->
(remove [1;2;3;4;5;6;7;8;9;0] [a;b;c;d;e;g;h]) >>= (fun i ->
(guard (f a b c d e g h i))	>>=	(fun _ ->
return (a,b,c,d,e,g,h,i))))))))))


 
