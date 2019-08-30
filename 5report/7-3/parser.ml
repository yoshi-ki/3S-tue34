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
\001\000\001\000\001\000\001\000\002\000\002\000\007\000\007\000\
\005\000\005\000\004\000\004\000\003\000\003\000\008\000\008\000\
\009\000\009\000\009\000\010\000\010\000\010\000\011\000\011\000\
\011\000\012\000\012\000\012\000\012\000\006\000\000\000"

let yylen = "\002\000\
\005\000\002\000\001\000\006\000\005\000\003\000\005\000\004\000\
\005\000\005\000\006\000\001\000\003\000\001\000\003\000\001\000\
\003\000\003\000\001\000\003\000\003\000\001\000\003\000\003\000\
\001\000\001\000\001\000\001\000\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\026\000\027\000\028\000\000\000\000\000\000\000\
\031\000\000\000\000\000\003\000\000\000\016\000\000\000\000\000\
\025\000\030\000\000\000\000\000\000\000\000\000\000\000\002\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\029\000\000\000\015\000\000\000\000\000\000\000\
\000\000\023\000\024\000\000\000\000\000\000\000\001\000\000\000\
\010\000\000\000\009\000\000\000\000\000\005\000\000\000\004\000\
\000\000\000\000\000\000\000\000\000\000\008\000\000\000\007\000"

let yydgoto = "\002\000\
\009\000\054\000\010\000\011\000\051\000\055\000\056\000\013\000\
\014\000\015\000\016\000\017\000"

let yysindex = "\009\000\
\046\255\000\000\000\000\000\000\000\000\015\255\090\255\090\255\
\000\000\005\255\011\255\000\000\024\255\000\000\104\255\032\255\
\000\000\000\000\051\255\069\255\250\254\066\255\090\255\000\000\
\090\255\090\255\090\255\090\255\090\255\090\255\090\255\090\255\
\090\255\090\255\000\000\024\255\000\000\032\255\032\255\068\255\
\068\255\000\000\000\000\077\255\019\255\050\255\000\000\015\255\
\000\000\015\255\000\000\090\255\087\255\000\000\108\255\000\000\
\005\255\090\255\090\255\027\255\092\255\000\000\015\255\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\070\255\000\000\000\000\121\255\000\000\016\255\254\254\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\132\255\000\000\049\255\067\255\085\255\
\103\255\000\000\000\000\000\000\095\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\078\255\000\000\000\000\000\000\095\255\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\117\000\249\255\000\000\132\000\251\255\076\000\118\000\
\253\255\099\000\103\000\101\000"

let yytablesize = 153
let yytable = "\021\000\
\020\000\022\000\022\000\022\000\022\000\022\000\034\000\022\000\
\022\000\001\000\022\000\022\000\023\000\022\000\022\000\022\000\
\022\000\018\000\022\000\019\000\019\000\037\000\048\000\023\000\
\044\000\045\000\046\000\024\000\019\000\019\000\048\000\019\000\
\019\000\019\000\019\000\049\000\019\000\023\000\030\000\050\000\
\031\000\025\000\053\000\049\000\057\000\023\000\003\000\004\000\
\005\000\006\000\060\000\061\000\020\000\020\000\020\000\032\000\
\020\000\007\000\020\000\020\000\008\000\020\000\020\000\052\000\
\020\000\020\000\020\000\020\000\023\000\020\000\021\000\021\000\
\021\000\026\000\021\000\027\000\021\000\021\000\033\000\021\000\
\021\000\035\000\021\000\021\000\021\000\021\000\012\000\021\000\
\017\000\017\000\003\000\004\000\005\000\047\000\011\000\023\000\
\058\000\017\000\017\000\006\000\017\000\017\000\017\000\017\000\
\008\000\017\000\018\000\018\000\062\000\026\000\023\000\027\000\
\063\000\028\000\029\000\018\000\018\000\059\000\018\000\018\000\
\018\000\018\000\019\000\018\000\014\000\014\000\040\000\041\000\
\038\000\039\000\042\000\043\000\012\000\014\000\014\000\013\000\
\013\000\014\000\064\000\014\000\036\000\014\000\000\000\000\000\
\013\000\013\000\000\000\000\000\013\000\000\000\013\000\000\000\
\013\000"

let yycheck = "\007\000\
\006\000\004\001\005\001\006\001\008\000\008\001\013\001\010\001\
\011\001\001\000\013\001\014\001\019\001\016\001\017\001\018\001\
\019\001\003\001\021\001\004\001\005\001\025\000\004\001\019\001\
\032\000\033\000\034\000\017\001\013\001\014\001\004\001\016\001\
\017\001\018\001\019\001\017\001\021\001\019\001\007\001\021\001\
\009\001\018\001\048\000\017\001\052\000\019\001\001\001\002\001\
\003\001\004\001\058\000\059\000\004\001\005\001\006\001\005\001\
\008\001\012\001\010\001\011\001\015\001\013\001\014\001\014\001\
\016\001\017\001\018\001\019\001\019\001\021\001\004\001\005\001\
\006\001\006\001\008\001\008\001\010\001\011\001\010\001\013\001\
\014\001\016\001\016\001\017\001\018\001\019\001\017\001\021\001\
\004\001\005\001\001\001\002\001\003\001\017\001\017\001\019\001\
\010\001\013\001\014\001\005\001\016\001\017\001\018\001\019\001\
\015\001\021\001\004\001\005\001\017\001\006\001\019\001\008\001\
\021\001\010\001\011\001\013\001\014\001\010\001\016\001\017\001\
\018\001\019\001\006\000\021\001\004\001\005\001\028\000\029\000\
\026\000\027\000\030\000\031\000\001\000\013\001\014\001\004\001\
\005\001\017\001\063\000\019\001\023\000\021\001\255\255\255\255\
\013\001\014\001\255\255\255\255\017\001\255\255\019\001\255\255\
\021\001"

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
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'inbefore) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    Obj.repr(
# 24 "parser.mly"
                                          ( InEval (_2, _4) )
# 188 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'syntaxexpression) in
    Obj.repr(
# 25 "parser.mly"
                              ( CExp _1 )
# 195 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 26 "parser.mly"
                  ( _1 )
# 202 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'letandexpression) in
    Obj.repr(
# 27 "parser.mly"
                                                    ( AndLet ( _2, _4, _6) )
# 211 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'inbefore) in
    Obj.repr(
# 31 "parser.mly"
                                        ( TempListAdd (_1, _3, _5) )
# 220 "parser.ml"
               : 'inbefore))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 32 "parser.mly"
                        ( TempList (_1, _3) )
# 228 "parser.ml"
               : 'inbefore))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'letandexpression) in
    Obj.repr(
# 36 "parser.mly"
                                                ( AndLet (_1, _3, _5) )
# 237 "parser.ml"
               : 'letandexpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    Obj.repr(
# 37 "parser.mly"
                                 ( CDecl (_1, _3) )
# 245 "parser.ml"
               : 'letandexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'letexpression) in
    Obj.repr(
# 41 "parser.mly"
                                          ( LLet (_2, _4, _5) )
# 254 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'boolian_expr) in
    Obj.repr(
# 42 "parser.mly"
                                     ( CDecl (_2, _4) )
# 262 "parser.ml"
               : 'letexpression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'boolian_expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 46 "parser.mly"
                                                        ( EIf(_2,_4,_6) )
# 271 "parser.ml"
               : 'syntaxexpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boolian_expr) in
    Obj.repr(
# 47 "parser.mly"
                    ( _1 )
# 278 "parser.ml"
               : 'syntaxexpression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'boolian_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 51 "parser.mly"
                                 (EOr(_1,_3))
# 286 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor2_expr) in
    Obj.repr(
# 52 "parser.mly"
                                ( _1 )
# 293 "parser.ml"
               : 'boolian_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor2_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 56 "parser.mly"
                            ( EAnd(_1,_3))
# 301 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 57 "parser.mly"
                             ( _1 )
# 308 "parser.ml"
               : 'factor2_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 61 "parser.mly"
                                ( EEq(_1,_3) )
# 316 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 62 "parser.mly"
                                ( ELt(_1,_3) )
# 324 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 63 "parser.mly"
                                ( _1 )
# 331 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 68 "parser.mly"
                                 ( EAdd(_1,_3) )
# 339 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 69 "parser.mly"
                                 ( ESub(_1,_3) )
# 347 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 70 "parser.mly"
                                 ( _1 )
# 354 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 74 "parser.mly"
                                  ( EMul(_1,_3) )
# 362 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 75 "parser.mly"
                                  ( EDiv(_1,_3) )
# 370 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 76 "parser.mly"
                                  ( _1 )
# 377 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 80 "parser.mly"
                   ( EConstInt(_1) )
# 384 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 81 "parser.mly"
                   ( EConstBool(_1) )
# 391 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 82 "parser.mly"
                   ( EVar(_1) )
# 398 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 83 "parser.mly"
                   ( _2 )
# 405 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 87 "parser.mly"
       ( _1 )
# 412 "parser.ml"
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
