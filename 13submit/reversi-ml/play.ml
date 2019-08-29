open Array
open Color
open Command

(*これがincludeされているlet opposite_color c = (2-c) + 1*)

let myiro = ref 0

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
	  

let min2 a b =
  if a > b then b
  else a

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


(*pairのlistの初めの要素でsortする*)
let sort_by_first_element l = 
  let lexicographic_compare (x,y) (x',y') =
    let compare_fst = compare x x' in
    if compare_fst <> 0 then compare_fst
    else compare y y'
  in
  List.sort lexicographic_compare l

(*pairの第一要素のlistを作る*)
let rec get_second_element_list l =
  match l with
  | [] -> []
  | (a,b) :: rest -> b :: get_second_element_list rest


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


(*リストから危うい手を削除する*)
let rec delete_danger l =
  match l with
  | [] -> []
  | x :: rest ->
    match x with
    | (2,2) -> delete_danger rest
    | (7,7) -> delete_danger rest
    | (2,7) -> delete_danger rest
    | (7,2) -> delete_danger rest
    | (1,2) -> delete_danger rest
    | (2,1) -> delete_danger rest
    | (1,7) -> delete_danger rest
    | (7,1) -> delete_danger rest
    | (8,2) -> delete_danger rest
    | (8,7) -> delete_danger rest
    | (2,8) -> delete_danger rest
    | (7,8) -> delete_danger rest
    | (_,_) -> x :: (delete_danger rest)


exception Nomove
exception CutException


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

let sort_board_even b_list func =
  let rec generate_pair move_l pair_l =
    match move_l with
    | [] -> pair_l
    | x :: rest ->
      let v = List.length (valid_moves x (!myiro)) in
      generate_pair rest ((v,x) :: pair_l)
  in
  let l = generate_pair b_list [] in
  let l2 = sort_by_first_element l in
  get_second_element_list l2 


let sort_board_odd b_list func =
  let rec generate_pair move_l pair_l =
    match move_l with
    | [] -> pair_l
    | x :: rest ->
      let v = List.length (valid_moves x (opposite_color (!myiro))) in
      generate_pair rest ((v,x) :: pair_l) in
  let l = generate_pair b_list [] in
  let l2 = sort_by_first_element l in
  get_second_element_list l2



(* 打つ手が与えられて、その値を出力する。nowcolorが探索元のcolorだから、初めは自分のcolorが入っていて、
まず打つのは相手。opcolorにする。
まず、相手の手として最初読む
ansはstepcaseの評価値*)
(*minから入らないといけない,6手読みと言われたらここには5が入る*)
(*accはalpha betaのために使う*)
let rec value_approximate func board n acc =
  (*print_string "this n is ";
  print_int n;
  print_newline ();*)
  if n <= 0 then
    func board (!myiro)
  else if n = 1 then
   (if n mod 2 = 0 then
    (
    try(
    let opcolor = (!myiro) in
    let b_list = create_board_list board opcolor in
    (*末尾再帰でansに最大の手を取る*)
    let rec temp_approximate func board_list ans =
      match board_list with
      | [] -> ans
      | x :: rest ->
        let v = value_approximate func x (n-1) ans in
        if acc < v then ((*print_string "this acc is "; print_int acc; print_string "this v is "; print_int v; print_newline ();*) temp_approximate func [] (1000))
        else
        (if ans < v then temp_approximate func rest v
                   else temp_approximate func rest ans)
    in
    temp_approximate func b_list (-100000)
    )
    with Nomove -> value_approximate func board (n-2) acc)
    else (*奇数の時、minを取っている*)
    (
    try(
    let opcolor = opposite_color (!myiro) in
    let b_list = create_board_list board opcolor in
    let rec temp_approximate func board_list ans =
      match board_list with
      | [] -> ans
      | x :: rest ->
        let v = value_approximate func x (n-1) ans in
        if acc > v then ((*print_string "this acc is "; print_int acc; print_string "this v is "; print_int v; print_newline ();*) temp_approximate func [] (-1000)
        )else
        (if ans > v then temp_approximate func rest v
                   else temp_approximate func rest ans)
    in
    temp_approximate func b_list (100000)
    )
    with Nomove -> value_approximate func board (n-2) acc)) 
  else (*この場合はsortを行ってから再帰する*)
	(if n mod 2 = 0 then
    (
    try(
    let opcolor = (!myiro) in
    let b_list = create_board_list board opcolor in
    let sorted_b_list = sort_board_even b_list func in
	(*末尾再帰でansに最大の手を取る*)
    let rec temp_approximate func board_list ans =
      match board_list with
      | [] -> ans
      | x :: rest ->
        let v = value_approximate func x (n-1) ans in
        if acc < v then ((*print_string "this acc is "; print_int acc; print_string "this v is "; print_int v; print_newline ();*) (*temp_approximate func [] (1000)*) raise CutException)
        else
        (if ans < v then temp_approximate func rest v
                   else temp_approximate func rest ans)
    in
    temp_approximate func sorted_b_list (-100000)
    )
    with Nomove -> value_approximate func board (n-2) acc
       | CutException -> 1000)
    else (*奇数の時、minを取っている*)
    (
    try(
    let opcolor = opposite_color (!myiro) in
    let b_list = create_board_list board opcolor in
	let sorted_b_list = sort_board_odd b_list func in
    let rec temp_approximate func board_list ans =
      match board_list with
      | [] -> ans
      | x :: rest ->
        let v = value_approximate func x (n-1) ans in
        if acc > v then ((*print_string "this acc is "; print_int acc; print_string "this v is "; print_int v; print_newline ();*) (*temp_approximate func [] (-1000)*) raise CutException
        )else
        (if ans > v then temp_approximate func rest v
                   else temp_approximate func rest ans)
    in
    temp_approximate func sorted_b_list (100000)
    )
    with Nomove -> value_approximate func board (n-2) acc
       | CutException -> -1000)
    )



(*まず初めの手についてsortする。2手先の値でsort*)
let sort_move move_l func board =
  let rec generate_pair move_l pair_l =
    match move_l with
    | [] -> pair_l
    | x :: rest ->
      let v = value_approximate func (doMove_copy board (Mv(fst(x),snd(x))) (!myiro)) 1 (-10000) in
      generate_pair rest ((v,x) :: pair_l) in
  let l = generate_pair move_l [] in
  let l2 = sort_by_first_element l in
  (*l2の第２要素の配列を作る*)
  List.rev (get_second_element_list l2)


(*打つ手を決める moveのlist -> move*)
(*sorted_moveでsortしてから再帰関数に入る*)
let rec decide move_l func mycolor board n acc_move acc_v =
  let sorted_move = sort_move move_l func board in
  match sorted_move with
  | [] -> acc_move
  | x :: rest ->
    let v = value_approximate func (doMove_copy board (Mv(fst(x),snd(x))) mycolor) (n-1) acc_v in
    if v > acc_v then (print_int v; print_newline (); decide rest func mycolor board n x v)
    else decide rest func mycolor board n acc_move acc_v
  

(*与えられたboardの時にどの場所に置けば良いかをn手先読みして計算*)
let approximate board func mycolor n =
  print_int n;
  print_newline ();
  let v_list = valid_moves board mycolor in
  let ans = decide v_list func mycolor board n (0,0) (-10000) in
  print_int (fst(ans));
  print_int (snd(ans));
  (Mv ((fst(ans)), (snd(ans))))


(*与えられたboardの時にどの場所に置けば良いかをn手先読みして計算*)
let pre_approximate board func mycolor n =
  print_int n;
  print_newline ();
  let v_list2 = valid_moves board mycolor in
  let v_list = delete_danger v_list2 in
  let ans = decide v_list func mycolor board n (0,0) (-10000) in
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

(*
(*自分の数を少なくする*)
let less_count board color =
  let a = count board color in
  if a = 0 then 0 else (64 - a)
*) 

(*
(*相手の置ける手を少なくしようの評価関数*)
let opponent_less_move board mycolor =
  let b_list = create_board_list board mycolor in
  let rec eval board_list opcolor acc =
  	match board_list with
	| [] -> acc
	| x :: rest -> 
  	  let v = valid_moves board (opcolor) in
  	  let a = List.length v in
		eval rest opcolor (acc + a)
  in
  1000 - (eval b_list (opposite_color mycolor) 0)
*)

exception End
let kakutei board mycolor =
  let c = ref 0 in
  if board.(1).(1) = (!myiro) then
	(
	let flag1 = ref 0 in
	let flag2 = ref 0 in
	for i = 1 to 8 do
	  if (!flag1) = 0 then
	  	if board.(1).(i) =  (!myiro) then
		  c := (!c) + 1
		else flag1 := 1
	  ;
	  if (!flag2) = 0 then
		if board.(i).(1) =  (!myiro) then
		  c := (!c) + 1
		else flag2 := 1
  	  ;
	done;
	);
  if board.(1).(8) =  (!myiro) then
	(
    let flag1 = ref 0 in
    let flag2 = ref 0 in
    for i = 8 to 1 do
      if (!flag1) = 0 then
        if board.(1).(i) =  (!myiro) then
          c := (!c) + 1
        else flag1 := 1
      ;
	done;
	for i = 1 to 8 do
      if (!flag2) = 0 then
        if board.(i).(8) =  (!myiro) then
          c := (!c) + 1
        else flag2 := 1
      ;
    done;
    );
  if board.(8).(1) =  (!myiro) then
  	(
    let flag1 = ref 0 in
    let flag2 = ref 0 in
    for i = 8 to 1 do
      if (!flag1) = 0 then
        if board.(i).(1) =  (!myiro) then
          c := (!c) + 1
        else flag1 := 1
      ;
    done;
    for i = 1 to 8 do
      if (!flag2) = 0 then
        if board.(8).(i) =  (!myiro) then
          c := (!c) + 1
        else flag2 := 1
      ;
    done;
    );
  if board.(8).(8) =  (!myiro) then
  	(
    let flag1 = ref 0 in
    let flag2 = ref 0 in
    for i = 8 to 1 do
      if (!flag1) = 0 then
        if board.(1).(i) =  (!myiro) then
          c := (!c) + 1
        else flag1 := 1
      ;
      if (!flag2) = 0 then
        if board.(i).(1) =  (!myiro) then
          c := (!c) + 1
        else flag2 := 1
      ;
    done;
    );
  (!c)

(*自分の石の数が少ない、かつ盤面評価を行う。着手可能数も考慮*)
let banmen_eval_first board color = 
  let score = ref 0 in
  for i=0 to 9 do
    for j=0 to 9 do
      if board.(i).(j) = color then
        match (i,j) with
        | (1,_) -> score := (!score) + 5
		| (_,1) -> score := (!score) + 5
		| (8,_) -> score := (!score) + 5
		| (_,8) -> score := (!score) + 5
		| (2,2) -> score := (!score) - 30
        | (2,7) -> score := (!score) - 30
        | (7,2) -> score := (!score) - 30
        | (7,7) -> score := (!score) - 30
		| (2,_) -> score := (!score) - 10
        | (_,2) -> score := (!score) - 10
        | (7,_) -> score := (!score) - 10
        | (_,7) -> score := (!score) - 10
		| (3,_) -> score := (!score) + 20
		| (_,3) -> score := (!score) + 20
		| (6,_) -> score := (!score) + 20
        | (_,6) -> score := (!score) + 20
        | (_,_) -> score := (!score) + 20
    done;
  done;
  if (count board color) = 0 then (!score) else
  ((((!score) * 10) / ((count board color) * 2)) + (10 * List.length (valid_moves board color)))


(*盤面に対して重み付け*)
let banmen_eval_middle board color =
  let score = ref 0 in
  for i=0 to 9 do
    for j=0 to 9 do
      if board.(i).(j) = color then
        match (i,j) with
        | (1,1) -> score := (!score) + 50
        | (1,8) -> score := (!score) + 50
        | (8,1) -> score := (!score) + 50
        | (8,8) -> score := (!score) + 50
        | (1,2) -> score := (!score) - 50
        | (2,1) -> score := (!score) - 50
        | (7,8) -> score := (!score) - 50
        | (8,7) -> score := (!score) - 50
        | (1,_) -> score := (!score) + 10
        | (_,1) -> score := (!score) + 10
        | (8,_) -> score := (!score) + 10
        | (_,8) -> score := (!score) + 10
        | (2,2) -> score := (!score) - 100
        | (2,7) -> score := (!score) - 100
        | (7,2) -> score := (!score) - 100
        | (7,7) -> score := (!score) - 100
        | (2,_) -> score := (!score) - 10
        | (_,2) -> score := (!score) - 10
        | (7,_) -> score := (!score) - 10
        | (_,7) -> score := (!score) - 10
        | (3,_) -> score := (!score) + 30
        | (_,3) -> score := (!score) + 30
        | (6,_) -> score := (!score) + 30
        | (_,6) -> score := (!score) + 30
		| (_,_) -> score := (!score) + 20 
    done;
  done;
  (!score) + (kakutei board color)


(*盤面に対して重み付け*)
(*
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


let banmen_eval_worse board color =
  let score = ref 0 in
  for i=0 to 9 do
    for j=0 to 9 do
      if board.(i).(j) = color then
		match (i,j) with
		| (1,1) -> score := (!score) + 20
   		| (1,8) -> score := (!score) + 20
   		| (8,1) -> score := (!score) + 20
   		| (8,8) -> score := (!score) + 20
		| (1,2) -> score := (!score) - 50
        | (2,1) -> score := (!score) - 50
        | (7,8) -> score := (!score) - 50
        | (8,7) -> score := (!score) - 50
		| (1,_) -> score := (!score) + 5
		| (_,1) -> score := (!score) + 5
		| (8,_) -> score := (!score) + 5
		| (_,8) -> score := (!score) + 5
		| (2,2) -> score := (!score) - 100
		| (2,7) -> score := (!score) - 100
		| (7,2) -> score := (!score) - 100
		| (7,7) -> score := (!score) - 100
		| (2,_) -> score := (!score) - 10
		| (_,2) -> score := (!score) - 10
		| (7,_) -> score := (!score) - 10
		| (_,7) -> score := (!score) - 10
		| (_,_) -> score := (!score) + 20
    done;
  done;
  (!score)


(*合成関数の作成 alpha : betaで重み付け*)
let compose f g alpha beta =
  (fun x -> fun y -> (alpha * (f x y)) + (beta * (g x y)))
*)


let print_board_every_time board =
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

let f = ref 0

let create_hash hash filename =
  let fin = open_in filename in
  let cat_sub () =
    while true do
    let white_bit = input_line fin in
    let black_bit = input_line fin in
    let move1 = int_of_string (input_line fin) in
    let move2 = int_of_string (input_line fin) in
    Hashtbl.add hash ((Int64.of_string white_bit),(Int64.of_string black_bit)) (move1,move2);
	if (!f) = 0 then (print_int (Int64.to_int (Int64.of_string white_bit)); print_newline(); print_newline(); print_newline(););
	f := 1;
	done
  in
  try cat_sub () with End_of_file -> close_in fin


let generate_bit_from_board board =
  let black = ref 0L in
  let white = ref 0L in
  for i = 1 to 8 do
    for j = 1 to 8 do
      if (board.(i).(j) = 1) then (white := Int64.logor (Int64.shift_left (!white) 1) 1L;  black := (Int64.shift_left (!black) 1);)
      else (black := Int64.logor (Int64.shift_left (!black) 1) 1L; white := (Int64.shift_left (!white) 1);)
    done;
  done;
  ((!white),(!black))



(*ここに実装する*)
let count_num = ref 0
let my_hash = Hashtbl.create 123456

let play board color =
  let (a,b) = generate_bit_from_board board in
  print_int (Int64.to_int a);
  print_int (Int64.to_int b);
  myiro := color;
  count_num := (!count_num) + 1;
  Printf.printf "mycolor is %d\n" color;
  Printf.printf "%d\n" (!count_num);
  print_board_every_time board;
  if (!count_num) = 1 then		  
    (
	create_hash my_hash "joseki1.txt";
	create_hash my_hash "joseki2.txt";
	create_hash my_hash "joseki3.txt";
    create_hash my_hash "joseki4.txt";
	create_hash my_hash "joseki5.txt";
	create_hash my_hash "joseki6.txt";
	create_hash my_hash "joseki7.txt";
	create_hash my_hash "joseki8.txt";
	create_hash my_hash "joseki9.txt";
	create_hash my_hash "joseki10.txt";
	create_hash my_hash "joseki11.txt";
	create_hash my_hash "joseki12.txt";
	create_hash my_hash "joseki13.txt";
	create_hash my_hash "joseki14.txt";
	create_hash my_hash "joseki15.txt";
	create_hash my_hash "joseki16.txt";
	);
  let ms = valid_moves board color in
    if ms = [] then
      Pass
    else
	  (*序盤６手読み*)
	  if (!count_num) < 10 then 
	  	try
        (
		let bit = generate_bit_from_board board in
        let (a,b) = Hashtbl.find my_hash ((fst(bit)),(snd(bit))) in
		if (is_valid_move board (!myiro) (a,b)) then
		Mv (a,b)
		else raise Nomove)
        with _ ->
        (let d = judge_edge2 ms in
        if d = (0,0) then
		  let (Mv(a,b)) = pre_approximate board banmen_eval_first color 6 in
          if a = 0 then
            approximate board banmen_eval_first color 4
          else Mv(a,b)
        else Mv ((fst(d)),(snd(d))))
	  (*序盤4手読み*)
	  else if (!count_num) < 13 then
        try
        (
        let bit = generate_bit_from_board board in
        let (a,b) = Hashtbl.find my_hash ((fst(bit)),(snd(bit))) in
        if (is_valid_move board (!myiro) (a,b)) then
        Mv (a,b)
        else raise Nomove)
        with _ ->
        (let d = judge_edge2 ms in
        if d = (0,0) then
          let (Mv(a,b)) = pre_approximate board banmen_eval_first color 4 in
		  if a = 0 then 
			approximate board banmen_eval_first color 4
		  else Mv(a,b)
        else Mv ((fst(d)),(snd(d))))
	  else if (!count_num) < 20 then
        let d = judge_edge2 ms in
        if d = (0,0) then
		  let (Mv(a,b)) = pre_approximate board banmen_eval_middle color 4 in
          if a = 0 then
            approximate board banmen_eval_middle color 4
          else Mv(a,b)
		  else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 25 then
        let d = judge_edge2 ms in
        if d = (0,0) then
          let (Mv(a,b)) = pre_approximate board banmen_eval_middle color 4 in
          if a = 0 then
            approximate board banmen_eval_middle color 4
          else Mv(a,b)
          else Mv ((fst(d)),(snd(d)))
	  else if (!count_num) < 33 then
		approximate board count color 10 
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
