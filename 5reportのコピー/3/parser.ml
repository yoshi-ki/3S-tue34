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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
# 26 "parser.ml"
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
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\002\000\002\000\002\000\002\000\002\000\004\000\
\004\000\004\000\005\000\005\000\005\000\006\000\006\000\006\000\
\006\000\003\000\000\000"

let yylen = "\002\000\
\002\000\005\000\006\000\006\000\003\000\003\000\001\000\003\000\
\003\000\001\000\003\000\003\000\001\000\001\000\001\000\001\000\
\003\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\014\000\015\000\016\000\000\000\000\000\000\000\
\019\000\000\000\000\000\000\000\013\000\018\000\000\000\000\000\
\000\000\000\000\001\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\000\000\000\000\000\000\000\
\000\000\011\000\012\000\000\000\000\000\000\000\000\000\002\000\
\000\000\000\000\003\000\004\000"

let yydgoto = "\002\000\
\009\000\010\000\015\000\011\000\012\000\013\000"

let yysindex = "\013\000\
\001\255\000\000\000\000\000\000\000\000\015\255\005\255\005\255\
\000\000\021\255\081\255\016\255\000\000\000\000\012\255\015\255\
\013\255\032\255\000\000\009\255\009\255\009\255\009\255\009\255\
\009\255\005\255\041\255\005\255\000\000\016\255\016\255\037\255\
\037\255\000\000\000\000\010\255\005\255\042\255\005\255\000\000\
\053\255\005\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\056\255\023\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\036\255\049\255\062\255\
\069\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\249\255\048\000\058\000\073\000\071\000"

let yytablesize = 96
let yytable = "\017\000\
\018\000\003\000\004\000\005\000\006\000\003\000\004\000\005\000\
\016\000\003\000\004\000\005\000\007\000\001\000\039\000\008\000\
\007\000\014\000\036\000\008\000\038\000\026\000\024\000\008\000\
\025\000\028\000\040\000\010\000\010\000\041\000\010\000\043\000\
\010\000\010\000\044\000\010\000\010\000\019\000\010\000\010\000\
\008\000\008\000\020\000\008\000\021\000\008\000\008\000\029\000\
\008\000\008\000\037\000\008\000\008\000\009\000\009\000\042\000\
\009\000\039\000\009\000\009\000\007\000\009\000\009\000\027\000\
\009\000\009\000\005\000\000\000\007\000\007\000\000\000\007\000\
\007\000\006\000\005\000\005\000\000\000\005\000\005\000\032\000\
\033\000\006\000\006\000\000\000\006\000\006\000\020\000\000\000\
\021\000\000\000\022\000\023\000\030\000\031\000\034\000\035\000"

let yycheck = "\007\000\
\008\000\001\001\002\001\003\001\004\001\001\001\002\001\003\001\
\004\001\001\001\002\001\003\001\012\001\001\000\005\001\015\001\
\012\001\003\001\026\000\015\001\028\000\010\001\007\001\015\001\
\009\001\013\001\017\001\005\001\006\001\037\000\008\001\039\000\
\010\001\011\001\042\000\013\001\014\001\017\001\016\001\017\001\
\005\001\006\001\006\001\008\001\008\001\010\001\011\001\016\001\
\013\001\014\001\010\001\016\001\017\001\005\001\006\001\014\001\
\008\001\005\001\010\001\011\001\005\001\013\001\014\001\016\000\
\016\001\017\001\005\001\255\255\013\001\014\001\255\255\016\001\
\017\001\005\001\013\001\014\001\255\255\016\001\017\001\022\000\
\023\000\013\001\014\001\255\255\016\001\017\001\006\001\255\255\
\008\001\255\255\010\001\011\001\020\000\021\000\024\000\025\000"

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
# 21 "parser.mly"
                  ( CExp _1 )
# 149 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 22 "parser.mly"
                             ( CDecl (_2, _4) )
# 157 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 26 "parser.mly"
                                ( ELet(_2,_4,_6) )
# 166 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 27 "parser.mly"
                                ( EIf(_2,_4,_6) )
# 175 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 28 "parser.mly"
                                ( EEq(_1,_3) )
# 183 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 29 "parser.mly"
                                ( ELt(_1,_3) )
# 191 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 30 "parser.mly"
                                ( _1 )
# 198 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 34 "parser.mly"
                                 ( EAdd(_1,_3) )
# 206 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 35 "parser.mly"
                                 ( ESub(_1,_3) )
# 214 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 36 "parser.mly"
                                 ( _1 )
# 221 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 40 "parser.mly"
                                  ( EMul(_1,_3) )
# 229 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 41 "parser.mly"
                                  ( EDiv(_1,_3) )
# 237 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 42 "parser.mly"
                                  ( _1 )
# 244 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 46 "parser.mly"
                   ( EConstInt(_1) )
# 251 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 47 "parser.mly"
                   ( EConstBool(_1) )
# 258 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 48 "parser.mly"
                   ( EVar(_1) )
# 265 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 49 "parser.mly"
                   ( _2 )
# 272 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "parser.mly"
       ( _1 )
# 279 "parser.ml"
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
