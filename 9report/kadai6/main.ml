open Syntax
open Eval
open TySyntax

let rec read_eval_print env tenv =
  print_string "# ";
  flush stdout;
  try(
  let cmd = Parser.toplevel Lexer.main (Lexing.from_channel stdin) in
  let (id, newenv, newtenv) = eval_command env tenv cmd in
  (print_newline ();
   read_eval_print newenv newtenv))
  with EvalErr ->
  (
    print_newline ();
    read_eval_print env tenv)
  | UnboundErr a ->
    (
	Printf.printf "\027[38;5;1mError\027[0m";
	Printf.printf "%s %s" ": Unbound value" a;
    print_newline ();
    read_eval_print env tenv)
  | Failure a ->
    (
    Printf.printf "%s" a;
    print_newline ();
    read_eval_print env tenv)

let initial_env =
  extend "i" (VInt 1)
     (extend "v" (VInt 5)
             empty_env)

let initial_tenv = empty_env


let _ = 
Printf.printf "%s\n" "        OCaml version 0.0.0";
print_newline();
read_eval_print initial_env initial_tenv



