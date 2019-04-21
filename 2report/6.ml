type ('a, 'b) fix_f = 
   NONE
 | FIX of ((('a -> 'b) -> 'a -> 'b) -> 'a -> 'b);;

let fix f x =
  let r = ref NONE in
    let func g y =
      match !r with
      |FIX h -> g (h g) y
    in (r := FIX func;
        match !r with
        |FIX h -> h f x);;
