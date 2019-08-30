let init_board () =
  let board = Array.make_matrix 10 10 none in
    for i=0 to 9 do
      board.(i).(0) <- sentinel ;
      board.(i).(9) <- sentinel ;
      board.(0).(i) <- sentinel ;
      board.(9).(i) <- sentinel ;
    done;
    board.(4).(4) <- white;
    board.(5).(5) <- white;
    board.(4).(5) <- black;
    board.(5).(4) <- black;
    board



(*whiteが1、blackが2*)

let board =  Array.make_matrix 10 10 0 in
	for i=1 to 8 do
	  for j = 1 to 8 do
	  board.(i).(j) <- 2 ;
    done;
	done;


let generate_bit_board board =
  let black = ref 0L in
  let white = ref 0L in
  for i = 1 to 8 do
    for j = 1 to 8 do
	  if (board.(i).(j) = 1) then (white := logor (shift_left (!white) 1) 1L;  black := (shift_left (!black) 1);)
	  else (black := logor (shift_left (!black) 1) 1L;  white := (shift_left (!white) 1);)
	done;
  done;
  (white,black)

let generate_board_from_bit board bit_pair =
  let white = (fst(bit_pair)) in
  let black = (snd(bit_pair)) in
  for i=0 to 9 do
      board.(i).(0) <- 0 ;
      board.(i).(9) <- 0 ;
      board.(0).(i) <- 0 ;
      board.(9).(i) <- 0 ;
    done;
  let c = ref 64 in
  for i = 1 to 8 do
	for j = 1 to 8 do
		(if ((logand (shift_right_logical (!white) (!c))  1L) = 1L) then 
				(board.(i).(j) <- 1)
		else if ((logand (shift_right_logical (!black) (!c))  1L) = 1L) then
                (board.(i).(j) <- 2)
		else (board.(i).(j) <- 0));
		c := (!c) - 1
	done;
done;
board

