type token =
  | INT of (int)
  | BOOL of (bool)
  | ID of (string)
  | LET
  | IN
  | PLUS
  | TIMES
  | MINUS
  | DIV
  | EQ
  | LT
  | IF
  | THEN
  | ELSE
  | LPAR
  | RPAR
  | SEMISEMI
  | AND
  | OR

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
# 28 "parser.ml"
let yytransl_const = [|
  260 (* LET *);
  261 (* IN *);
  262 (* PLUS *);
  263 (* TIMES *);
  264 (* MINUS *);
  265 (* DIV *);
  266 (* EQ *);
  267 (* LT *);
  268 (* IF *);
  269 (* THEN *);
  270 (* ELSE *);
  271 (* LPAR *);
  272 (* RPAR *);
  273 (* SEMISEMI *);
  274 (* AND *);
  275 (* OR *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\004\000\004\000\005\000\005\000\
\005\000\005\000\005\000\006\000\006\000\006\000\007\000\007\000\
\007\000\008\000\008\000\008\000\008\000\003\000\000\000"

let yylen = "\002\000\
\002\000\005\000\003\000\001\000\003\000\001\000\006\000\006\000\
\003\000\003\000\001\000\003\000\003\000\001\000\003\000\003\000\
\001\000\001\000\001\000\001\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\018\000\019\000\020\000\000\000\000\000\000\000\
\023\000\000\000\000\000\006\000\000\000\000\000\017\000\022\000\
\000\000\000\000\000\000\000\000\001\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\021\000\000\000\005\000\000\000\000\000\000\000\000\000\015\000\
\016\000\000\000\000\000\000\000\000\000\002\000\000\000\000\000\
\000\000\007\000\008\000"

let yydgoto = "\002\000\
\009\000\010\000\017\000\011\000\012\000\013\000\014\000\015\000"

let yysindex = "\004\000\
\076\255\000\000\000\000\000\000\000\000\010\255\080\255\080\255\
\000\000\247\254\013\255\000\000\090\255\095\255\000\000\000\000\
\018\255\010\255\023\255\032\255\000\000\080\255\080\255\084\255\
\084\255\084\255\084\255\084\255\084\255\080\255\055\255\080\255\
\000\000\013\255\000\000\095\255\095\255\097\255\097\255\000\000\
\000\000\089\255\067\255\080\255\079\255\000\000\080\255\067\255\
\080\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\092\255\000\000\040\255\001\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\093\255\000\000\016\255\033\255\050\255\057\255\000\000\
\000\000\000\000\241\254\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\064\000\079\000\093\000\249\255\034\000\065\000\085\000"

let yytablesize = 115
let yytable = "\019\000\
\020\000\006\000\006\000\006\000\001\000\014\000\014\000\021\000\
\014\000\022\000\014\000\014\000\016\000\014\000\014\000\035\000\
\014\000\014\000\014\000\014\000\012\000\012\000\043\000\012\000\
\045\000\012\000\012\000\030\000\012\000\012\000\023\000\012\000\
\012\000\012\000\012\000\032\000\048\000\013\000\013\000\050\000\
\013\000\051\000\013\000\013\000\011\000\013\000\013\000\033\000\
\013\000\013\000\013\000\013\000\011\000\011\000\009\000\011\000\
\011\000\011\000\011\000\038\000\039\000\010\000\009\000\009\000\
\044\000\009\000\009\000\009\000\009\000\010\000\010\000\047\000\
\010\000\010\000\010\000\010\000\003\000\004\000\005\000\006\000\
\003\000\004\000\005\000\018\000\003\000\004\000\005\000\007\000\
\036\000\037\000\008\000\007\000\049\000\042\000\008\000\024\000\
\031\000\025\000\008\000\026\000\027\000\028\000\024\000\029\000\
\025\000\046\000\000\000\022\000\004\000\003\000\004\000\003\000\
\040\000\041\000\034\000"

let yycheck = "\007\000\
\008\000\017\001\018\001\019\001\001\000\005\001\006\001\017\001\
\008\001\019\001\010\001\011\001\003\001\013\001\014\001\023\000\
\016\001\017\001\018\001\019\001\005\001\006\001\030\000\008\001\
\032\000\010\001\011\001\010\001\013\001\014\001\018\001\016\001\
\017\001\018\001\019\001\013\001\044\000\005\001\006\001\047\000\
\008\001\049\000\010\001\011\001\005\001\013\001\014\001\016\001\
\016\001\017\001\018\001\019\001\013\001\014\001\005\001\016\001\
\017\001\018\001\019\001\026\000\027\000\005\001\013\001\014\001\
\010\001\016\001\017\001\018\001\019\001\013\001\014\001\005\001\
\016\001\017\001\018\001\019\001\001\001\002\001\003\001\004\001\
\001\001\002\001\003\001\004\001\001\001\002\001\003\001\012\001\
\024\000\025\000\015\001\012\001\014\001\030\000\015\001\006\001\
\018\000\008\001\015\001\010\001\011\001\007\001\006\001\009\001\
\008\001\017\001\255\255\019\001\017\001\017\001\019\001\019\001\
\028\000\029\000\022\000"

let yynames_const = "\
  LET\000\
  IN\000\
  PLUS\000\
  TIMES\000\
  MINUS\000\
  DIV\000\
  EQ\000\
  LT\000\
  IF\000\
  THEN\000\
  ELSE\000\
  LPAR\000\
  RPAR\000\
  SEMISEMI\000\
  AND\000\
  OR\000\
  "

let yynames_block = "\
  INT\000\
  BOOL\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    Obj.repr(
# 22 "parser.mly"
                          ( CExp _1 )
# 164 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    Obj.repr(
# 23 "parser.mly"
                                     ( CDecl (_2, _4) )
# 172 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 27 "parser.mly"
                                 (EOr(_1,_3))
# 180 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 28 "parser.mly"
                                ( _1 )
# 187 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor2_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 32 "parser.mly"
                          ( EAnd(_1,_3))
# 195 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                          ( _1 )
# 202 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                                ( ELet(_2,_4,_6) )
# 211 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 220 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 40 "parser.mly"
                                ( EEq(_1,_3) )
# 228 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 41 "parser.mly"
                                ( ELt(_1,_3) )
# 236 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 42 "parser.mly"
                            ( _1 )
# 243 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 47 "parser.mly"
                                 ( EAdd(_1,_3) )
# 251 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 48 "parser.mly"
                                 ( ESub(_1,_3) )
# 259 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 49 "parser.mly"
                                 ( _1 )
# 266 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 53 "parser.mly"
                                  ( EMul(_1,_3) )
# 274 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 54 "parser.mly"
                                  ( EDiv(_1,_3) )
# 282 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 55 "parser.mly"
                                  ( _1 )
# 289 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 59 "parser.mly"
                   ( EConstInt(_1) )
# 296 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 60 "parser.mly"
                   ( EConstBool(_1) )
# 303 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 61 "parser.mly"
                   ( EVar(_1) )
# 310 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 62 "parser.mly"
                   ( _2 )
# 317 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 66 "parser.mly"
       ( _1 )
# 324 "parser.ml"
               : 'var))
(* Entry toplevel *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let toplevel (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Syntax.command)
