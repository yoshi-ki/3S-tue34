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
%token SEMISEMI
%token AND OR
%token LLet

%start toplevel 
%type <Syntax.command> toplevel
%% 

toplevel:
  | expr SEMISEMI { CExp $1 }
  | letexpression { $1 }
;
letexpression:
  | LET var EQ expr letexpression { LLet ($2, $4, $5) }
  | LET var EQ expr SEMISEMI { CDecl ($2, $4) }
;


expr:
  | LET var EQ expr IN expr     { ELet($2,$4,$6) }
  | IF expr THEN expr ELSE expr { EIf($2,$4,$6) }
  | arith_expr EQ arith_expr    { EEq($1,$3) }
  | arith_expr LT arith_expr    { ELt($1,$3) }
  | boolian_expr                  { $1 }  
;

boolian_expr:
  | boolian_expr OR factor2_expr {EOr($1,$3)}
  | factor2_expr				{ $1 }
;

factor2_expr:
  | factor2_expr AND arith_expr { EAnd($1,$3)}
  | arith_expr					{ $1 }
;

arith_expr:
  | arith_expr PLUS factor_expr  { EAdd($1,$3) }
  | arith_expr MINUS factor_expr { ESub($1,$3) }
  | factor_expr                  { $1 }
;

factor_expr:
  | factor_expr TIMES atomic_expr { EMul($1,$3) }
  | factor_expr DIV atomic_expr   { EDiv($1,$3) }
  | atomic_expr                   { $1 }
;

atomic_expr:
  | INT            { EConstInt($1) }
  | BOOL           { EConstBool($1) }
  | ID             { EVar($1) }
  | LPAR expr RPAR { $2 }
;
 
var:
  | ID { $1 }
;
