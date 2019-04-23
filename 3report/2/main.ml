open Stack;;

let s = empty;;
let t = push 5 s;;
Printf.printf "%d\n" (size t);;

let u = push 7 t;;
let v = pop u;;
let w = fst(v);;
Printf.printf "%d\n" (w);;
