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


(*一個先、すなわち相手の盤面を出力するboard_list -> board_list*)
let rec one_step board_l mycolor =
  let opcolor = opposite_color mycolor in
  match board_l with
  | [] -> []
  | x :: rest -> 
    try(
	(create_board_list x opcolor) @ (one_step rest mycolor)
	)
	with Nomove -> (one_step rest mycolor)

(*2個先、すなわち自分の次に置くboardのlistを出力するboard -> board_list
2個先がなければその前の手を出力
*)
let two_forward board mycolor =
  let othercolor = opposite_color mycolor in
  let b_list =
  (
  try (create_board_list board mycolor)
  	  with Nomove -> [board]
  )
  in
  let rec create_my_list l c =
  (match l with 
    | [] -> [] 
    | x :: rest -> 
	(try(
	  (create_board_list x c) @ (create_my_list rest c)
  	)
	with Nomove -> [x] @ (create_my_list rest c)
    )
  )
  in
  create_my_list b_list othercolor

(*二個先のboard_list を出力する, board_list -> board_list *)
let rec two_forward_list b_list mycolor =
  match b_list with
  | [] -> []
  | x :: rest -> (two_forward x mycolor) @ (two_forward_list rest mycolor)


(*2n回先のboard_listを出力するboard_list -> board_list*)
let rec n_forward board_list mycolor n =
  if n = 0 then board_list
  else if n = 1 then two_forward_list board_list mycolor
  else let b_list = two_forward_list board_list mycolor in
  n_forward b_list mycolor (n-1)
  
(*boardのlistに評価値の合計を出力する board_list -> int *)
let rec calc l f c =
  match l with
  | [] -> 0
  | x :: rest -> (f x c) + (calc rest f c)

(*打つ手が与えられて、そのn手先の評価値を出力する
calcはsumで返すので、それを平均にして返す*)
let value_approximate move func mycolor board n =
  let next = doMove (copy_board board) (Mv((fst(move)),(snd(move)))) mycolor in
  let temp_l = n_forward [next] (opposite_color mycolor) (n-1) in
  let n_f = one_step temp_l mycolor in
  if List.length n_f = 0 then calc n_f func mycolor
  else
  (calc n_f func mycolor) / (List.length n_f)

(*打つ手を決める moveのlist -> move*)
let rec decide move_l func mycolor board n acc_move acc_v =
  match move_l with
  | [] -> acc_move
  | x :: rest -> 
  	let v = value_approximate x func mycolor board n in
	if v >= acc_v then decide rest func mycolor board n x v
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
          approximate board banmen_eval color 2
        else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 29 then
	    let d = judge_edge2 ms in
        if d = (0,0) then
          approximate board count color 2
        else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 32 then
        let d = judge_edge2 ms in
        if d = (0,0) then
          approximate board count color 3
        else Mv ((fst(d)),(snd(d)))
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
