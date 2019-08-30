let rec fix f x = f (fix f) x;;

let sum_to n = 
        let calc x y =
                if y = 0 then
                       0
                else
                       y + x (y-1) in
        fix calc n;;

let is_prime  n =
        let calc x y =
                if y = 1 then
                        true
                else if (n mod y) = 0 then
                        false
                else
                        x (y-1) in
        fix calc (n-1)

let gcd a b =
        let calc x y z =
                if y < z then
                        x z y
                else if y mod z = 0 then
                        z
                else
                        x y (y mod z) in
         fix calc a b
