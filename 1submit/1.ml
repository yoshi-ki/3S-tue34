let rec sum_to n = 
        if n = 0 then
                0
        else
                n + sum_to (n-1);;

let is_prime n =
        if n = 1 then
                false
        else
                let rec not_is_divided s t =
                        if t < 2 then
                                true
                        else if (s mod t) = 0 then
                                false
                        else
                                not_is_divided s (t-1) in
                not_is_divided n (n-1);;

let rec gcd a b =
        if a < b then
                gcd b a
        else if (a mod b) = 0 then
                a
        else 
                gcd b (a mod b);;

