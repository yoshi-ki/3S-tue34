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
  | FUN
  | ARROW
  | SEMISEMI

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
  273 (* FUN *);
  274 (* ARROW *);
  275 (* SEMISEMI *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\002\000\
\005\000\005\000\005\000\006\000\006\000\006\000\007\000\007\000\
\008\000\008\000\009\000\009\000\009\000\009\000\004\000\004\000\
\003\000\000\000"

let yylen = "\002\000\
\002\000\005\000\006\000\006\000\004\000\003\000\003\000\001\000\
\003\000\003\000\001\000\003\000\003\000\001\000\002\000\001\000\
\001\000\002\000\001\000\001\000\001\000\003\000\001\000\002\000\
\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\019\000\020\000\021\000\000\000\000\000\000\000\
\000\000\026\000\000\000\000\000\000\000\000\000\016\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\015\000\000\000\
\024\000\000\000\000\000\000\000\022\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\018\000\000\000\000\000\000\000\
\005\000\002\000\000\000\000\000\003\000\004\000"

let yydgoto = "\002\000\
\010\000\011\000\017\000\018\000\012\000\013\000\014\000\031\000\
\015\000"

let yysindex = "\001\000\
\003\255\000\000\000\000\000\000\000\000\010\255\007\255\007\255\
\022\255\000\000\019\255\006\255\032\255\145\255\000\000\022\255\
\043\255\049\255\022\255\055\255\067\255\022\255\053\255\000\000\
\145\255\145\255\145\255\145\255\145\255\145\255\000\000\145\255\
\000\000\007\255\007\255\007\255\000\000\007\255\032\255\032\255\
\050\255\050\255\145\255\145\255\000\000\079\255\081\255\087\255\
\000\000\000\000\007\255\007\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\021\255\098\255\041\255\000\000\097\255\
\000\000\000\000\000\000\000\000\000\000\140\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\056\255\
\000\000\000\000\000\000\000\000\000\000\000\000\110\255\122\255\
\126\255\138\255\071\255\086\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\249\255\000\000\014\000\015\000\048\000\059\000\078\000\
\245\255"

let yytablesize = 160
let yytable = "\020\000\
\021\000\001\000\032\000\003\000\004\000\005\000\006\000\003\000\
\004\000\005\000\019\000\025\000\016\000\026\000\007\000\027\000\
\028\000\008\000\007\000\009\000\032\000\008\000\023\000\009\000\
\022\000\008\000\046\000\047\000\048\000\033\000\049\000\032\000\
\032\000\008\000\008\000\033\000\008\000\024\000\029\000\008\000\
\030\000\041\000\042\000\053\000\054\000\014\000\014\000\014\000\
\014\000\014\000\014\000\014\000\034\000\014\000\014\000\025\000\
\014\000\026\000\035\000\014\000\017\000\017\000\017\000\017\000\
\017\000\017\000\017\000\036\000\017\000\017\000\038\000\017\000\
\039\000\040\000\017\000\012\000\012\000\012\000\012\000\012\000\
\012\000\012\000\037\000\012\000\012\000\051\000\012\000\043\000\
\044\000\012\000\013\000\013\000\013\000\013\000\013\000\013\000\
\013\000\050\000\013\000\013\000\052\000\013\000\011\000\011\000\
\013\000\011\000\023\000\011\000\011\000\045\000\011\000\011\000\
\000\000\011\000\009\000\009\000\011\000\009\000\000\000\009\000\
\009\000\000\000\009\000\009\000\000\000\009\000\010\000\010\000\
\009\000\010\000\006\000\010\000\010\000\000\000\010\000\010\000\
\000\000\010\000\006\000\006\000\010\000\006\000\007\000\000\000\
\006\000\003\000\004\000\005\000\000\000\023\000\007\000\007\000\
\000\000\007\000\000\000\000\000\007\000\023\000\000\000\008\000"

let yycheck = "\007\000\
\008\000\001\000\014\000\001\001\002\001\003\001\004\001\001\001\
\002\001\003\001\004\001\006\001\003\001\008\001\012\001\010\001\
\011\001\015\001\012\001\017\001\032\000\015\001\009\000\017\001\
\003\001\005\001\034\000\035\000\036\000\016\000\038\000\043\000\
\044\000\013\001\014\001\022\000\016\001\019\001\007\001\019\001\
\009\001\027\000\028\000\051\000\052\000\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\010\001\013\001\014\001\006\001\
\016\001\008\001\010\001\019\001\005\001\006\001\007\001\008\001\
\009\001\010\001\011\001\013\001\013\001\014\001\018\001\016\001\
\025\000\026\000\019\001\005\001\006\001\007\001\008\001\009\001\
\010\001\011\001\016\001\013\001\014\001\005\001\016\001\029\000\
\030\000\019\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\019\001\013\001\014\001\014\001\016\001\005\001\006\001\
\019\001\008\001\010\001\010\001\011\001\032\000\013\001\014\001\
\255\255\016\001\005\001\006\001\019\001\008\001\255\255\010\001\
\011\001\255\255\013\001\014\001\255\255\016\001\005\001\006\001\
\019\001\008\001\005\001\010\001\011\001\255\255\013\001\014\001\
\255\255\016\001\013\001\014\001\019\001\016\001\005\001\255\255\
\019\001\001\001\002\001\003\001\255\255\010\001\013\001\014\001\
\255\255\016\001\255\255\255\255\019\001\018\001\255\255\015\001"

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
  FUN\000\
  ARROW\000\
  SEMISEMI\000\
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
# 22 "parser.mly"
                  ( CExp _1 )
# 178 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 23 "parser.mly"
                             ( CDecl (_2, _4) )
# 186 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'lvar) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 27 "parser.mly"
                                 ( ELet(_2,_4,_6) )
# 195 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 28 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 204 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'lvar) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 29 "parser.mly"
                                 ( EFun(_2,_4) )
# 212 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 30 "parser.mly"
                                ( EEq(_1,_3) )
# 220 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 31 "parser.mly"
                                ( ELt(_1,_3) )
# 228 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 32 "parser.mly"
                                ( _1 )
# 235 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 36 "parser.mly"
                                 ( EAdd(_1,_3) )
# 243 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 37 "parser.mly"
                                 ( ESub(_1,_3) )
# 251 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 38 "parser.mly"
                                 ( _1 )
# 258 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 42 "parser.mly"
                               ( EMul(_1,_3) )
# 266 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 43 "parser.mly"
                               ( EDiv(_1,_3) )
# 274 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 44 "parser.mly"
                               ( _1 )
# 281 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'app_expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'lexpr) in
    Obj.repr(
# 48 "parser.mly"
                   ( EApp(_1, _2) )
# 289 "parser.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 49 "parser.mly"
                         ( _1 )
# 296 "parser.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 53 "parser.mly"
                ( [_1] )
# 303 "parser.ml"
               : 'lexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'atomic_expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'lexpr) in
    Obj.repr(
# 54 "parser.mly"
                      ( _1 :: _2 )
# 311 "parser.ml"
               : 'lexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 58 "parser.mly"
                   ( EConstInt(_1) )
# 318 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 59 "parser.mly"
                   ( EConstBool(_1) )
# 325 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 60 "parser.mly"
                   ( EVar(_1) )
# 332 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 61 "parser.mly"
                   ( _2 )
# 339 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "parser.mly"
       ( [_1] )
# 346 "parser.ml"
               : 'lvar))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'lvar) in
    Obj.repr(
# 66 "parser.mly"
            ( _1 :: _2 )
# 354 "parser.ml"
               : 'lvar))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 69 "parser.mly"
       ( _1 )
# 361 "parser.ml"
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
