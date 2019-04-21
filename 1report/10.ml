let add n m = (fun f x -> n f (m f x));;

let mul n m = (fun f x -> n (fun y -> m f y) x);; 

let pred n = (fun f x -> n (fun g h -> h(g f) )(fun u -> x)(fun u -> u));;

let minus n m = (fun f x -> m pred (n f x));;

