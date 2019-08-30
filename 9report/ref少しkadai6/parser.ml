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
  | REC
  | LBRACKET
  | RBRACKET
  | CONS
  | COMMA
  | MATCH
  | WITH
  | BAR
  | SEMISEMI
  | CORON
  | REF
  | EXCLAM

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
# 39 "parser.ml"
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
  275 (* REC *);
  276 (* LBRACKET *);
  277 (* RBRACKET *);
  278 (* CONS *);
  279 (* COMMA *);
  280 (* MATCH *);
  281 (* WITH *);
  282 (* BAR *);
  283 (* SEMISEMI *);
  284 (* CORON *);
  285 (* REF *);
  286 (* EXCLAM *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* BOOL *);
  259 (* ID *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\005\000\005\000\007\000\007\000\008\000\008\000\008\000\008\000\
\008\000\008\000\006\000\006\000\004\000\004\000\004\000\009\000\
\009\000\009\000\010\000\010\000\011\000\011\000\011\000\011\000\
\011\000\011\000\011\000\003\000\000\000"

let yylen = "\002\000\
\002\000\005\000\006\000\007\000\001\000\006\000\008\000\006\000\
\004\000\003\000\003\000\004\000\005\000\001\000\007\000\004\000\
\003\000\005\000\003\000\001\000\001\000\001\000\001\000\005\000\
\002\000\003\000\003\000\001\000\003\000\003\000\001\000\003\000\
\003\000\001\000\002\000\001\000\001\000\001\000\005\000\002\000\
\001\000\003\000\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\005\000\037\000\038\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\045\000\000\000\000\000\
\000\000\014\000\000\000\000\000\036\000\044\000\000\000\000\000\
\000\000\000\000\000\000\000\000\040\000\000\000\043\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\041\000\035\000\000\000\000\000\000\000\000\000\000\000\042\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\027\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\009\000\021\000\022\000\000\000\000\000\
\000\000\023\000\012\000\000\000\000\000\016\000\000\000\000\000\
\000\000\002\000\000\000\000\000\000\000\000\000\039\000\000\000\
\025\000\013\000\000\000\000\000\000\000\000\000\003\000\006\000\
\000\000\000\000\008\000\026\000\000\000\000\000\019\000\000\000\
\004\000\015\000\000\000\000\000\000\000\007\000\024\000\018\000"

let yydgoto = "\002\000\
\014\000\015\000\016\000\017\000\075\000\018\000\076\000\077\000\
\019\000\020\000\021\000"

let yysindex = "\013\000\
\009\255\000\000\000\000\000\000\000\000\000\000\004\255\180\255\
\180\255\029\255\032\255\180\255\047\255\000\000\035\255\048\255\
\183\255\000\000\010\255\053\255\000\000\000\000\029\255\068\255\
\012\255\073\255\036\255\081\255\000\000\076\255\000\000\000\000\
\096\255\053\255\053\255\053\255\053\255\053\255\053\255\053\255\
\000\000\000\000\029\255\132\255\029\255\104\255\180\255\000\000\
\180\255\180\255\069\255\180\255\010\255\010\255\014\255\014\255\
\057\255\000\000\053\255\053\255\109\255\180\255\001\255\029\255\
\156\255\106\255\105\255\000\000\000\000\000\000\152\255\110\255\
\152\255\000\000\000\000\108\255\101\255\000\000\180\255\020\255\
\180\255\000\000\127\255\180\255\133\255\180\255\000\000\065\255\
\000\000\000\000\180\255\152\255\022\255\180\255\000\000\000\000\
\180\255\134\255\000\000\000\000\152\255\114\255\000\000\180\255\
\000\000\000\000\136\255\126\255\152\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\102\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\081\000\000\000\020\000\206\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\043\000\066\000\096\000\111\000\
\081\000\000\000\229\255\253\255\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\051\255\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\126\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\252\255\249\255\060\000\184\255\105\000\215\255\000\000\
\057\000\251\255\238\255"

let yytablesize = 409
let yytable = "\024\000\
\090\000\042\000\028\000\026\000\027\000\081\000\022\000\030\000\
\003\000\004\000\005\000\006\000\007\000\001\000\022\000\043\000\
\039\000\046\000\040\000\034\000\008\000\035\000\023\000\009\000\
\094\000\010\000\104\000\082\000\011\000\088\000\045\000\022\000\
\012\000\059\000\060\000\061\000\112\000\064\000\013\000\063\000\
\042\000\042\000\066\000\074\000\067\000\068\000\095\000\078\000\
\105\000\031\000\103\000\048\000\029\000\004\000\005\000\041\000\
\083\000\080\000\049\000\108\000\085\000\032\000\034\000\074\000\
\035\000\074\000\020\000\009\000\020\000\069\000\070\000\022\000\
\011\000\020\000\093\000\033\000\096\000\044\000\038\000\098\000\
\100\000\099\000\013\000\071\000\074\000\047\000\102\000\101\000\
\072\000\106\000\053\000\054\000\107\000\074\000\073\000\055\000\
\056\000\057\000\050\000\110\000\051\000\074\000\041\000\041\000\
\041\000\052\000\041\000\041\000\041\000\041\000\041\000\041\000\
\041\000\065\000\041\000\041\000\041\000\041\000\079\000\086\000\
\087\000\041\000\092\000\041\000\041\000\091\000\041\000\041\000\
\041\000\044\000\089\000\041\000\004\000\005\000\006\000\025\000\
\097\000\081\000\094\000\109\000\104\000\111\000\058\000\008\000\
\000\000\000\000\009\000\000\000\010\000\000\000\000\000\011\000\
\069\000\070\000\022\000\012\000\004\000\005\000\006\000\025\000\
\062\000\013\000\000\000\000\000\000\000\000\000\071\000\008\000\
\000\000\000\000\009\000\072\000\010\000\000\000\000\000\011\000\
\000\000\000\000\000\000\012\000\004\000\005\000\006\000\025\000\
\084\000\013\000\000\000\000\000\034\000\000\000\035\000\008\000\
\036\000\037\000\009\000\000\000\010\000\000\000\000\000\011\000\
\000\000\000\000\000\000\012\000\038\000\000\000\000\000\000\000\
\000\000\013\000\034\000\034\000\034\000\034\000\034\000\034\000\
\034\000\000\000\034\000\034\000\000\000\034\000\000\000\000\000\
\000\000\000\000\000\000\034\000\034\000\000\000\034\000\034\000\
\034\000\032\000\032\000\032\000\032\000\032\000\032\000\032\000\
\000\000\032\000\032\000\000\000\032\000\000\000\000\000\000\000\
\000\000\000\000\032\000\032\000\000\000\032\000\032\000\032\000\
\000\000\033\000\033\000\033\000\033\000\033\000\033\000\033\000\
\000\000\033\000\033\000\000\000\033\000\000\000\000\000\000\000\
\000\000\000\000\033\000\033\000\000\000\033\000\033\000\033\000\
\031\000\031\000\000\000\031\000\000\000\031\000\031\000\000\000\
\031\000\031\000\000\000\031\000\000\000\000\000\000\000\000\000\
\000\000\031\000\031\000\000\000\031\000\031\000\031\000\029\000\
\029\000\000\000\029\000\000\000\029\000\029\000\000\000\029\000\
\029\000\000\000\029\000\000\000\000\000\000\000\000\000\000\000\
\029\000\029\000\000\000\029\000\029\000\029\000\030\000\030\000\
\000\000\030\000\000\000\030\000\030\000\000\000\030\000\030\000\
\000\000\030\000\000\000\000\000\000\000\028\000\000\000\030\000\
\030\000\000\000\030\000\030\000\030\000\028\000\028\000\000\000\
\028\000\000\000\000\000\000\000\010\000\000\000\000\000\028\000\
\000\000\028\000\028\000\028\000\010\000\010\000\000\000\010\000\
\000\000\000\000\000\000\011\000\000\000\000\000\010\000\000\000\
\010\000\010\000\010\000\011\000\011\000\000\000\011\000\000\000\
\000\000\000\000\017\000\000\000\000\000\011\000\000\000\011\000\
\011\000\011\000\017\000\017\000\000\000\017\000\000\000\000\000\
\000\000\000\000\000\000\000\000\017\000\000\000\017\000\000\000\
\017\000"

let yycheck = "\007\000\
\073\000\020\000\010\000\008\000\009\000\005\001\003\001\012\000\
\000\001\001\001\002\001\003\001\004\001\001\000\003\001\023\000\
\007\001\025\000\009\001\006\001\012\001\008\001\019\001\015\001\
\005\001\017\001\005\001\027\001\020\001\071\000\019\001\003\001\
\024\001\039\000\040\000\043\000\109\000\045\000\030\001\044\000\
\059\000\060\000\047\000\051\000\049\000\050\000\027\001\052\000\
\027\001\003\001\092\000\016\001\021\001\001\001\002\001\003\001\
\064\000\062\000\023\001\101\000\065\000\027\001\006\001\071\000\
\008\001\073\000\016\001\015\001\018\001\001\001\002\001\003\001\
\020\001\023\001\079\000\028\001\081\000\010\001\022\001\084\000\
\016\001\086\000\030\001\015\001\092\000\013\001\091\000\023\001\
\020\001\094\000\034\000\035\000\097\000\101\000\026\001\036\000\
\037\000\038\000\018\001\104\000\025\001\109\000\001\001\002\001\
\003\001\010\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\010\001\013\001\014\001\015\001\016\001\010\001\014\001\
\016\001\020\001\022\001\022\001\023\001\018\001\025\001\026\001\
\027\001\028\001\021\001\030\001\001\001\002\001\003\001\004\001\
\010\001\005\001\005\001\026\001\005\001\016\001\038\000\012\001\
\255\255\255\255\015\001\255\255\017\001\255\255\255\255\020\001\
\001\001\002\001\003\001\024\001\001\001\002\001\003\001\004\001\
\029\001\030\001\255\255\255\255\255\255\255\255\015\001\012\001\
\255\255\255\255\015\001\020\001\017\001\255\255\255\255\020\001\
\255\255\255\255\255\255\024\001\001\001\002\001\003\001\004\001\
\029\001\030\001\255\255\255\255\006\001\255\255\008\001\012\001\
\010\001\011\001\015\001\255\255\017\001\255\255\255\255\020\001\
\255\255\255\255\255\255\024\001\022\001\255\255\255\255\255\255\
\255\255\030\001\005\001\006\001\007\001\008\001\009\001\010\001\
\011\001\255\255\013\001\014\001\255\255\016\001\255\255\255\255\
\255\255\255\255\255\255\022\001\023\001\255\255\025\001\026\001\
\027\001\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\255\255\013\001\014\001\255\255\016\001\255\255\255\255\255\255\
\255\255\255\255\022\001\023\001\255\255\025\001\026\001\027\001\
\255\255\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\255\255\013\001\014\001\255\255\016\001\255\255\255\255\255\255\
\255\255\255\255\022\001\023\001\255\255\025\001\026\001\027\001\
\005\001\006\001\255\255\008\001\255\255\010\001\011\001\255\255\
\013\001\014\001\255\255\016\001\255\255\255\255\255\255\255\255\
\255\255\022\001\023\001\255\255\025\001\026\001\027\001\005\001\
\006\001\255\255\008\001\255\255\010\001\011\001\255\255\013\001\
\014\001\255\255\016\001\255\255\255\255\255\255\255\255\255\255\
\022\001\023\001\255\255\025\001\026\001\027\001\005\001\006\001\
\255\255\008\001\255\255\010\001\011\001\255\255\013\001\014\001\
\255\255\016\001\255\255\255\255\255\255\005\001\255\255\022\001\
\023\001\255\255\025\001\026\001\027\001\013\001\014\001\255\255\
\016\001\255\255\255\255\255\255\005\001\255\255\255\255\023\001\
\255\255\025\001\026\001\027\001\013\001\014\001\255\255\016\001\
\255\255\255\255\255\255\005\001\255\255\255\255\023\001\255\255\
\025\001\026\001\027\001\013\001\014\001\255\255\016\001\255\255\
\255\255\255\255\005\001\255\255\255\255\023\001\255\255\025\001\
\026\001\027\001\013\001\014\001\255\255\016\001\255\255\255\255\
\255\255\255\255\255\255\255\255\023\001\255\255\025\001\255\255\
\027\001"

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
  REC\000\
  LBRACKET\000\
  RBRACKET\000\
  CONS\000\
  COMMA\000\
  MATCH\000\
  WITH\000\
  BAR\000\
  SEMISEMI\000\
  CORON\000\
  REF\000\
  EXCLAM\000\
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
# 28 "parser.mly"
                                     ( CExp _1 )
# 300 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 29 "parser.mly"
                                     ( CDecl (_2, _4) )
# 308 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _5 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 30 "parser.mly"
                                  ( CRef (_2,_5) )
# 316 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _6 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 31 "parser.mly"
                                     ( CRecDecl (_3,_4,_6) )
# 325 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    Obj.repr(
# 33 "parser.mly"
    ( failwith
        (Printf.printf "\027[38;5;1mError\027[0m";
		Printf.sprintf ": parse error near characters %d-%d"
           (Parsing.symbol_start ())
           (Parsing.symbol_end ())) )
# 335 "parser.ml"
               : Syntax.command))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 41 "parser.mly"
                                    ( ELet(_2,_4,_6) )
# 344 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _3 = (Parsing.peek_val __caml_parser_env 5 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'var) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 42 "parser.mly"
                                    ( ELetRec(_3,_4,_6,_8) )
# 354 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 43 "parser.mly"
                                    ( EIf(_2,_4,_6) )
# 363 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 44 "parser.mly"
                                    ( EFun(_2,_4) )
# 371 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 45 "parser.mly"
                                    ( EEq(_1,_3) )
# 379 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 46 "parser.mly"
                                    ( ELt(_1,_3) )
# 387 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'cases) in
    Obj.repr(
# 47 "parser.mly"
                                    ( EMatch(_2, _4) )
# 395 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'cases) in
    Obj.repr(
# 48 "parser.mly"
                                    ( EMatch(_2, _5) )
# 403 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list_expr) in
    Obj.repr(
# 49 "parser.mly"
                                    ( _1 )
# 410 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 5 : 'var) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 50 "parser.mly"
                                 ( ERefIn (_2,_5,_7) )
# 419 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'var) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 51 "parser.mly"
                         ( ERefSub(_1, _4) )
# 427 "parser.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 55 "parser.mly"
                                 ( [(_1, _3)] )
# 435 "parser.ml"
               : 'cases))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 4 : 'pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'expr) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : 'cases) in
    Obj.repr(
# 56 "parser.mly"
                                 ( (_1, _3) :: _5 )
# 444 "parser.ml"
               : 'cases))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'atomic_pattern) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'pattern) in
    Obj.repr(
# 60 "parser.mly"
                                     ( PCons(_1,_3) )
# 452 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_pattern) in
    Obj.repr(
# 61 "parser.mly"
                                     ( _1 )
# 459 "parser.ml"
               : 'pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 65 "parser.mly"
                                     ( PInt(_1) )
# 466 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 66 "parser.mly"
                                     ( PBool(_1) )
# 473 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'var) in
    Obj.repr(
# 67 "parser.mly"
                                     ( PVar(_1) )
# 480 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'pattern) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 68 "parser.mly"
                                     ( PPair(_2, _4) )
# 488 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
                                     ( PNil )
# 494 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'pattern) in
    Obj.repr(
# 70 "parser.mly"
                                     ( _2 )
# 501 "parser.ml"
               : 'atomic_pattern))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'list_expr) in
    Obj.repr(
# 74 "parser.mly"
                              ( ECons(_1, _3) )
# 509 "parser.ml"
               : 'list_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'arith_expr) in
    Obj.repr(
# 75 "parser.mly"
                              ( _1 )
# 516 "parser.ml"
               : 'list_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 79 "parser.mly"
                                 ( EAdd(_1,_3) )
# 524 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'arith_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 80 "parser.mly"
                                 ( ESub(_1,_3) )
# 532 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'factor_expr) in
    Obj.repr(
# 81 "parser.mly"
                                 ( _1 )
# 539 "parser.ml"
               : 'arith_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 85 "parser.mly"
                               ( EMul(_1,_3) )
# 547 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'factor_expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 86 "parser.mly"
                               ( EDiv(_1,_3) )
# 555 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'app_expr) in
    Obj.repr(
# 87 "parser.mly"
                               ( _1 )
# 562 "parser.ml"
               : 'factor_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'app_expr) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 91 "parser.mly"
                         ( EApp(_1, _2) )
# 570 "parser.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atomic_expr) in
    Obj.repr(
# 92 "parser.mly"
                         ( _1 )
# 577 "parser.ml"
               : 'app_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 95 "parser.mly"
                      ( EConstInt(_1) )
# 584 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : bool) in
    Obj.repr(
# 96 "parser.mly"
                      ( EConstBool(_1) )
# 591 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'expr) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 97 "parser.mly"
                              ( EPair(_2, _4) )
# 599 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    Obj.repr(
# 98 "parser.mly"
                      ( ENil )
# 605 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 99 "parser.mly"
                      ( EVar(_1) )
# 612 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    Obj.repr(
# 100 "parser.mly"
                      ( _2 )
# 619 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 101 "parser.mly"
                 ( RefExclam (_2) )
# 626 "parser.ml"
               : 'atomic_expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 105 "parser.mly"
       ( _1 )
# 633 "parser.ml"
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
