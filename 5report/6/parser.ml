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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
# 29 "parser.ml"
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
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\003\000\003\000\002\000\002\000\002\000\002\000\
\002\000\006\000\006\000\007\000\007\000\005\000\005\000\005\000\
\008\000\008\000\008\000\009\000\009\000\009\000\009\000\004\000\
\000\000"

let yylen = "\002\000\
\002\000\001\000\005\000\005\000\006\000\006\000\003\000\003\000\
\001\000\003\000\001\000\003\000\001\000\003\000\003\000\001\000\
\003\000\003\000\001\000\001\000\001\000\001\000\003\000\001\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\020\000\021\000\022\000\000\000\000\000\000\000\
\025\000\000\000\002\000\000\000\000\000\000\000\000\000\019\000\
\024\000\000\000\000\000\000\000\000\000\001\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\023\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\017\000\018\000\000\000\000\000\000\000\000\000\000\000\
\004\000\003\000\000\000\000\000\000\000\005\000\006\000\000\000\
\000\000"

let yydgoto = "\002\000\
\009\000\010\000\050\000\018\000\012\000\013\000\014\000\015\000\
\016\000"

let yysindex = "\010\000\
\103\255\000\000\000\000\000\000\000\000\022\255\118\255\118\255\
\000\000\019\255\000\000\142\255\021\255\026\255\030\255\000\000\
\000\000\041\255\022\255\044\255\038\255\000\000\020\255\020\255\
\020\255\020\255\020\255\020\255\020\255\020\255\118\255\055\255\
\118\255\000\000\030\255\030\255\000\255\000\255\000\255\026\255\
\000\255\000\000\000\000\079\255\118\255\053\255\022\255\118\255\
\000\000\000\000\065\255\118\255\063\255\000\000\000\000\118\255\
\010\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\015\255\121\255\081\255\255\254\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\042\255\058\255\127\255\141\255\015\255\097\255\
\074\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\249\255\081\000\239\255\134\000\000\000\062\000\019\000\
\051\000"

let yytablesize = 162
let yytable = "\020\000\
\021\000\032\000\016\000\016\000\016\000\023\000\016\000\024\000\
\016\000\016\000\001\000\016\000\016\000\047\000\016\000\016\000\
\016\000\016\000\013\000\013\000\003\000\004\000\005\000\044\000\
\017\000\046\000\049\000\013\000\013\000\053\000\013\000\013\000\
\013\000\013\000\008\000\022\000\029\000\051\000\030\000\027\000\
\054\000\035\000\036\000\028\000\055\000\014\000\014\000\014\000\
\057\000\014\000\031\000\014\000\014\000\034\000\014\000\014\000\
\033\000\014\000\014\000\014\000\014\000\015\000\015\000\015\000\
\045\000\015\000\052\000\015\000\015\000\048\000\015\000\015\000\
\056\000\015\000\015\000\015\000\015\000\012\000\012\000\042\000\
\043\000\011\000\047\000\048\000\011\000\011\000\012\000\012\000\
\040\000\012\000\012\000\012\000\012\000\011\000\011\000\049\000\
\011\000\011\000\000\000\011\000\010\000\010\000\000\000\003\000\
\004\000\005\000\006\000\000\000\000\000\010\000\010\000\000\000\
\010\000\010\000\007\000\010\000\000\000\008\000\003\000\004\000\
\005\000\019\000\000\000\000\000\009\000\009\000\000\000\000\000\
\000\000\007\000\007\000\007\000\008\000\009\000\009\000\000\000\
\009\000\009\000\000\000\007\000\007\000\000\000\007\000\007\000\
\008\000\008\000\000\000\023\000\000\000\024\000\000\000\025\000\
\026\000\008\000\008\000\000\000\008\000\008\000\037\000\038\000\
\039\000\041\000"

let yycheck = "\007\000\
\008\000\019\000\004\001\005\001\006\001\006\001\008\001\008\001\
\010\001\011\001\001\000\013\001\014\001\004\001\016\001\017\001\
\018\001\019\001\004\001\005\001\001\001\002\001\003\001\031\000\
\003\001\033\000\017\001\013\001\014\001\047\000\016\001\017\001\
\018\001\019\001\015\001\017\001\007\001\045\000\009\001\019\001\
\048\000\023\000\024\000\018\001\052\000\004\001\005\001\006\001\
\056\000\008\001\010\001\010\001\011\001\016\001\013\001\014\001\
\013\001\016\001\017\001\018\001\019\001\004\001\005\001\006\001\
\010\001\008\001\014\001\010\001\011\001\005\001\013\001\014\001\
\010\001\016\001\017\001\018\001\019\001\004\001\005\001\029\000\
\030\000\001\000\004\001\005\001\004\001\005\001\013\001\014\001\
\027\000\016\001\017\001\018\001\019\001\013\001\014\001\017\001\
\016\001\017\001\255\255\019\001\004\001\005\001\255\255\001\001\
\002\001\003\001\004\001\255\255\255\255\013\001\014\001\255\255\
\016\001\017\001\012\001\019\001\255\255\015\001\001\001\002\001\
\003\001\004\001\255\255\255\255\004\001\005\001\255\255\255\255\
\255\255\012\001\004\001\005\001\015\001\013\001\014\001\255\255\
\016\001\017\001\255\255\013\001\014\001\255\255\016\001\017\001\
\004\001\005\001\255\255\006\001\255\255\008\001\255\255\010\001\
\011\001\013\001\014\001\255\255\016\001\017\001\025\000\026\000\
\027\000\028\000"

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
# 23 "parser.mly"
                  ( CExp _1 )
# 186 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 24 "parser.mly"
                  ( _1 )
# 193 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 27 "parser.mly"
                                  ( LLet (_2, _4, _5) )
# 202 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 28 "parser.mly"
                             ( CDecl (_2, _4) )
# 210 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 33 "parser.mly"
                                ( ELet(_2,_4,_6) )
# 219 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 34 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 228 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 35 "parser.mly"
                                ( EEq(_1,_3) )
# 236 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 36 "parser.mly"
                                ( ELt(_1,_3) )
# 244 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 37 "parser.mly"
                                  ( _1 )
# 251 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 41 "parser.mly"
                                 (EOr(_1,_3))
# 259 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 42 "parser.mly"
                    ( _1 )
# 266 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor2_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 46 "parser.mly"
                                ( EAnd(_1,_3))
# 274 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 47 "parser.mly"
                   ( _1 )
# 281 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 51 "parser.mly"
                                 ( EAdd(_1,_3) )
# 289 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 52 "parser.mly"
                                 ( ESub(_1,_3) )
# 297 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 53 "parser.mly"
                                 ( _1 )
# 304 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 57 "parser.mly"
                                  ( EMul(_1,_3) )
# 312 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 58 "parser.mly"
                                  ( EDiv(_1,_3) )
# 320 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 59 "parser.mly"
                                  ( _1 )
# 327 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 63 "parser.mly"
                   ( EConstInt(_1) )
# 334 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 64 "parser.mly"
                   ( EConstBool(_1) )
# 341 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "parser.mly"
                   ( EVar(_1) )
# 348 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 66 "parser.mly"
                   ( _2 )
# 355 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 70 "parser.mly"
       ( _1 )
# 362 "parser.ml"
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
