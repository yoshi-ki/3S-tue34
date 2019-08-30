
(*これを上で宣言*)
let my_hash = Hash.tbl.create 123456;

let create_hash filename =
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

let generate_bit_from_board board =
  let black = ref 0L in
  let white = ref 0L in
  for i = 1 to 8 do
    for j = 1 to 8 do
      if (board.(i).(j) = 1) then (white := logor (shift_left (!white) 1) 1L;  black := (shift_left (!black) 1);)
      else (black := logor (shift_left (!black) 1) 1L;  white := (shift_left (!white) 1);)
    done;
  done;
  ((!white),(!black))

let play board color =
  (*これは一回だけ実行*)
  create_hash "data.txt";
  (*count < 12の時*)
  let b = generate_bit_from_board board 
  Hashtbl.find my_hash ((fst(b)),(snd(b)));;
  




