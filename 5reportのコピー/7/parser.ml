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
  | LLet
  | LETAND

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
# 30 "parser.ml"
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
  276 (* LLet *);
  277 (* LETAND *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\003\000\003\000\004\000\002\000\002\000\
\002\000\002\000\002\000\007\000\007\000\008\000\008\000\006\000\
\006\000\006\000\009\000\009\000\009\000\010\000\010\000\010\000\
\010\000\005\000\000\000"

let yylen = "\002\000\
\002\000\001\000\001\000\005\000\005\000\009\000\006\000\006\000\
\003\000\003\000\001\000\003\000\001\000\003\000\001\000\003\000\
\003\000\001\000\003\000\003\000\001\000\001\000\001\000\001\000\
\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\022\000\023\000\024\000\000\000\000\000\000\000\
\027\000\000\000\002\000\003\000\000\000\000\000\000\000\000\000\
\021\000\026\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\025\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\019\000\020\000\000\000\000\000\000\000\000\000\
\000\000\005\000\000\000\004\000\000\000\000\000\000\000\007\000\
\000\000\008\000\000\000\000\000\000\000\000\000\006\000"

let yydgoto = "\002\000\
\009\000\010\000\052\000\012\000\019\000\013\000\014\000\015\000\
\016\000\017\000"

let yysindex = "\007\000\
\167\255\000\000\000\000\000\000\000\000\008\255\182\255\182\255\
\000\000\253\254\000\000\000\000\018\255\004\255\044\255\089\255\
\000\000\000\000\055\255\008\255\057\255\059\255\000\000\034\255\
\034\255\034\255\034\255\034\255\034\255\034\255\034\255\182\255\
\067\255\182\255\000\000\089\255\089\255\051\255\051\255\051\255\
\044\255\051\255\000\000\000\000\017\255\182\255\066\255\008\255\
\182\255\000\000\008\255\000\000\078\255\182\255\087\255\000\000\
\091\255\000\000\182\255\182\255\002\255\071\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\027\255\140\255\104\255\255\254\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\050\255\068\255\146\255\160\255\027\255\
\122\255\086\255\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\249\255\105\000\000\000\238\255\066\000\000\000\084\000\
\026\000\080\000"

let yytablesize = 197
let yytable = "\021\000\
\022\000\033\000\018\000\018\000\018\000\048\000\018\000\001\000\
\018\000\018\000\018\000\018\000\018\000\023\000\018\000\018\000\
\018\000\018\000\050\000\018\000\048\000\049\000\028\000\024\000\
\045\000\025\000\047\000\026\000\027\000\055\000\015\000\015\000\
\057\000\050\000\003\000\004\000\005\000\051\000\053\000\015\000\
\015\000\056\000\015\000\015\000\015\000\015\000\058\000\015\000\
\008\000\036\000\037\000\061\000\062\000\016\000\016\000\016\000\
\024\000\016\000\025\000\016\000\016\000\029\000\016\000\016\000\
\032\000\016\000\016\000\016\000\016\000\034\000\016\000\017\000\
\017\000\017\000\035\000\017\000\046\000\017\000\017\000\054\000\
\017\000\017\000\049\000\017\000\017\000\017\000\017\000\063\000\
\017\000\014\000\014\000\038\000\039\000\040\000\042\000\030\000\
\059\000\031\000\014\000\014\000\060\000\014\000\014\000\014\000\
\014\000\011\000\014\000\013\000\013\000\043\000\044\000\041\000\
\000\000\000\000\000\000\000\000\013\000\013\000\000\000\013\000\
\013\000\000\000\013\000\000\000\013\000\012\000\012\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\012\000\012\000\
\000\000\012\000\012\000\000\000\012\000\000\000\012\000\011\000\
\011\000\000\000\000\000\000\000\000\000\009\000\009\000\000\000\
\011\000\011\000\000\000\011\000\011\000\000\000\009\000\009\000\
\011\000\009\000\009\000\010\000\010\000\000\000\009\000\003\000\
\004\000\005\000\006\000\000\000\010\000\010\000\000\000\010\000\
\010\000\000\000\007\000\000\000\010\000\008\000\003\000\004\000\
\005\000\020\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\007\000\000\000\000\000\008\000"

let yycheck = "\007\000\
\008\000\020\000\004\001\005\001\006\001\004\001\008\001\001\000\
\010\001\011\001\003\001\013\001\014\001\017\001\016\001\017\001\
\018\001\019\001\017\001\021\001\004\001\005\001\019\001\006\001\
\032\000\008\001\034\000\010\001\011\001\048\000\004\001\005\001\
\051\000\017\001\001\001\002\001\003\001\021\001\046\000\013\001\
\014\001\049\000\016\001\017\001\018\001\019\001\054\000\021\001\
\015\001\024\000\025\000\059\000\060\000\004\001\005\001\006\001\
\006\001\008\001\008\001\010\001\011\001\018\001\013\001\014\001\
\010\001\016\001\017\001\018\001\019\001\013\001\021\001\004\001\
\005\001\006\001\016\001\008\001\010\001\010\001\011\001\014\001\
\013\001\014\001\005\001\016\001\017\001\018\001\019\001\017\001\
\021\001\004\001\005\001\026\000\027\000\028\000\029\000\007\001\
\010\001\009\001\013\001\014\001\010\001\016\001\017\001\018\001\
\019\001\001\000\021\001\004\001\005\001\030\000\031\000\028\000\
\255\255\255\255\255\255\255\255\013\001\014\001\255\255\016\001\
\017\001\255\255\019\001\255\255\021\001\004\001\005\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\013\001\014\001\
\255\255\016\001\017\001\255\255\019\001\255\255\021\001\004\001\
\005\001\255\255\255\255\255\255\255\255\004\001\005\001\255\255\
\013\001\014\001\255\255\016\001\017\001\255\255\013\001\014\001\
\021\001\016\001\017\001\004\001\005\001\255\255\021\001\001\001\
\002\001\003\001\004\001\255\255\013\001\014\001\255\255\016\001\
\017\001\255\255\012\001\255\255\021\001\015\001\001\001\002\001\
\003\001\004\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\012\001\255\255\255\255\015\001"

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
  LLet\000\
  LETAND\000\
  "

let yynames_block = "\
  INT\000\
  BOOL\000\
  ID\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 24 "parser.mly"
                  ( CExp _1 )
# 197 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 25 "parser.mly"
                  ( _1 )
# 204 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'letandexpr) in
    Obj.repr(
# 26 "parser.mly"
                 ( _1 )
# 211 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 29 "parser.mly"
                                  ( LLet (_2, _4, _5) )
# 220 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 30 "parser.mly"
                             ( CDecl (_2, _4) )
# 228 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 7 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 5 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _8 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                                                ( LAnd ( _2, _4, _6, _8) )
# 238 "parser.ml"
               : 'letandexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 38 "parser.mly"
                                ( ELet(_2,_4,_6) )
# 247 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 39 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 256 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 40 "parser.mly"
                                ( EEq(_1,_3) )
# 264 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 41 "parser.mly"
                                ( ELt(_1,_3) )
# 272 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 42 "parser.mly"
                                  ( _1 )
# 279 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 46 "parser.mly"
                                 (EOr(_1,_3))
# 287 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 47 "parser.mly"
                    ( _1 )
# 294 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor2_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 51 "parser.mly"
                                ( EAnd(_1,_3))
# 302 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 52 "parser.mly"
                   ( _1 )
# 309 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 56 "parser.mly"
                                 ( EAdd(_1,_3) )
# 317 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 57 "parser.mly"
                                 ( ESub(_1,_3) )
# 325 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 58 "parser.mly"
                                 ( _1 )
# 332 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 62 "parser.mly"
                                  ( EMul(_1,_3) )
# 340 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 63 "parser.mly"
                                  ( EDiv(_1,_3) )
# 348 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 64 "parser.mly"
                                  ( _1 )
# 355 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 68 "parser.mly"
                   ( EConstInt(_1) )
# 362 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 69 "parser.mly"
                   ( EConstBool(_1) )
# 369 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 70 "parser.mly"
                   ( EVar(_1) )
# 376 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 71 "parser.mly"
                   ( _2 )
# 383 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 75 "parser.mly"
       ( _1 )
# 390 "parser.ml"
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
