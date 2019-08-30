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
  | LETAND

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
  276 (* LETAND *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\004\000\004\000\005\000\003\000\
\003\000\002\000\002\000\002\000\002\000\008\000\008\000\009\000\
\009\000\007\000\007\000\007\000\010\000\010\000\010\000\011\000\
\011\000\011\000\011\000\006\000\000\000"

let yylen = "\002\000\
\002\000\001\000\005\000\003\000\005\000\003\000\005\000\005\000\
\005\000\006\000\003\000\003\000\001\000\003\000\001\000\003\000\
\001\000\003\000\003\000\001\000\003\000\003\000\001\000\001\000\
\001\000\001\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\024\000\025\000\026\000\000\000\000\000\000\000\
\029\000\000\000\002\000\000\000\000\000\000\000\000\000\023\000\
\028\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\004\000\000\000\000\000\027\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\021\000\022\000\000\000\000\000\000\000\
\003\000\000\000\009\000\000\000\008\000\000\000\000\000\000\000\
\000\000\010\000\000\000\000\000\000\000\000\000\000\000\005\000"

let yydgoto = "\002\000\
\009\000\010\000\053\000\018\000\019\000\057\000\012\000\013\000\
\014\000\015\000\016\000"

let yysindex = "\005\000\
\047\255\000\000\000\000\000\000\000\000\034\255\160\255\160\255\
\000\000\023\255\000\000\102\255\038\255\057\255\013\255\000\000\
\000\000\060\255\062\255\089\255\096\255\095\255\000\000\075\255\
\075\255\075\255\075\255\075\255\075\255\075\255\075\255\160\255\
\000\000\160\255\160\255\000\000\013\255\013\255\026\255\026\255\
\026\255\057\255\026\255\000\000\000\000\099\255\004\255\105\255\
\000\000\034\255\000\000\034\255\000\000\160\255\116\255\000\000\
\117\255\000\000\160\255\160\255\078\255\108\255\034\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\067\255\135\255\101\255\255\254\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\025\255\050\255\140\255\154\255\
\067\255\118\255\084\255\000\000\000\000\000\000\124\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\006\255\
\000\000\000\000\000\000\000\000\000\000\009\255\000\000\000\000"

let yygindex = "\000\000\
\000\000\249\255\129\000\044\000\000\000\252\255\065\000\000\000\
\105\000\049\000\094\000"

let yytablesize = 175
let yytable = "\021\000\
\022\000\020\000\020\000\020\000\020\000\001\000\020\000\050\000\
\020\000\020\000\005\000\020\000\020\000\006\000\020\000\020\000\
\020\000\020\000\020\000\030\000\051\000\031\000\007\000\052\000\
\046\000\006\000\047\000\048\000\018\000\018\000\018\000\024\000\
\018\000\025\000\018\000\018\000\017\000\018\000\018\000\023\000\
\018\000\018\000\018\000\018\000\018\000\055\000\058\000\003\000\
\004\000\005\000\006\000\061\000\062\000\019\000\019\000\019\000\
\028\000\019\000\007\000\019\000\019\000\008\000\019\000\019\000\
\032\000\019\000\019\000\019\000\019\000\019\000\017\000\017\000\
\037\000\038\000\029\000\003\000\004\000\005\000\033\000\017\000\
\017\000\050\000\017\000\017\000\017\000\017\000\017\000\016\000\
\016\000\008\000\039\000\040\000\041\000\043\000\051\000\056\000\
\016\000\016\000\034\000\016\000\016\000\016\000\016\000\016\000\
\015\000\015\000\064\000\024\000\035\000\025\000\036\000\026\000\
\027\000\015\000\015\000\049\000\015\000\015\000\054\000\015\000\
\015\000\014\000\014\000\044\000\045\000\059\000\060\000\063\000\
\006\000\011\000\014\000\014\000\042\000\014\000\014\000\000\000\
\014\000\014\000\013\000\013\000\000\000\000\000\000\000\011\000\
\011\000\000\000\000\000\013\000\013\000\000\000\013\000\013\000\
\011\000\011\000\013\000\011\000\011\000\012\000\012\000\011\000\
\003\000\004\000\005\000\000\000\000\000\000\000\012\000\012\000\
\000\000\012\000\012\000\007\000\000\000\012\000\008\000"

let yycheck = "\007\000\
\008\000\006\000\004\001\005\001\006\001\001\000\008\001\004\001\
\010\001\011\001\005\001\013\001\014\001\005\001\016\001\017\001\
\018\001\019\001\020\001\007\001\017\001\009\001\017\001\020\001\
\032\000\017\001\034\000\035\000\004\001\005\001\006\001\006\001\
\008\001\008\001\010\001\011\001\003\001\013\001\014\001\017\001\
\016\001\017\001\018\001\019\001\020\001\050\000\054\000\001\001\
\002\001\003\001\004\001\059\000\060\000\004\001\005\001\006\001\
\019\001\008\001\012\001\010\001\011\001\015\001\013\001\014\001\
\005\001\016\001\017\001\018\001\019\001\020\001\004\001\005\001\
\024\000\025\000\018\001\001\001\002\001\003\001\017\001\013\001\
\014\001\004\001\016\001\017\001\018\001\019\001\020\001\004\001\
\005\001\015\001\026\000\027\000\028\000\029\000\017\001\052\000\
\013\001\014\001\010\001\016\001\017\001\018\001\019\001\020\001\
\004\001\005\001\063\000\006\001\013\001\008\001\016\001\010\001\
\011\001\013\001\014\001\017\001\016\001\017\001\014\001\019\001\
\020\001\004\001\005\001\030\000\031\000\010\001\010\001\020\001\
\005\001\001\000\013\001\014\001\028\000\016\001\017\001\255\255\
\019\001\020\001\004\001\005\001\255\255\255\255\255\255\004\001\
\005\001\255\255\255\255\013\001\014\001\255\255\016\001\017\001\
\013\001\014\001\020\001\016\001\017\001\004\001\005\001\020\001\
\001\001\002\001\003\001\255\255\255\255\255\255\013\001\014\001\
\255\255\016\001\017\001\012\001\255\255\020\001\015\001"

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
# 23 "parser.mly"
                  ( CExp _1 )
# 188 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 24 "parser.mly"
                  ( _1 )
# 195 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'inbeforeexpr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 25 "parser.mly"
                                     ( LetIn (_2, _4) )
# 203 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'letandexpr) in
    Obj.repr(
# 26 "parser.mly"
                            ( _2 )
# 210 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'inbeforeexpr) in
    Obj.repr(
# 30 "parser.mly"
                                    ( LAnd ( _1, _3, _5) )
# 219 "parser.ml"
               : 'inbeforeexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 31 "parser.mly"
                ( ELet (_1, _3) )
# 227 "parser.ml"
               : 'inbeforeexpr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'inbeforeexpr) in
    Obj.repr(
# 35 "parser.mly"
                                    ( LAnd ( _1, _3, _5) )
# 236 "parser.ml"
               : 'letandexpr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 39 "parser.mly"
                                  ( LLet (_2, _4, _5) )
# 245 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 40 "parser.mly"
                             ( CDecl (_2, _4) )
# 253 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 262 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 45 "parser.mly"
                                ( EEq(_1,_3) )
# 270 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 46 "parser.mly"
                                ( ELt(_1,_3) )
# 278 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 47 "parser.mly"
                                  ( _1 )
# 285 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 51 "parser.mly"
                                 (EOr(_1,_3))
# 293 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 52 "parser.mly"
                    ( _1 )
# 300 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor2_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 56 "parser.mly"
                                ( EAnd(_1,_3))
# 308 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 57 "parser.mly"
                   ( _1 )
# 315 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 61 "parser.mly"
                                 ( EAdd(_1,_3) )
# 323 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 62 "parser.mly"
                                 ( ESub(_1,_3) )
# 331 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 63 "parser.mly"
                                 ( _1 )
# 338 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 67 "parser.mly"
                                  ( EMul(_1,_3) )
# 346 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 68 "parser.mly"
                                  ( EDiv(_1,_3) )
# 354 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 69 "parser.mly"
                                  ( _1 )
# 361 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 73 "parser.mly"
                   ( EConstInt(_1) )
# 368 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 74 "parser.mly"
                   ( EConstBool(_1) )
# 375 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 75 "parser.mly"
                   ( EVar(_1) )
# 382 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 76 "parser.mly"
                   ( _2 )
# 389 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 80 "parser.mly"
       ( _1 )
# 396 "parser.ml"
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
