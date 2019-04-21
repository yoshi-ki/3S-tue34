type nat = 
	Z 
	| S of nat
;;

let rec add x y =
	match x with 
	| Z -> y
	| S a -> add a (S y)
;;

let rec sub x y = 
	match y with 
	| Z -> x
	| S a -> match x with
			| Z -> sub x a
			| S b -> sub b a
;;


let rec mul x y =
	match y with 
	| Z -> Z 
	| S a -> add x (mul x a)
;;

let rec pow x y=
	match y with
	| Z -> (S Z)
	| S a -> mul x (pow x a)
;; 

let rec n2i x =
	match x with 
	| Z -> 0
	| S a -> 1 + (n2i a)
;;

let rec i2n x =
	if (x = 0) then Z
	else S (i2n (x-1))
;;
