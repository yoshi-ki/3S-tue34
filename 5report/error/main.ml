open Syntax
open Eval


let rec print_help a b c = 
match a with
| [] -> Printf.printf "";
| id1 :: rest1 ->
	(match c with
	| [] -> Printf.printf "error";
	| value :: [] ->
		(Printf.printf "%s = " id1;
        print_value value;
        print_help rest1 b [])
	| value :: rest2 ->
   		Printf.printf "%s = " id1;
   		print_value value;
		print_newline (); 
		print_help rest1 b rest2);;


let rec read_eval_print env =
  print_string "# ";
  flush stdout;
  
  try(
  let cmd = Parser.toplevel Lexer.main (Lexing.from_channel stdin) in

  let (id, newenv, v) = eval_command env cmd in
   (print_help id newenv v;
   print_newline ();
   read_eval_print newenv))
  with Failure a ->
    (
	Printf.printf "%s" a;
    print_newline ();
    read_eval_print env)
 | EvalErr -> 
  	(
	print_newline ();
	read_eval_print env)

let initial_env =
  extend "i" (VInt 1)
	 (extend "v" (VInt 5)
		 (extend "x" (VInt 10)
			 empty_env))
    
let _ = read_eval_print initial_env
