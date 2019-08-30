



let my_hash = Hashtbl.create 123456;;
Hashtbl.add my_hash "h" "hello";
Hashtbl.add my_hash "h" "hi";


let create_hash filename =
  let my_hash = Hashtbl.create 123456 in
  let fin = open_in filename in
  let cat_sub () =
    while true do
    let black_bit = input_line fin in
	let white_bit = input_line fin in
    let move1 = int_of_string (input_line fin) in
	let move2 = int_of_string (input_line fin) in
    Hashtbl.add my_hash ((Int64.of_string black_bit),(Int64.of_string white_bit)) (move1,move2);
	done
  in
  try cat_sub () with End_of_file -> close_in fin



let my_hash = Hashtbl.create 123456;
let create_hash hash filename =
  let fin = open_in filename in
  let cat_sub () =
 	while true do
    let black_bit = input_line fin in
	print_int (Int64.to_int (Int64.of_string black_bit));
    let white_bit = input_line fin in
    let move1 = int_of_string (input_line fin) in
	print_int move1;
    let move2 = int_of_string (input_line fin) in
    print_int move2;
	Hashtbl.add my_hash ((Int64.of_string black_bit),(Int64.of_string white_bit)) (move1,move2);
    done 
  in
  try cat_sub () with End_of_file -> close_in fin

