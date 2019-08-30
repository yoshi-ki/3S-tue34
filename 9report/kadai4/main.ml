open Syntax
open Eval
open TySyntax

let rec read_eval_print env tenv =
  print_string "# ";
  flush stdout;
  try(
  let cmd = Parser.toplevel Lexer.main (Lexing.from_channel stdin) in
  let (id, newenv, newtenv, v) = eval_command env tenv cmd in
  (Printf.printf "%s = " id;
   print_value v;
   print_newline ();
   read_eval_print newenv newtenv))
  with EvalErr ->
   (
    print_newline ();
    read_eval_print env tenv)
  | UnboundErr ->
    (Printf.printf "%s" "Error: Unbound value";
    print_newline ();
    read_eval_print env tenv)


let initial_env = empty_env
let initial_tenv = empty_env


let _ = read_eval_print initial_env initial_tenv



