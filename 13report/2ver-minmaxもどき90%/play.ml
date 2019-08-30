open Array
open Color
open Command

(*これがincludeされているlet opposite_color c = (2-c) + 1*)

type board = color array array

(*最初はnoneで埋めてるよ*)
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

let copy_board board =
  let board2 = Array.make_matrix 10 10 none in
  for i=0 to 9 do
	for j=0 to 9 do
	  board2.(i).(j) <- board.(i).(j);
	done;
  done;
  board2
	  


let dirs = [ (-1,-1); (0,-1); (1,-1); (-1,0); (1,0); (-1,1); (0,1); (1,1) ]

let flippable_indices_line board color (di,dj) (i,j) =
  let ocolor = opposite_color color in
  let rec f (di,dj) (i,j) r =
    if board.(i).(j) = ocolor then
      g (di,dj) (i+di,j+dj) ( (i,j) :: r )
    else
      []
  and    g (di,dj) (i,j) r =
    if board.(i).(j) = ocolor then
      g (di,dj) (i+di,j+dj) ( (i,j) :: r )
    else if board.(i).(j) = color then
      r
    else
      [] in
    f (di,dj) (i,j) []




(*i,jに置いたらボードのどこがひっくり返るか*)
let flippable_indices board color (i,j) =
  let bs = List.map (fun (di,dj) -> flippable_indices_line board color (di,dj) (i+di,j+dj)) dirs in
    List.concat bs

let is_effective board color (i,j) =
  match flippable_indices board color (i,j) with
      [] -> false
    | _  -> true

let is_valid_move board color (i,j) =
  (board.(i).(j) = none) && is_effective board color (i,j)


(*doMoveはboard自体を書き換える*)
let doMove board com color =
  match com with
      GiveUp  -> board
    | Pass    -> board
    | Mv (i,j) ->
	let ms = flippable_indices board color (i,j) in
	let _  = List.map (fun (ii,jj) -> board.(ii).(jj) <- color) ms in
	let _  = board.(i).(j) <- color in
	  board

(*操作を行う。boardの書き換えは行わず、boardは複製する*)
let doMove_copy board com color =
  let new_board = copy_board board in
  doMove new_board com color


(*[1;2][2;3]を4つのpairのlistに*)
let mix xs ys =
  List.concat (List.map (fun x -> List.map (fun y -> (x,y)) ys) xs)


(*合法手を全部listで出力してくれる*)
let valid_moves board color =
  let ls = [1;2;3;4;5;6;7;8] in
  List.filter (is_valid_move board color)
    (mix ls ls)

(*端っこか否かを判定する*)
let rec judge_edge ms =
  match ms with
   | [] -> (0,0)
   | (1,1) :: _ -> (1,1)
   | (1,8) :: _ -> (1,8)
   | (8,1) :: _ -> (8,1)
   | (8,8) :: _ -> (8,8)
   | (1,3) :: _ -> (1,3)
   | (3,1) :: _ -> (3,1)
   | (1,6) :: _ -> (1,6)
   | (6,1) :: _ -> (6,1)
   | (8,3) :: _ -> (8,3)
   | (3,8) :: _ -> (3,8)
   | (8,6) :: _ -> (8,6)
   | (6,8) :: _ -> (6,8) 
   | _ :: x -> judge_edge x

let rec judge_edge2 ms =
  match ms with
   | [] -> (0,0)
   | (1,1) :: _ -> (1,1)
   | (1,8) :: _ -> (1,8)
   | (8,1) :: _ -> (8,1)
   | (8,8) :: _ -> (8,8)
   | _ :: x -> judge_edge2 x


exception Nomove

(*合法手を指した後のboardのlistを返す
合法手がなければ、exception Nomove*)
let create_board_list board color =
  let v = valid_moves board color in
    if v = [] then raise Nomove
	else 	
      let rec board_list board l color =
	   ( match l with
	    | [] -> []
	    | (i,j) :: rest -> [doMove (copy_board board) (Mv(i,j)) color] @ board_list board rest color)
      in
  	  board_list board v color




(* 打つ手が与えられて、その値を出力する。nowcolorが探索元のcolorだから、初めは自分のcolorが入っていて、まず打つのは相手。opcolorにする。
まず、相手の手として最初読む
ansはstepcaseの評価値*)
let rec value_approximate func nowcolor board n =
  if n <= 0 then
	func board nowcolor
  else
  	try(
	let opcolor = opposite_color nowcolor in
  	let b_list = create_board_list board opcolor in
	let rec temp_approximate func board_list ans =
	  match board_list with
	  | [] -> ans
	  | x :: rest -> 
	    let v = value_approximate func opcolor x (n-1) in
	    if ans < v then temp_approximate func rest v
				   else temp_approximate func rest ans
	in
	temp_approximate func b_list 0;
	)
	with Nomove -> value_approximate func nowcolor board (n-2)



(*打つ手を決める moveのlist -> move*)
let rec decide move_l func mycolor board n acc_move acc_v =
  match move_l with
  | [] -> acc_move
  | x :: rest ->
    let v = value_approximate func mycolor (doMove_copy board (Mv(fst(x),snd(x))) mycolor) n in
    if v >= acc_v then (print_int v; print_newline (); decide rest func mycolor board n x v)
    else decide rest func mycolor board n acc_move acc_v
  

(*与えられたboardの時にどの場所に置けば良いかをn手先読みして計算*)
let approximate board func mycolor n =
  print_int n;
  print_newline ();
  let v_list = valid_moves board mycolor in
  let ans = decide v_list func mycolor board n (0,0) 0 in
  print_int (fst(ans));
  print_int (snd(ans));
  (Mv ((fst(ans)), (snd(ans))))


  
(*評価関数に使えそう*)
let count board color =
  let s = ref 0 in
    for i=1 to 8 do
      for j=1 to 8 do
        if board.(i).(j) = color then s := !s + 1
      done
    done;
    !s


(*相手の置ける手を少なくしようの評価関数*)
let opponent_less_move board color =
  let v = valid_moves board (opposite_color color) in
  let a = List.length v in
  (64 - a)


(*盤面に対して重み付け*)
let banmen_eval board color =
  let score = ref 0 in
  for i=0 to 9 do
    for j=0 to 9 do
      if board.(i).(j) = color then
		match (i,j) with
		| (1,1) -> score := (!score) + 20
   		| (1,8) -> score := (!score) + 20
   		| (8,1) -> score := (!score) + 20
   		| (8,8) -> score := (!score) + 20
		| (1,_) -> score := (!score) + 5
		| (_,1) -> score := (!score) + 5
		| (8,_) -> score := (!score) + 5
		| (_,8) -> score := (!score) + 5
		| (2,2) -> score := (!score) + 0
		| (2,7) -> score := (!score) + 0
		| (7,2) -> score := (!score) + 0
		| (7,7) -> score := (!score) + 0
		| (2,_) -> score := (!score) + 1
		| (_,2) -> score := (!score) + 1
		| (7,_) -> score := (!score) + 1
		| (_,7) -> score := (!score) + 1
		| (_,_) -> score := (!score) + 20
    done;
  done;
  (!score)



(*ここに実装する*)
let count_num = ref 0
let play board color =
  count_num := (!count_num) + 1;
   Printf.printf "%d\n" (!count_num);
  let ms = valid_moves board color in
    if ms = [] then
      Pass
    else
      if (!count_num) < 3 then
	    approximate board opponent_less_move color 2
		(*let k = Random.int (List.length ms) in
      	let (i,j) = List.nth ms k in
   	 	(Mv (i,j))*)
	  else if (!count_num) < 25 then
	    let d = judge_edge2 ms in
		if d = (0,0) then 
          approximate board banmen_eval color 4
        else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 33 then
		approximate board count color 4

	  (*else if (!count_num) < 29 then
	    let d = judge_edge2 ms in
        if d = (0,0) then
          approximate board count color 2
        else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 32 then
        let d = judge_edge2 ms in
        if d = (0,0) then
          approximate board count color 2
        else Mv ((fst(d)),(snd(d)))
	  *)
	  else 
	    let k = Random.int (List.length ms) in
        let (i,j) = List.nth ms k in
        (Mv (i,j)) 

let print_board board =
  count_num := 0;
  print_endline " |A B C D E F G H ";
  print_endline "-+----------------";
  for j=1 to 8 do
    print_int j; print_string "|";
    for i=1 to 8 do
      print_color (board.(i).(j)); print_string " "
    done;
    print_endline ""
  done;
  print_endline "  (X: Black,  O: White)"


let report_result board =
  let _ = print_endline "========== Final Result ==========" in
  let bc = count board black in
  let wc = count board white in
    if bc > wc then
      print_endline "*Black wins!*"
    else if bc < wc then
      print_endline "*White wins!*"
    else
      print_endline "*Even*";
    print_string "Black: "; print_endline (string_of_int bc);
    print_string "White: "; print_endline (string_of_int wc);
    print_board board
