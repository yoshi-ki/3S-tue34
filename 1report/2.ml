let twice f n=
        f (f n);;

let rec repeat f n =
	if n = 1 then 
		f
	else
		(fun x -> f ((repeat f (n-1)) x ));;

