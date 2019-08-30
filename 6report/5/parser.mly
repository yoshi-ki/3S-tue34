%{
  open Syntax
  (* ここに書いたものは，ExampleParser.mliに入らないので注意 *)
%}

%token <int>    INT
%token <bool>   BOOL 
%token <string> ID
%token LET IN				  
%token PLUS TIMES MINUS DIV
%token EQ LT
%token IF THEN ELSE
%token LPAR RPAR 
%token FUN ARROW
%token SEMISEMI

%start toplevel 
%type <Syntax.command> toplevel
%% 

toplevel:
  | expr SEMISEMI { CExp $1 }
  | LET lvar EQ expr SEMISEMI { CDecl ($2, $4) }
;

expr:
  | LET lvar EQ expr IN expr     { ELet($2,$4,$6) }
  | IF expr THEN expr ELSE expr { EIf($2,$4,$6) }
  | FUN lvar ARROW expr          { EFun($2,$4) }
  | arith_expr EQ arith_expr    { EEq($1,$3) }
  | arith_expr LT arith_expr    { ELt($1,$3) }
  | arith_expr                  { $1 } 
;

arith_expr:
  | arith_expr PLUS factor_expr  { EAdd($1,$3) }
  | arith_expr MINUS factor_expr { ESub($1,$3) }
  | factor_expr                  { $1 }
;

factor_expr:
  | factor_expr TIMES app_expr { EMul($1,$3) }
  | factor_expr DIV app_expr   { EDiv($1,$3) }
  | app_expr                   { $1 }
;

app_expr:
  | atomic_expr lexpr { EApp($1, $2) }
  | atomic_expr          { $1 }
;

lexpr:
  | atomic_expr { [$1] }
  | atomic_expr lexpr { $1 :: $2 }
;

atomic_expr:
  | INT            { EConstInt($1) }
  | BOOL           { EConstBool($1) }
  | ID             { EVar($1) }
  | LPAR expr RPAR { $2 }
;

lvar:
  | ID { [$1] }
  | ID lvar { $1 :: $2 }
; 
