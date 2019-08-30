let rec append a b =
        match a with
        | []      -> b
        | y :: rest -> y ::append rest b;;

let rec filter condf l =
        match l with
        |[] -> l
        |x :: rest -> if (condf x) then x :: filter condf rest 
                      else filter condf rest;;
